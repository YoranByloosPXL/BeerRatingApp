class Game {
  final String name;
  final String summary;
  final String coverUrl;

  Game({required this.name, required this.summary, required this.coverUrl});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      name: json['name'] ?? 'Unknown',
      summary: json['summary'] ?? 'No summary available',
      coverUrl: json['cover']['url'] ?? '',
    );
  }
}
