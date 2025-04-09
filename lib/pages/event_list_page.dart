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
      appBar: AppBar(
        title: const Text('Available events', 
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w800,
              color: Colors.brown,
              fontFamily: 'Times New Roman',
            )),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFBBA8),
        foregroundColor: Colors.brown,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFDF7F2), // Fondo general claro
      body: events.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                final isSubscribed = eventController.isSubscribed(event);

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEEDD), // Nude suave
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '${event.date.toLocal().toString().split(" ")[0]} • ${event.location}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        isSubscribed
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        color: isSubscribed ? Colors.brown : Colors.brown,
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
                  ),
                );
              },
            ),
    );
  }
}
