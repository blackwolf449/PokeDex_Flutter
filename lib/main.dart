import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Pokedex in flutter')),
            body: const PokeDex()));
  }
}
