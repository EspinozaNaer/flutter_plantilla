import 'package:flutter/material.dart';
import 'package:superheroes/dao/superhero_dao.dart';
import 'package:superheroes/model/superhero.dart';
import 'package:superheroes/screens/widgets/superhero_list.dart';

class FavoriteListScreen extends StatefulWidget {
  const FavoriteListScreen({super.key});

  @override
  State<FavoriteListScreen> createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  List<Superhero> superheroes = [];
  final SuperHeroDao _superHeroDao = SuperHeroDao();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    try {
      List<Superhero> results = await _superHeroDao.getAll();

      if (mounted) {
        setState(() {
          superheroes = results;
        });
      }
    } catch (e) {
      print("Error fetching heroes: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Center(
        child: Column(
          children: [Expanded(child: SuperheroList(superheroes: superheroes))],
          ),
      ),
    );
  }
}