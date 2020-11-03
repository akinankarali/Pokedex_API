import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/model/pokedex.dart';

class PokemonDetail extends StatelessWidget {
  Pokemon pokemon;

  PokemonDetail({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade200,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          pokemon.name,
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height * (2 / 3),
            width: MediaQuery.of(context).size.width - 20,
            left: 10,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    pokemon.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Height: " + pokemon.height,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Weight: " + pokemon.weight,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Weaknesses: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.weaknesses != null
                          ? pokemon.weaknesses
                              .map((weakness) => Chip(
                                    backgroundColor: Colors.red.shade300,
                                    label: Text(
                                      weakness,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ))
                              .toList()
                          : [Text(pokemon.name + " has no weakness")]),
                  Text(
                    "Next Evelution: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.nextEvolution != null
                          ? pokemon.nextEvolution
                              .map((evelution) => Chip(
                                    backgroundColor: Colors.red.shade300,
                                    label: Text(
                                      evelution.name,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ))
                              .toList()
                          : [
                              Text(
                                pokemon.name + " does not evolve any more",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red.shade300),
                              )
                            ]),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
                tag: pokemon.img,
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image.network(
                    pokemon.img,
                    fit: BoxFit.contain,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
