import 'package:flutter/material.dart';
import 'package:pokemon_app/ui/pokemons_page.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_app/ui/single_browse_page.dart';
import 'package:pokemon_app/ui/favorites_page.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PokemonProvider(),
      child: PokemonApp(),
    )
    );
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
      ),
      home: PokemonHomePage(),
    );
  }
}

class PokemonHomePage extends StatefulWidget {
  const PokemonHomePage({super.key});

  @override
  State<PokemonHomePage> createState() => _PokemonHomePageState();
}

class _PokemonHomePageState extends State<PokemonHomePage> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    Widget page;
      switch (selectedIndex) {
        case 0:
          page = SingleBrowsePage();
        case 1:
          page = FavoritesPage();
        case 2:
          page = PokemonsListPage();
        default:
          throw UnimplementedError('no widget for $selectedIndex');
      }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('Pokemon App'),
      ),
      body: page,
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home'
            ),
          NavigationDestination(
            icon: Icon(Icons.favorite), 
            label: 'Favorites'
            ),
          NavigationDestination(
            icon: Icon(Icons.catching_pokemon), 
            label: 'Pokémons'
            ),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        ),
    );
  }
}