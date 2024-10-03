import 'package:api_pokemon/models/poke_Models.dart';
import 'package:dio/dio.dart';

class PokeServices {
  final Dio _dio = Dio();

  Future<List<PokeModel>> fetchPokemonsInfo() async {
    try {
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon?limit=50');

      if (response.statusCode == 200) {
        List results = response.data['results'];
        List<PokeModel> pokemons = [];

        for (var result in results) {
          var detailResponse = await _dio.get(result['url']);
          pokemons.add(PokeModel.fromJson(detailResponse.data));
        }
        return pokemons;

      } else {
        throw Exception(
            'Erro ao buscar os dados! Código: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar os dados: $e');
    }
  }
}
