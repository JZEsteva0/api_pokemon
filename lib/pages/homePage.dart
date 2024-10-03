import 'package:flutter/material.dart';
import 'package:api_pokemon/services/poke_Services.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final PokeServices _pokemonServices = PokeServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF000CAD),
        title: Text('Diário de POKÉMON'),
      ),
      body: FutureBuilder(
        future: _pokemonServices.fetchPokemonsInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final pokemons = snapshot.data!;
            return ListView.separated(
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = pokemons[index];
                return ListTile(
                  contentPadding: EdgeInsets.all(10),
                  title: Text(pokemon.name),
                  leading: Image.network(pokemon.image),
                  onTap: () {
                    // Get.to(() => DetailPokemonPage(pokemon: pokemon));
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            );
          } else {
            return Center(child: Text('Nenhum dado disponível'));
          }
        },
      ),
    );
  }
}
