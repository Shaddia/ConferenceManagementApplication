// event_detail_page.dart
import 'package:flutter/material.dart';
import '../models/event_model.dart';
import 'feedback_page.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;

  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Descripción:", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(event.description),
            const SizedBox(height: 16),
            Text("Fecha: ${event.date}"),
            Text("Lugar: ${event.location}"),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.feedback),
                label: const Text("Dar Feedback"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => FeedbackPage(event: event), // No uso const
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
