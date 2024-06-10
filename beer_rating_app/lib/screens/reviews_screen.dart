import 'package:beer_rating_app/data/review.dart';
import 'package:beer_rating_app/data/sp_helper.dart';
import 'package:beer_rating_app/shared/menu_bottom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  List<Review> reviews = [];

  final SPHelper helper = SPHelper();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    helper.init().then((value) {
      updateScreen();
    });
    super.initState();
  }

  void searchBeers(String query) async {
    List<Review> result = helper.getReviews();
    result = result
        .where((beer) => beer.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      reviews = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: !isLandscape ? AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'My Reviews',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF2d2d2d),
      ) : null,
      bottomNavigationBar: MenuBottom(),
      backgroundColor: Color(0xFF2d2d2d),
      body: Column(
        children: [
          Padding(
            padding: !isLandscape ? EdgeInsets.symmetric(horizontal: 20, vertical: 10) : EdgeInsets.only(top: 30, bottom: 10, left: 20, right: 20),
            child: TextField(
              style: TextStyle(color: Colors.white),
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for reviews',
                hintStyle: TextStyle(color: Colors.white70),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    searchBeers(searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: getContent(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getContent() {
    List<Widget> tiles = [];
    reviews.forEach((review) {
      tiles.add(ListTile(
        leading: review.isBeer
            ? Icon(FontAwesomeIcons.beerMugEmpty, color: Color(0xFFf4cc2e))
            : Icon(FontAwesomeIcons.wineGlass, color: Colors.red),
        title: Text(
          review.name,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingBarIndicator(
              rating: review.userRating,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
              direction: Axis.horizontal,
            ),
            Text("${review.date}", style: TextStyle(color: Colors.white70)),
          ],
        ),
      ));
    });

    return tiles;
  }

  void updateScreen() {
    setState(() {
      reviews = helper.getReviews();
    });
  }
}
