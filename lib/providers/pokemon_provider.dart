import 'package:flutter/material.dart';
import 'package:pokemon_app/data/pokemon_api.dart';
import 'package:pokemon_app/models/pokemon.dart';

class PokemonProvider extends ChangeNotifier {
  List<Pokemon> _pokemonList = [];
  int _currentIndex = 0;
  bool _isLoading = true;
  String? _nextURL = 'https://pokeapi.co/api/v2/pokemon/?limit=20&offset=0';

  PokemonProvider() {
    loadPokemons();
  }

  Future<void> loadPokemons() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await fetchPokemons(_nextURL!);
      _pokemonList = result.pokemons;
      _nextURL = result.nextURL;
    } catch (e) {
      print(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }
  
  List<Pokemon> get pokemonList => _pokemonList;
  Pokemon get currentPokemon => _pokemonList[_currentIndex];
  bool get isLoading => _isLoading;

  void getNext() {
    if (++_currentIndex >= _pokemonList.length) _currentIndex = 0;
    notifyListeners();
  }
  void getPrev() {
    if (--_currentIndex < 0) _currentIndex = _pokemonList.length - 1;
    notifyListeners();
  }
}