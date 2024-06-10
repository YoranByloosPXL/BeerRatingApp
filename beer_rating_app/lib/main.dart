import 'package:beer_rating_app/screens/home_screen.dart';
import 'package:beer_rating_app/screens/map_screen.dart';
import 'package:beer_rating_app/screens/reviews_screen.dart';
import 'package:beer_rating_app/screens/wines_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BeerApp());
}

class BeerApp extends StatelessWidget {
  const BeerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomeScreen(),
        '/wines': (context) => WinesScreen(),
        '/reviews': (context) => ReviewsScreen(),
        '/map': (context) => MapScreen(),
      },
      initialRoute: '/',
    );
  }
}