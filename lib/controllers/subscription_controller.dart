import 'package:flutter/material.dart';

class SubscriptionController with ChangeNotifier {
  // Lista de eventos a los que el usuario está suscrito
  final List<int> _subscribedEventIds = [];

  // Getter para obtener la lista actual de IDs de eventos suscritos
  List<int> get subscribedEventIds => _subscribedEventIds;

  // Método para verificar si el usuario está suscrito a un evento específico
  bool isSubscribed(int eventId) {
    return _subscribedEventIds.contains(eventId);
  }

  // Método para suscribirse a un evento
  void subscribe(int eventId) {
    if (!_subscribedEventIds.contains(eventId)) {
      _subscribedEventIds.add(eventId);
      notifyListeners(); // Notifica a los widgets que escuchan cambios
    }
  }

  // Método para cancelar la suscripción a un evento
  void unsubscribe(int eventId) {
    if (_subscribedEventIds.contains(eventId)) {
      _subscribedEventIds.remove(eventId);
      notifyListeners(); // Notifica a los widgets que escuchan cambios
    }
  }

  // Método para limpiar todas las suscripciones (opcional, útil para pruebas o logout)
  void clearSubscriptions() {
    _subscribedEventIds.clear();
    notifyListeners();
  }
}
