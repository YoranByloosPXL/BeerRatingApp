import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuBottom extends StatelessWidget {
  const MenuBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      color: Color(0xFFf4cc2e),
      height: isLandscape ? 30.0 : kBottomNavigationBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            icon: FontAwesomeIcons.beerMugEmpty,
            label: 'Beers',
            isLandscape: isLandscape,
            route: '/',
          ),
          _buildNavItem(
            context,
            icon: FontAwesomeIcons.wineGlass,
            label: 'Wines',
            isLandscape: isLandscape,
            route: '/wines',
          ),
          _buildNavItem(
            context,
            icon: Icons.star,
            label: 'Reviews',
            isLandscape: isLandscape,
            route: '/reviews',
          ),
          _buildNavItem(
            context,
            icon: Icons.map,
            label: 'Map',
            isLandscape: isLandscape,
            route: '/map',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context,
      {required IconData icon,
      required String label,
      required bool isLandscape,
      required String route}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          if (!isLandscape) Text(label, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
