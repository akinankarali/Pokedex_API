import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/model/pokedex.dart';
import 'package:pokedex/pokemon_detail.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  Pokedex pokedex;
  Future<Pokedex> data;

  Future<Pokedex> getPokemons() async {
    var response = await http.get(url);
    var decodedJson = json.decode(response.body);
    pokedex = Pokedex.fromJson(decodedJson);
    return pokedex;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return FutureBuilder(
                future: data,
                // ignore: missing_return
                builder: (context, AsyncSnapshot<Pokedex> responsePokemon) {
                  if (responsePokemon.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (responsePokemon.connectionState ==
                      ConnectionState.done) {
                    return GridView.count(
                      crossAxisCount: 2,
                      children: responsePokemon.data.pokemon.map((poke) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PokemonDetail(
                                      pokemon: poke,
                                    )));
                          },
                          child: Hero(
                              tag: poke.img,
                              child: Card(
                                elevation: 6,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 200,
                                      height: 150,
                                      child: FadeInImage.assetNetwork(
                                        placeholder: "assets/loading.gif",
                                        image: poke.img,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      poke.name,
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )),
                        );
                      }).toList(),
                    );
                  }
                });
          } else {
            return FutureBuilder(
                future: data,
                // ignore: missing_return
                builder: (context, AsyncSnapshot<Pokedex> responsePokemon) {
                  if (responsePokemon.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (responsePokemon.connectionState ==
                      ConnectionState.done) {
                    return GridView.extent(
                      maxCrossAxisExtent: 300,
                      children: responsePokemon.data.pokemon.map((poke) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PokemonDetail(
                                      pokemon: poke,
                                    )));
                          },
                          child: Hero(
                              tag: poke.img,
                              child: Card(
                                elevation: 6,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 200,
                                      height: 150,
                                      child: FadeInImage.assetNetwork(
                                        placeholder: "assets/loading.gif",
                                        image: poke.img,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      poke.name,
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )),
                        );
                      }).toList(),
                    );
                  }
                });
          }
        },
      ),
    );
  }
}
