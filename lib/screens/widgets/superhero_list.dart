import 'package:flutter/material.dart';
import 'package:superheroes/model/superhero.dart';
import 'package:superheroes/screens/widgets/superhero_card.dart';

class SuperheroList extends StatelessWidget {
  const SuperheroList({super.key, required this.superheroes});
  final List<Superhero> superheroes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: superheroes.length,
      itemBuilder: (context, index) {
        return SuperheroCard(superhero: superheroes[index]);
      });
  }
}