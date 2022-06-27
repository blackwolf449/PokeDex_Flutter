import 'package:pokedex/class/pokemon.dart';

class Status {
  bool success;
  String message;
  Pokemon pokemon;

  Status(this.success, this.message, this.pokemon);
}
