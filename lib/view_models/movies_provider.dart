import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';

class MoviesProvider with ChangeNotifier {
  List<MovieModel> _moviesList = [];
  List<MovieModel> get moviesList => _moviesList;

  List<MoviesGenre> _genresList = [];
  List<MoviesGenre> get genresList => _genresList;

  int _currentPage = 1;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _fetchMoviesError = '';
  String get fetchMoviesError => _fetchMoviesError;

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();

  Future<void> getMovies() async {
    _isLoading = true;
    notifyListeners();
    try {
      if (_genresList.isEmpty) {
        _genresList = await _moviesRepository.fetchGenres();
      }
      List<MovieModel> movies = await _moviesRepository.fetchMovies(page: _currentPage);
      _moviesList.addAll(movies);
      _currentPage++;
      _fetchMoviesError = '';
    } catch (e) {
      log('An error ocurred in fetch movies $e');
      _fetchMoviesError = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
