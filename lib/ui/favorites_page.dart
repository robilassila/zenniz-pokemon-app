import 'package:flutter/material.dart';
import 'package:pokemon_app/providers/favorites_provider.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {

    var favoritesProvider = context.watch<FavoritesProvider>();

    if (favoritesProvider.favoritesList.isEmpty) {
      return const Center(
        child: Card(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text('No favorite pokemons yet'),
          )
        ),
      );
    }

    return ListView(
      children: [
        for (var pokemon in favoritesProvider.favoritesList)
          Card(
            child: ListTile(
              leading: Image.network(
                pokemon.imgURL,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
              title: Text(pokemon.name),
              trailing: IconButton(
                icon: Icon(Icons.favorite_rounded),
                onPressed: () {
                  favoritesProvider.toggleFavorite(pokemon);
                },
              ),
            ),
          ),
      ],
    );
  }
}