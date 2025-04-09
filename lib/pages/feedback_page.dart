import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/feedback_controller.dart';

// Página que permite al usuario enviar comentarios anónimos
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _controller = TextEditingController(); // Controlador para el campo de texto

  @override
  void dispose() {
    _controller.dispose(); // Liberar recursos cuando se destruye el widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feedbackController = Provider.of<FeedbackController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anonymous Feedback'), // Título en la barra superior
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller, // Controlador del campo de texto
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Write your feedback here...', // Texto de sugerencia
                border: OutlineInputBorder(), // Borde del campo
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final message = _controller.text.trim(); // Obtener mensaje
                if (message.isNotEmpty) {
                  feedbackController.submitFeedback(message); // Enviar comentario
                  _controller.clear(); // Limpiar campo

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
                itemCount: feedbackController.feedbacks.length,
                itemBuilder: (context, index) {
                  final feedback = feedbackController.feedbacks[index];
                  return ListTile(
                    title: Text(feedback.message),
                    subtitle: Text('Enviado el ${feedback.timestamp.toLocal().toString().split(".")[0]}'),
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