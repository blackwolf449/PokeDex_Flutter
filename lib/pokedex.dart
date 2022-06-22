import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/poke_request.dart';

class PokeDex extends StatefulWidget {
  const PokeDex({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PokeDexState();
  }
}

class _PokeDexState extends State<PokeDex> {
  String front =
      "https://natabox.s3.sa-east-1.amazonaws.com/mmtrtarRkmAQhqqzWpJQGIK3zZpaQ8IXNVCTWVD9.png";
  String back =
      "https://natabox.s3.sa-east-1.amazonaws.com/mmtrtarRkmAQhqqzWpJQGIK3zZpaQ8IXNVCTWVD9.png";
  String name = "";
  List<String> type = [];
  bool female = false;
  bool shyne = false;
  dynamic colorFemale = Colors.red[300];
  dynamic colorShyne = Colors.red[300];
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(30),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.red,
            ),
            child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Container(
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
                        onChanged: (value) async {
                          String name = value != '' ? value : 'none';
                          Status response = await login(name);
                          setState(() {
                            front = response.pokemon.front;
                            back = response.pokemon.back;
                            this.name = response.pokemon.name;
                            type = response.pokemon.type;
                          });
                        },
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
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                colorFemale = colorFemale == Colors.blue
                                    ? Colors.red[300]
                                    : Colors.blue;
                              });
                            },
                            child: const Text(
                              'Female',
                              style: TextStyle(fontSize: 20),
                            ),
                            style:
                                ElevatedButton.styleFrom(primary: colorFemale),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                setState(() {
                                  colorShyne = colorShyne == Colors.blue
                                      ? Colors.red[300]
                                      : Colors.blue;
                                });
                              });
                            },
                            child: const Text(
                              'Shyne',
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
