class Habit {
  final String id;
  final String name;
  final String description;

  Habit({required this.id, required this.name, required this.description});

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
