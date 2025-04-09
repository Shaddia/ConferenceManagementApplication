// Modelo que representa un comentario o retroalimentación anónima
class FeedbackModel {
  final int id; // Identificador único (puede ser un timestamp)
  final String message; // Mensaje del comentario
  final DateTime timestamp; // Fecha y hora de envío

  // Constructor del modelo con campos requeridos
  FeedbackModel({
    required this.id,
    required this.message,
    required this.timestamp,
  });

  // Crear objeto FeedbackModel desde un mapa (por ejemplo, leído desde almacenamiento)
  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  // Convertir objeto FeedbackModel a mapa (para guardar en BD local o exportar)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}