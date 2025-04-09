import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/event_model.dart';
import '../controllers/event_controller.dart';

// Página que muestra los detalles de un evento específico
class EventDetailPage extends StatelessWidget {
  final Event event; // Evento que se va a mostrar

  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el controlador de eventos para verificar suscripción
    final eventController = Provider.of<EventController>(context);
    final isSubscribed = eventController.isSubscribed(event); // Verificamos si está suscrito

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title), // Título de la AppBar con el nombre del evento
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 20),
                const SizedBox(width: 8),
                Text(event.date.toLocal().toString().split(' ')[0]), // Fecha
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 20),
                const SizedBox(width: 8),
                Text(event.location), // Ubicación
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.group, size: 20),
                const SizedBox(width: 8),
                Text('Capacidad: ${event.capacity}'), // Capacidad máxima
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(
                  isSubscribed ? Icons.cancel : Icons.check_circle,
                ),
                label: Text(isSubscribed ? 'Cancelar suscripción' : 'Suscribirse'),
                onPressed: () => eventController.toggleSubscription(event), // Acción de suscripción/desuscripción
              ),
            ),
          ],
        ),
      ),
    );
  }
}