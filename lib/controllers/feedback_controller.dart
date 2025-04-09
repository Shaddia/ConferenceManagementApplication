import 'package:flutter/material.dart';
import '../models/feedback_model.dart';

class FeedbackController extends ChangeNotifier {
  final List<FeedbackModel> _feedbacks = [];

  List<FeedbackModel> get feedbacks => List.unmodifiable(_feedbacks);

void submitFeedback(String message, String eventId) {
  final feedback = FeedbackModel(
    id: DateTime.now().millisecondsSinceEpoch,
    message: message,
    timestamp: DateTime.now(),
    eventId: eventId,
  );
  _feedbacks.add(feedback);
  notifyListeners();
}

  void clearFeedbacks() {
    _feedbacks.clear();
    notifyListeners();
  }
}


