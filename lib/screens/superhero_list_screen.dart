import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superheroes/model/superhero.dart';
import 'package:superheroes/screens/widgets/custom_search_bar.dart';
import 'package:superheroes/screens/widgets/superhero_list.dart';
import 'package:superheroes/services/superhero_service.dart';

class SuperheroListScreen extends StatefulWidget {
  const SuperheroListScreen({super.key});

  @override
  State<SuperheroListScreen> createState() => _SuperheroListScreenState();
}

class _SuperheroListScreenState extends State<SuperheroListScreen> {
  List<Superhero> superheroes = [];
  final SuperHeroService superHeroService = SuperHeroService();
  int heroesCount = 0;

  Future<void> fetchHeroes(String value) async {
    if (value.isEmpty) {
      return;
    }

    try {
      List<Superhero> result = await superHeroService.searchHeroes(value) as List<Superhero>;
      setState(() {
        superheroes = result;
        heroesCount = result.length;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('heroes_count', superheroes.length);
    } catch (e) {
      print("Error fetching heroes: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Superheroes'),
      ),
      body: Center(
        child: Column(
          children: [
            CustomSearchBar(callback: (value) {
              fetchHeroes(value);
            },
          ),
          const SizedBox(height: 20),
          Text('Number of results: $heroesCount'),
          const SizedBox(height: 15),
          Expanded(child: SuperheroList(superheroes: superheroes))
          ],
        ),
      ),
    );
  }
}