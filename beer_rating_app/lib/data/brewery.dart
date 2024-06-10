class Brewery {
  final String name;
  final String city;
  final String state;

  Brewery({required this.name, required this.city, required this.state});

  factory Brewery.fromJson(Map<String, dynamic> json) {
    return Brewery(
      name: json['name'],
      city: json['city'],
      state: json['state'],
    );
  }
}
