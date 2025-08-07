import 'package:flutter/material.dart';
import 'package:pokemon_app/providers/favorites_provider.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:pokemon_app/providers/scroll_pos_provider.dart';
import 'package:provider/provider.dart';

class PokemonsListPage extends StatefulWidget {
  const PokemonsListPage({super.key});

  @override
  State<PokemonsListPage> createState() => _PokemonsListPageState();
}

class _PokemonsListPageState extends State<PokemonsListPage> {

  final _scrollController = ScrollController();

  void _loadMore() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && context.read<PokemonProvider>().hasNext) {
      setState(() {
        context.read<PokemonProvider>().loadPokemons();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    final scrollProvider = context.read<ScrollPosProvider>();
    if (scrollProvider.scrollOffset > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(scrollProvider.scrollOffset);
      });
    }

    _scrollController.addListener(() {
      scrollProvider.updateScrollOffset(_scrollController.offset);
    });
    _scrollController.addListener(_loadMore);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var favoritesProvider = context.watch<FavoritesProvider>();
    var pokemonProvider = context.watch<PokemonProvider>();

    return ListView.builder(
      controller: _scrollController,
      itemCount: pokemonProvider.pokemonList.length + (pokemonProvider.isLoading && pokemonProvider.hasNext ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == pokemonProvider.pokemonList.length) {
          return Padding(
            padding: EdgeInsets.all(8), 
            child: Center(child: CircularProgressIndicator()),
          );
        } else { 
          return Card(
            child: ListTile(
              leading: Image.network(
                pokemonProvider.pokemonList[index].imgURL,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
              title: Text(pokemonProvider.pokemonList[index].name),
              trailing: IconButton(
                icon: Icon(favoritesProvider.isFavorite(pokemonProvider.pokemonList[index]) ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  favoritesProvider.toggleFavorite(pokemonProvider.pokemonList[index]);
                },
              ),
            )
          );
        }
      }
    );
  }
}