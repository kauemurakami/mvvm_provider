import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_constants.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  final List<MovieModel> _favoritesList = [];
  List<MovieModel> get favoritesList => _favoritesList;

  bool isFavorite(MovieModel movieModel) {
    return _favoritesList.any(
      (movie) => movie.id == movieModel.id,
    );
  }

  Future<void> addOrRemoveFavorite(MovieModel movieModel) async {
    if (isFavorite(movieModel)) {
      _favoritesList.removeWhere(
        (movie) => movie.id == movieModel.id,
      );
    } else {
      _favoritesList.add(movieModel);
    }
    await saveFavorites();
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> stringList = _favoritesList
        .map(
          (movie) => json.encode(
            movie.toJson(),
          ),
        )
        .toList();
    await prefs.setStringList(MyAppConstants.favoritesKey, stringList);
  }

  Future<void> loadFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> stringList = prefs.getStringList(MyAppConstants.favoritesKey) ?? [];
    _favoritesList.clear();
    _favoritesList.addAll(
      stringList.map(
        (movie) => MovieModel.fromJson(
          json.decode(movie),
        ),
      ),
    );
    notifyListeners();
  }

  void clearFavorites() async {
    _favoritesList.clear();
    notifyListeners();
    await saveFavorites();
  }
}
