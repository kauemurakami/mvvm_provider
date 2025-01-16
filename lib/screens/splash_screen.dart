import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/favorites_provider.dart';
import 'package:mvvm_statemanagements/view_models/movies_provider.dart';
import 'package:mvvm_statemanagements/widgets/my_error_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _loadInitialData(BuildContext context) async {
    await Future.microtask(() async {
      if (context.mounted) {
        await Provider.of<FavoritesProvider>(context, listen: false).loadFavorites();

        await Provider.of<MoviesProvider>(context, listen: false).getMovies();
      }
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<MoviesProvider>(context, listen: false).getMovies();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final MoviesProvider moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: _loadInitialData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            if (moviesProvider.genresList.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                getIt<NavigationService>().navigateReplace(
                  const MoviesScreen(),
                );
              });
            }
            return Provider.of<MoviesProvider>(context).isLoading
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : MyErrorWidget(
                    errorText: snapshot.error.toString(),
                    retryFunction: () async {
                      await _loadInitialData(context);
                    },
                  );
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              getIt<NavigationService>().navigateReplace(
                const MoviesScreen(),
              );
            });
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
