import 'package:flutter/material.dart';
import 'app_bar.dart';

class HealthWellnessPage extends StatelessWidget {
  const HealthWellnessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const JoyNestAppBar(showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daily Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(Icons.directions_walk, color: Colors.teal),
                title: const Text('Steps Today'),
                subtitle: const Text('2,500 steps'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.local_drink, color: Colors.blue),
                title: const Text('Water Intake'),
                subtitle: const Text('1.2 Liters'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.self_improvement,
                  color: Colors.purple,
                ),
                title: const Text('Meditation'),
                subtitle: const Text('10 min'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
