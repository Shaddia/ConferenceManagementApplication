import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/event_controller.dart';
import 'event_detail_page.dart';

class EventListPage extends StatelessWidget {
  const EventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final eventController = Provider.of<EventController>(context);
    final events = eventController.events;

    return Scaffold(
      appBar: AppBar(title: const Text('Available Events')),
      body: events.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Indicador de carga
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                final isSubscribed = eventController.isSubscribed(event);

                return ListTile(
                  title: Text(event.title),
                  subtitle: Text(
                      '${event.date.toLocal().toString().split(" ")[0]} - ${event.location}'),
                  trailing: IconButton(
                    icon: Icon(
                      isSubscribed ? Icons.bookmark : Icons.bookmark_outline,
                      color: isSubscribed ? Colors.indigo : null,
                    ),
                    onPressed: () =>
                        eventController.toggleSubscription(event),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailPage(event: event),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
