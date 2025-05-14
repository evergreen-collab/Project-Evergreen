import 'package:flutter/material.dart';
import '../widgets/joy_nest_app_bar.dart';
import 'package:flutter/services.dart';

class HealthWellnessPage extends StatefulWidget {
  const HealthWellnessPage({super.key});

  @override
  State<HealthWellnessPage> createState() => _HealthWellnessPageState();
}

class _HealthWellnessPageState extends State<HealthWellnessPage> {
  String steps = '2500';
  String water = '1.2';
  String meditation = '10';

  Future<void> _editValue({
    required String title,
    required String initialValue,
    required Function(String) onSave,
  }) async {
    final controller = TextEditingController(text: initialValue);
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Update $title'),
            content: TextField(
              controller: controller,
              autofocus: true,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ), // allow decimals
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d*'),
                ), // digits and optional decimal point
              ],
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),

            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  onSave(controller.text);
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

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

            // Steps
            Card(
              child: ListTile(
                leading: const Icon(Icons.directions_walk, color: Colors.teal),
                title: const Text('Steps Today'),
                subtitle: Text('$steps steps'),
                onTap:
                    () => _editValue(
                      title: 'Steps',
                      initialValue: steps,
                      onSave: (newValue) => setState(() => steps = newValue),
                    ),
              ),
            ),
            const SizedBox(height: 10),

            // Water
            Card(
              child: ListTile(
                leading: const Icon(Icons.local_drink, color: Colors.blue),
                title: const Text('Water Intake'),
                subtitle: Text('$water liters'),
                onTap:
                    () => _editValue(
                      title: 'Water Intake',
                      initialValue: water,
                      onSave: (newValue) => setState(() => water = newValue),
                    ),
              ),
            ),
            const SizedBox(height: 10),

            // Meditation
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.self_improvement,
                  color: Colors.purple,
                ),
                title: const Text('Meditation'),
                subtitle: Text('$meditation minutes'),
                onTap:
                    () => _editValue(
                      title: 'Meditation',
                      initialValue: meditation,
                      onSave:
                          (newValue) => setState(() => meditation = newValue),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
