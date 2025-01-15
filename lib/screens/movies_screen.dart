import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/constants/my_theme_data.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/movies_provider.dart';
import 'package:mvvm_statemanagements/view_models/theme_provider.dart';
import 'package:mvvm_statemanagements/widgets/movies/movies_widget.dart';
import 'package:provider/provider.dart';

import 'favorites_screen.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //if you use this, the method build is every called when change state
    // ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    // log('rebuild');
    //solution is use the Consumer widget in part of the code
    //thath you update state
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
        actions: [
          IconButton(
            onPressed: () {
              // getIt<NavigationService>().showSnackbar();
              // getIt<NavigationService>().showDialog(MoviesWidget());
              getIt<NavigationService>().navigate(const FavoritesScreen());
            },
            icon: const Icon(
              MyAppIcons.favoriteRounded,
              color: Colors.red,
            ),
          ),
          Consumer(
            builder: (context, ThemeProvider themeProvider, child) => IconButton(
              onPressed: () async {
                await themeProvider.toggleTheme();
              },
              icon: Icon(
                themeProvider.themeData == MyThemeData.darkTheme ? MyAppIcons.lightMode : MyAppIcons.darkMode,
              ),
            ),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, MoviesProvider moviesProvider, child) {
          if (moviesProvider.isLoading && moviesProvider.moviesList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (moviesProvider.fetchMoviesError.isNotEmpty) {
            return Center(
              child: Text(moviesProvider.fetchMoviesError),
            );
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification.metrics.pixels == notification.metrics.maxScrollExtent && !moviesProvider.isLoading) {
                moviesProvider.getMovies();
                return true;
              }
              return false;
            },
            child: ListView.builder(
              itemCount: moviesProvider.moviesList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: moviesProvider.moviesList[index], child: const MoviesWidget());
              },
            ),
          );
        },
      ),
    );
  }
}
