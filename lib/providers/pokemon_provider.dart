import 'package:flutter/material.dart';
import 'package:pokemon_app/data/pokemon_api.dart';
import 'package:pokemon_app/models/pokemon.dart';

class PokemonProvider extends ChangeNotifier {
  final List<Pokemon> _pokemonList = [];
  int _currentIndex = 0;
  bool _isLoading = true;
  String? _nextURL = 'https://pokeapi.co/api/v2/pokemon/?offset=0&limit=50';

  PokemonProvider() {
    loadPokemons();
  }

  Future<void> loadPokemons() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await fetchPokemons(_nextURL!);
      final pokemonNames = pokemonList.map((p) => p.name).toSet();
      final newPokemons = result.pokemons.where((p) => !pokemonNames.contains(p.name));
      _pokemonList.addAll(newPokemons);
      _nextURL = result.nextURL;
    } catch (e) {
      ();
    }
    _isLoading = false;
    notifyListeners();
  }
  
  List<Pokemon> get pokemonList => _pokemonList;
  Pokemon get currentPokemon => _pokemonList[_currentIndex];
  bool get isLoading => _isLoading;
  bool get hasNext => _nextURL != null;

  void getNext() {
    if (++_currentIndex >= _pokemonList.length && hasNext) {
      loadPokemons();
    } else if (_currentIndex >= _pokemonList.length) {
      _currentIndex = 0;
    }
    notifyListeners();
  }

  void getPrev() {
    if (--_currentIndex < 0) _currentIndex = _pokemonList.length - 1;
    notifyListeners();
  }
}