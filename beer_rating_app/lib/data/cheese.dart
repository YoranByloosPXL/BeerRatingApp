class Cheese {
  final String productName;
  final String brand;
  final String ingredientsText;
  final String imageUrl;

  Cheese({required this.productName, required this.brand, required this.ingredientsText, required this.imageUrl});

  factory Cheese.fromJson(Map<String, dynamic> json) {
    return Cheese(
      productName: json['product_name'] ?? 'Unknown',
      brand: json['brands'] ?? 'Unknown',
      ingredientsText: json['ingredients_text'] ?? 'No ingredients listed',
      imageUrl: json['image_url'] ?? '',
    );
  }
}
