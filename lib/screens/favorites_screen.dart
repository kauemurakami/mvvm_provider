import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/view_models/favorites_provider.dart';
import 'package:mvvm_statemanagements/widgets/movies/movies_widget.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesProvider favoritesProvider = Provider.of<FavoritesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Movies"),
        actions: [
          IconButton(
            onPressed: () {
              favoritesProvider.clearFavorites();
            },
            icon: const Icon(
              MyAppIcons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: favoritesProvider.favoritesList.isEmpty
          ? const Center(
              child: Text(
                'You not add favorites movies',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
              ),
            )
          : ListView.builder(
              itemCount: favoritesProvider.favoritesList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: favoritesProvider.favoritesList[index], child: const MoviesWidget()); //const Text("data");
              },
            ),
    );
  }
}
