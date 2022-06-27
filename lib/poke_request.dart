import 'package:dio/dio.dart';
import 'package:pokedex/class/status.dart';
import 'package:pokedex/class/pokemon.dart';

final Dio dio = Dio();
const String url = 'https://pokeapi.co/api/v2/pokemon';

pokeSearch(String name, bool female, bool shiny) async {
  try {
    Response<dynamic> response = await dio.get("$url/$name");
    Response<dynamic> form = await dio.get(response.data['forms'][0]['url']);
    dynamic reqTypes = form.data['types'];
    List<String> arrTypes = [];
    for (int i = 0; i < reqTypes.length; i++) {
      arrTypes.add(reqTypes[i]['type']['name']);
    }
    List splash = splashArt(form, female, shiny);
    Pokemon pokemon = Pokemon(
        form.data['name'],
        form.data['sprites'][splash[0]],
        form.data['sprites'][splash[1]],
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

splashArt(form, female, shiny) {
  if (form.data['sprites']['front_shiny_female'] != null) {
    if (female && shiny) {
      return ['front_shiny_female', 'back_shiny_female'];
    }
    if (!female && shiny) {
      return ['front_shiny', 'back_shiny'];
    }
    if (female && !shiny) {
      return ['front_female', 'back_female'];
    }
    return ['front_default', 'back_default'];
  }
  if (form.data['sprites']['front_female'] == null &&
      form.data['sprites']['front_shiny'] != null) {
    if (shiny) {
      return ['front_shiny', 'back_shiny'];
    }
    return ['front_default', 'back_default'];
  }
  if (form.data['sprites']['front_female'] != null &&
      form.data['sprites']['front_shiny'] == null) {
    if (female) {
      return ['front_female', 'back_female'];
    }
    return ['front_default', 'back_default'];
  } else {
    return ['front_default', 'back_default'];
  }
}
