class Pokemon {
  final int id;
  final String name;
  final String imgURL;

  Pokemon({
    required this.id, 
    required this.name, 
    required this.imgURL, 
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'name': String name, 'url': String url} => () {
        final idString = Uri.parse(url).pathSegments.lastWhere((segment) => segment.isNotEmpty);
        final id = int.tryParse(idString) ?? 0;
        return Pokemon(
          id: id,
          name: name,
          imgURL: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/$id.png',
        );
      }(),
      _ => throw const FormatException('Invalid JSON format for Pokemon'),
    };
  }
}

class PokemonApiResult {
  final List<Pokemon> pokemons;
  final String? nextURL;

  PokemonApiResult({required this.pokemons, this.nextURL});

  factory PokemonApiResult.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'next': String? nextURL, 'results': List pokemons} => PokemonApiResult(
        pokemons: pokemons.map((pokemon) => Pokemon.fromJson(pokemon)).toList(),
        nextURL: nextURL,
        ),
      _ => throw const FormatException('Failed to load pokemons.'),
    };
  }
}