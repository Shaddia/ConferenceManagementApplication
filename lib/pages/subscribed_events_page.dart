import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/event_controller.dart';

// Página que muestra los eventos a los que el usuario se ha suscrito
class SubscribedEventsPage extends StatelessWidget {
  const SubscribedEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el controlador de eventos con Provider
    final eventController = Provider.of<EventController>(context);
    final subscribedEvents = eventController.subscribedEvents; // Lista de eventos suscritos

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Subscribed Events'), // Título en la barra superior
      ),
      body: subscribedEvents.isEmpty
          ? const Center(
              child: Text('No estás suscrito a ningún evento.'),
            )
          : ListView.builder(
              itemCount: subscribedEvents.length, // Número de eventos suscritos
              itemBuilder: (context, index) {
                final event = subscribedEvents[index];
                return ListTile(
                  title: Text(event.title), // Título del evento
                  subtitle: Text('${event.date.toLocal().toString().split(" ")[0]} - ${event.location}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                    onPressed: () => eventController.toggleSubscription(event), // Desuscribirse
                  ),
                );
              },
            ),
    );
  }
}