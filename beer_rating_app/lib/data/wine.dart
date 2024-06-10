class Wine {
  final String name;
  final String rating;
  final String reviews;
  final String location;
  final String imageUrl;
  final int id;

  Wine({required this.name, required this.rating, required this.location, required this.reviews, required this.imageUrl, required this.id});

  factory Wine.fromJson(Map<String, dynamic> json) {
    return Wine(
      name: json['wine'],
      rating: json['rating']['average'],
      reviews: json['rating']['reviews'],
      location: json['location'],
      imageUrl: json['image'] ?? 'https://via.placeholder.com/150',
      id: json['id'],
    );
  }
}
