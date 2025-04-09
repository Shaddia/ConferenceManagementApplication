import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class ApiService {
  // Dirección base del servidor backend (localhost desde Android Studio/emulador)
  static const String baseUrl = 'http://10.0.2.2:5000';//10.0.2.2 → apunta al localhost de mi PC desde el emulador Android. Puerto 5000 porque estoy usando FLASK

  // Método para obtener eventos desde la API
  static Future<List<dynamic>> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/events'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error al cargar eventos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }
}