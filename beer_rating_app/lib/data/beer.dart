class Beer {
  final String name;
  final String price;
  final double rating;
  final int reviews;
  final String imageUrl;
  final int id;

  Beer({required this.name, required this.price, required this.rating, required this.reviews, required this.imageUrl, required this.id});

  factory Beer.fromJson(Map<String, dynamic> json) {
    return Beer(
      name: json['name'],
      price: json['price'],
      rating: json['rating']['average'].toDouble(),
      reviews: json['rating']['reviews'],
      imageUrl: json['image'] ?? 'https://via.placeholder.com/150',
      id: json['id'],
    );
  }
}
