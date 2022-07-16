import 'package:flutter/material.dart';
import 'package:pokedex/class/debounce.dart';
import 'package:pokedex/poke_request.dart';
import 'dart:async';
import 'package:pokedex/class/status.dart';

class PokeDex extends StatefulWidget {
  const PokeDex({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PokeDexState();
  }
}

class _PokeDexState extends State<PokeDex> {
  bool female = false;
  bool shiny = false;
  String front =
      "https://natabox.s3.sa-east-1.amazonaws.com/mmtrtarRkmAQhqqzWpJQGIK3zZpaQ8IXNVCTWVD9.png";
  String back =
      "https://natabox.s3.sa-east-1.amazonaws.com/mmtrtarRkmAQhqqzWpJQGIK3zZpaQ8IXNVCTWVD9.png";
  String name = "";
  List<String> type = [];
  dynamic colorFemale = Colors.red[300];
  dynamic colorShyne = Colors.red[300];
  TextEditingController pokeInput = TextEditingController();
  final Debounce _debounce = Debounce(milliseconds: 1000);

  setPokemon(value) async {
    String name = value.toString() != '' ? value.toString() : 'none';
    Status response = await pokeSearch(name, female, shiny);
    setState(() {
      front = response.pokemon.front;
      back = response.pokemon.back;
      this.name = response.pokemon.name;
      type = response.pokemon.type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(30),
        child: Container(
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.red,
            ),
            child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black,
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.network(front),
                                      Image.network(back),
                                    ]),
                                Text(
                                  name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  type.join(" ,"),
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ))),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: TextField(
                        controller: pokeInput,
                        onChanged: _debounce.run(() {
                          setPokemon(pokeInput.text);
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Search...',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                colorFemale = colorFemale == Colors.blue
                                    ? Colors.red[300]
                                    : Colors.blue;
                              });
                              female = !female;
                              setPokemon(pokeInput.text);
                            },
                            child: const Text(
                              'Female',
                              style: TextStyle(fontSize: 20),
                            ),
                            style:
                                ElevatedButton.styleFrom(primary: colorFemale),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                colorShyne = colorShyne == Colors.blue
                                    ? Colors.red[300]
                                    : Colors.blue;
                              });
                              shiny = !shiny;
                              setPokemon(pokeInput.text);
                            },
                            child: const Text(
                              'Shiny',
                              style: TextStyle(fontSize: 20),
                            ),
                            style:
                                ElevatedButton.styleFrom(primary: colorShyne),
                          )
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
