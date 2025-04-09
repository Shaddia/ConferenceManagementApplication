import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/event_controller.dart';
import '../models/event_model.dart';
import 'event_detail_page.dart';
import 'feedback_page.dart'; // 👈 Asegúrate de tener esta línea

class SubscribedEventsPage extends StatelessWidget {
  const SubscribedEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final eventController = Provider.of<EventController>(context);
    final subscribedEvents = eventController.subscribedEvents;

    return ListView.builder(
      itemCount: subscribedEvents.length,
      itemBuilder: (context, index) {
        final event = subscribedEvents[index];
        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(event.title),
            subtitle: Text('Fecha: ${event.date}'),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: 'Detalles',
                  icon: const Icon(Icons.info_outline),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventDetailPage(event: event),
                      ),
                    );
                  },
                ),
                IconButton(
                  tooltip: 'Dar Feedback',
                  icon: const Icon(Icons.feedback),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FeedbackPage(event: event),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
