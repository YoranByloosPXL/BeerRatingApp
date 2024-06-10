class Review {
  int id = 0;
  String name = '';
  String date = '';
  bool isBeer = true;
  double userRating = 0;

  Review(this.id, this.name, this.date, this.isBeer, this.userRating);

  Review.fromJson(Map<String, dynamic> reviewMap){
    id = reviewMap['id'] ?? 0;
    name = reviewMap['name'] ?? '';
    date = reviewMap['date'] ?? '';
    isBeer = reviewMap['isBeer'] ?? true;
    userRating = reviewMap['userRating'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'isBeer': isBeer,
      'userRating': userRating,
    };
  }
}