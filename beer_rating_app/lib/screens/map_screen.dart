import 'package:beer_rating_app/shared/menu_bottom.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Brewery Map',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF2d2d2d),
      ),
      bottomNavigationBar: MenuBottom(),
      backgroundColor: Color(0xFF2d2d2d),
    );
  }
}
