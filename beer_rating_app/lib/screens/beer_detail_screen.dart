import 'package:beer_rating_app/data/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../data/beer.dart';
import '../data/sp_helper.dart';

class BeerDetailScreen extends StatelessWidget {
  final Beer beer;
  final SPHelper helper = SPHelper();

  BeerDetailScreen({super.key, required this.beer});

  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtDuration = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: !isLandscape
          ? AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                "Beer Detail",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Color(0xFF2d2d2d),
            )
          : null,
      backgroundColor: Color(0xFF2d2d2d),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      beer.name,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      beer.price,
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Rating: ${beer.rating.toStringAsFixed(2)} (${beer.reviews} reviews)',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(25),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFf4cc2e),
                          ),
                          child: Text(
                            'Add review',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                          onPressed: () {
                            showReviewDialog(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> showReviewDialog(BuildContext context) async {
    double userRating = 0.0;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF2d2d2d),
            title: Text(
              beer.name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RatingBar.builder(
                    initialRating: userRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 35,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      size: 5,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      userRating = rating;
                    },
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  txtDescription.text = "";
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  saveReview(userRating);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFf4cc2e)),
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  Future saveReview(double userRating) async {
    DateTime now = DateTime.now();
    String today = '${now.year}-${now.month}-${now.day}';
    int id = helper.getCounter() + 1;
    
    Review newReview = Review(id, beer.name, today, true, userRating);
    helper.writeReview(newReview).then((_) {
      helper.setCounter();
    });
  }
}
