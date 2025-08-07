import 'package:flutter/material.dart';
import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/providers/favorites_provider.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class PokemonSearchDelegate extends SearchDelegate {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var pokemonProvider = context.watch<PokemonProvider>();
    final List<Pokemon> searchResults = pokemonProvider.pokemonList
      .where((pokemon) => pokemon.name.toLowerCase().contains(query.toLowerCase()))
      .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].name),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var pokemonProvider = context.watch<PokemonProvider>();
    var favoritesProvider = context.watch<FavoritesProvider>();
    final List<Pokemon> suggestionList = query.isEmpty
      ? []
      : pokemonProvider.pokemonList
          .where((pokemon) => pokemon.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(
            suggestionList[index].imgURL,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
          ),
          title: Text(suggestionList[index].name),
          trailing: IconButton(
            icon: Icon(favoritesProvider.isFavorite(suggestionList[index]) ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              favoritesProvider.toggleFavorite(suggestionList[index]);
            },
          ),
          onTap: () => query = suggestionList[index].name,
        );
      },
    );
  }
}