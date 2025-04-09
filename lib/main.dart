import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/event_controller.dart';
import 'controllers/feedback_controller.dart';
import 'pages/event_list_page.dart';
import 'pages/subscribed_events_page.dart';
import 'pages/feedback_page.dart';
import 'models/event_model.dart'; // 👈 Asegúrate de importar el modelo Event

void main() {
  runApp(const ConferenceApp());
}

class ConferenceApp extends StatelessWidget {
  const ConferenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventController()),
        ChangeNotifierProvider(create: (_) => FeedbackController()),
      ],
      child: MaterialApp(
        title: 'Conference Manager',
        theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
        home: const MainNavigation(),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const EventListPage(),
    const SubscribedEventsPage(),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final controller = Provider.of<EventController>(context, listen: false);
      controller.loadEvents().catchError((e) {
        debugPrint('Error cargando eventos: $e');
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'Event Tracks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Subscribed',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.feedback),
        onPressed: () {
          final dummyEvent = Event(
            id: 'demo001',
            title: 'Inteligencia Artificial en la Educación',
            description: '¿Acaso no te interesa saber cómo tu educación es influída por la nueva innovación de la IA? ¡Averigualo!',
            date: DateTime.now(),
            location: 'Sala Virtual',
            capacity: 100,
          );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FeedbackPage(event: dummyEvent)),
          );
        },
      ),
    );
  }
}
