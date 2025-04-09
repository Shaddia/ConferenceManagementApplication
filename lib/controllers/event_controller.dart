import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../services/api_service.dart'; // Servicio que trae datos reales desde el backend

// Controlador que maneja la lógica de eventos disponibles
class EventController extends ChangeNotifier {
  // Lista de eventos disponibles
  List<Event> _events = [];

  // Lista de IDs de eventos suscritos por el usuario
  final List<int> _subscribedEventIds = [];

  // Getter: Todos los eventos
  List<Event> get events => _events;

  // Getter: Solo eventos suscritos
  List<Event> get subscribedEvents =>
      _events.where((event) => _subscribedEventIds.contains(event.id)).toList();

  // Verifica si un evento está suscrito
  bool isSubscribed(Event event) => _subscribedEventIds.contains(event.id);

  // Suscribir o quitar suscripción
  void toggleSubscription(Event event) {
    if (_subscribedEventIds.contains(event.id)) {
      _subscribedEventIds.remove(event.id);
    } else {
      _subscribedEventIds.add(event.id);
    }
    notifyListeners(); // Actualiza la UI
  }

  // Actualiza manualmente la lista de eventos
  void updateEvents(List<Event> newEvents) {
    _events = newEvents;
    notifyListeners();
  }

  // Cargar eventos desde la API real
  Future<void> loadEvents() async {
    try {
      final data = await ApiService.fetchEvents(); // Llama al backend

      final eventList = (data as List<dynamic>)
          .map<Event>((json) => Event.fromJson(json))
          .toList();

      updateEvents(eventList); // Actualiza la lista
    } catch (e) {
      print('Error al cargar eventos desde la API: $e');
    }
  }

  // Limpiar todas las suscripciones
  void clearSubscriptions() {
    _subscribedEventIds.clear();
    notifyListeners();
  }
}
