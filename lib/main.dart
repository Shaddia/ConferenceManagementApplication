import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/event_controller.dart';
import 'controllers/feedback_controller.dart';
import 'pages/event_list_page.dart';
import 'pages/subscribed_events_page.dart';
import 'pages/feedback_page.dart'; 

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
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          useMaterial3: true,
        ),
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
      // 👉 Botón temporal para probar FeedbackPage
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.feedback),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FeedbackPage()),
          );
        },
      ),
    );
  }
}
