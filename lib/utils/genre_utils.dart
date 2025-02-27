import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/view_models/movies_provider.dart';
import 'package:provider/provider.dart';

class GenreUtils {
  static List<MoviesGenre> movieGenresNames(List<int> genreIds, BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    final moviesRepository = getIt<MoviesRepository>();
    final cachedGenres = moviesProvider.genresList;
    List<MoviesGenre> genresNames = [];
    for (var genreId in genreIds) {
      var genre = cachedGenres.firstWhere(
        (g) => g.id == genreId,
        orElse: () => MoviesGenre(id: 5448484, name: 'Unknown'),
      );
      genresNames.add(genre);
    }
    return genresNames;
  }
}
