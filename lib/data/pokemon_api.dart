import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon_app/models/pokemon.dart';

Future<PokemonApiResult> fetchPokemons(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return PokemonApiResult.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load pokemons.');
  }
}