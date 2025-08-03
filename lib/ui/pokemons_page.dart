import 'package:flutter/material.dart';
import 'package:pokemon_app/providers/favorites_provider.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class PokemonsListPage extends StatelessWidget {
  const PokemonsListPage({super.key});

  @override
  Widget build(BuildContext context) {

    var pokemonProvider = context.watch<PokemonProvider>();
    var favoritesProvider = context.watch<FavoritesProvider>();

    return ListView(
      children: [
        for (var pokemon in pokemonProvider.pokemonList)
          Card(
            child: ListTile(
              leading: Image.network(pokemon.imgURL),
              title: Text(pokemon.name),
              trailing: IconButton(
                icon: Icon(favoritesProvider.isFavorite(pokemon) ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  favoritesProvider.toggleFavorite(pokemon);
                },
                ),
            ),
          )
      ],
    );
  }
}