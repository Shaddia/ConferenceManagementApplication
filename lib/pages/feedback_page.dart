import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/feedback_controller.dart';
import '../models/event_model.dart';

class FeedbackPage extends StatefulWidget {
  final Event event;

  const FeedbackPage({super.key, required this.event});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feedbackController = Provider.of<FeedbackController>(context);

    final feedbacksForEvent = feedbackController.feedbacks
        .where((fb) => fb.eventId == widget.event.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback - ${widget.event.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Escribe tu comentario anónimo...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final message = _controller.text.trim();
                if (message.isNotEmpty) {
                  feedbackController.submitFeedback(message, widget.event.id); //  Esta línea es válida si widget.event.id es String
                  _controller.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Feedback enviado. ¡Gracias!')),
                  );
                }
              },
              child: const Text('Enviar comentario'),
            ),
            const SizedBox(height: 24),
            const Text('Comentarios enviados:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: feedbacksForEvent.length,
                itemBuilder: (context, index) {
                  final feedback = feedbacksForEvent[index];
                  return ListTile(
                    title: Text(feedback.message),
                    subtitle: Text(
                      'Enviado el ${feedback.timestamp.toLocal().toString().split(".")[0]}',
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
