import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:pokemon_app/providers/favorites_provider.dart';

class SingleBrowsePage extends StatelessWidget {
  const SingleBrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    var pokemonProvider = context.watch<PokemonProvider>();
    var favoritesProvider = context.watch<FavoritesProvider>();

    if (pokemonProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    Pokemon currentPokemon = pokemonProvider.currentPokemon;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: GestureDetector(
            key: ValueKey(currentPokemon.id),
            onDoubleTap: () {
              favoritesProvider.toggleFavorite(currentPokemon);
            },
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity != null) {
                if (details.primaryVelocity! < 0) {
                  pokemonProvider.getNext();
                } else if (details.primaryVelocity! > 0) {
                  pokemonProvider.getPrev();
                }
              }
            },
            child: Image.network(
              currentPokemon.imgURL,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(
                  height: 400,
                  child: Center(child: CircularProgressIndicator()),
                );
                },
              ),
          ),
          ),

        SizedBox(height: 20),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Card(
            key: ValueKey(currentPokemon.id),
            color: theme.colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                currentPokemon.name,
                style: style,
                ),
            ),
          ),
        ),

        SizedBox(height: 20),

        Row(
          mainAxisSize: MainAxisSize.max,
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                pokemonProvider.getPrev();
              }, 
              icon: Icon(Icons.skip_previous),
              label: Text('Prev'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                favoritesProvider.toggleFavorite(currentPokemon);
              }, 
              icon: Icon(favoritesProvider.isFavorite(currentPokemon) ? Icons.favorite : Icons.favorite_border),
              label: Text('Like'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                pokemonProvider.getNext();
              }, 
              label: Text('Next'),
              icon: Icon(Icons.skip_next),
            ),
          ],
        )
      ],
    );
  }
}