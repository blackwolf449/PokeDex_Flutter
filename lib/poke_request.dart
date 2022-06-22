import 'dart:ffi';

import 'package:dio/dio.dart';

final Dio dio = Dio();
const String url = 'https://pokeapi.co/api/v2/pokemon';

login(name) async {
  try {
    Response<dynamic> response = await dio.get("$url/$name");
    Response<dynamic> form = await dio.get(response.data['forms'][0]['url']);
    dynamic reqTypes = form.data['types'];
    List<String> arrTypes = [];
    for (int i = 0; i < reqTypes.length; i++) {
      arrTypes.add(reqTypes[i]['type']['name']);
    }
    Pokemon pokemon = Pokemon(
        form.data['name'],
        form.data['sprites']['front_default'],
        form.data['sprites']['back_default'],
        arrTypes);
    Status success = Status(true, 'deu certo', pokemon);
    return success;
  } on DioError catch (e) {
    Pokemon pokemon = Pokemon(
        '',
        'https://natabox.s3.sa-east-1.amazonaws.com/mmtrtarRkmAQhqqzWpJQGIK3zZpaQ8IXNVCTWVD9.png',
        'https://natabox.s3.sa-east-1.amazonaws.com/mmtrtarRkmAQhqqzWpJQGIK3zZpaQ8IXNVCTWVD9.png',
        []);
    Status erro = Status(false, 'Algo deu errado\n Erro: $e', pokemon);
    return erro;
  }
}

class Pokemon {
  String name;
  String front;
  String back;
  List<String> type;

  Pokemon(this.name, this.front, this.back, this.type);
}

class Status {
  bool success;
  String message;
  Pokemon pokemon;

  Status(this.success, this.message, this.pokemon);
}
