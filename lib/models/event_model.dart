class Event {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final int capacity;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.capacity,
  });

  // Método para construir un evento desde un mapa JSON
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']), // Convierte la fecha en DateTime
      location: json['location'],
      capacity: json['capacity'],
    );
  }

  // Método opcional para convertir un objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'capacity': capacity,
    };
  }
}
