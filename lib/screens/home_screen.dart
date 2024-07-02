import 'package:flutter/material.dart';
import 'package:superheroes/screens/favorite_list_screen.dart';
import 'package:superheroes/screens/superhero_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _tabs = const [
    SuperheroListScreen(),
    FavoriteListScreen()
  ];

  
  final List<BottomNavigationBarItem> _options = const [
    BottomNavigationBarItem(icon: Icon(Icons.search), label: "Superheroes"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _options,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }}