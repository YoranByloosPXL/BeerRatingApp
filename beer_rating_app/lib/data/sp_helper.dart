import 'package:shared_preferences/shared_preferences.dart';
import 'review.dart';
import 'dart:convert';

class SPHelper {
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writeReview(Review review) async {
    prefs.setString(review.id.toString(), json.encode(review.toJson()));
  }

  List<Review> getReviews() {
    List<Review> reviews = [];
    Set<String> keys = prefs.getKeys();
    for (var key in keys) {
      if (key != 'counter') {
        Review review =
            Review.fromJson(json.decode(prefs.getString(key) ?? ''));
        reviews.add(review);
      }
    } 

    return reviews;
  }

  Future setCounter() async {
    int counter = prefs.getInt('counter') ?? 0;
    counter++;
    await prefs.setInt('counter', counter);
  }

  int getCounter() {
    return prefs.getInt('counter') ?? 0;
  }
}
