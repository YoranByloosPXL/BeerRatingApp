import 'dart:convert';
import 'package:beer_rating_app/data/wine.dart';
import 'package:http/http.dart' as http;
import 'beer.dart';

class HttpHelper {
  final String baseUrl = 'api.sampleapis.com';

  //beers
  final String alesPath = 'beers/ale';
  final String stoutsPath = 'beers/stouts';

  //wines
  final String redsPath = 'wines/reds';
  final String whitesPath = 'wines/whites';
  final String sparklingPath = 'wines/sparkling';
  final String rosePath = 'wines/rose';
  final String dessertPath = 'wines/dessert';
  final String portPath = 'wines/port';

  //beersApi
  Future<List<Beer>> getBeers(String path) async {
    Uri uri = Uri.https(baseUrl, path);
    http.Response result = await http.get(uri);

    if (result.statusCode == 200) {
      List<dynamic> data = json.decode(result.body);
      return data.map((beerData) => Beer.fromJson(beerData)).toList();
    } else {
      throw Exception('Failed to load beers');
    }
  }

  Future<List<Beer>> getAles() async {
    return await getBeers(alesPath);
  }

  Future<List<Beer>> getStouts() async {
    return await getBeers(stoutsPath);
  }

  //winesApi
  Future<List<Wine>> getWines(String path) async {
    Uri uri = Uri.https(baseUrl, path);
    http.Response result = await http.get(uri);

    if (result.statusCode == 200) {
      List<dynamic> data = json.decode(result.body);
      return data.map((wineData) => Wine.fromJson(wineData)).toList();
    } else {
      throw Exception('Failed to load wines');
    }
  }

  Future<List<Wine>> getReds() async {
    return await getWines(redsPath);
  }

  Future<List<Wine>> getWhites() async {
    return await getWines(whitesPath);
  }

  Future<List<Wine>> getRose() async {
    return await getWines(rosePath);
  }
}
