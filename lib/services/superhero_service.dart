import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'package:superheroes/model/superhero.dart';

class SuperHeroService {
  final String baseUrl = "https://www.superheroapi.com/api.php/10157703717092094/search/";

  Future<List> searchHeroes(String name) async {
    http.Response response = await http.get(Uri.parse("$baseUrl$name"));
    if (response.statusCode == HttpStatus.ok) {
      final Map<String, dynamic> responseMap = json.decode(response.body);
      List<dynamic> results = responseMap["results"];
      return results.map((map) => Superhero.fromJson(map)).toList();
    } else {
      print("Error: ${response.statusCode}");
    }
    return [];
  }
}