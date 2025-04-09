// Modelo que representa un comentario o retroalimentación anónima
class FeedbackModel {
  final int id; // Identificador único (puede ser un timestamp)
  final String message; // Mensaje del comentario
  final DateTime timestamp; // Fecha y hora de envío
  final String eventId; // ID del evento al que pertenece el comentario

FeedbackModel({
  required this.id,
  required this.message,
  required this.timestamp,
  required this.eventId,
});

  // Crear objeto FeedbackModel desde un mapa
  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
      eventId: json['eventId'],
    );
  }

  // Convertir objeto FeedbackModel a mapa
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'eventId': eventId,
    };
  }
}
