import 'package:flutter/material.dart';
import 'package:pokemon_app/models/pokemon.dart';


class FavoritesProvider extends ChangeNotifier {
  final List<Pokemon> _favoritesList = [];

  List<Pokemon> get favoritesList => _favoritesList;

  void toggleFavorite(Pokemon pokemon) {
    if (_favoritesList.contains(pokemon)) {
      _favoritesList.remove(pokemon);
    } else {
      _favoritesList.add(pokemon);
    }
    notifyListeners();
  }

  bool isFavorite(Pokemon pokemon) {
    return _favoritesList.contains(pokemon);
  }
}