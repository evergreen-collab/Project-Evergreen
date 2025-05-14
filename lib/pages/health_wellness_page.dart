import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/joy_nest_app_bar.dart';
import 'package:flutter/services.dart';
import '../providers/settings_provider.dart';


Color getGridButtonColor(BuildContext context, Color color) {
  final settings = Provider.of<SettingsProvider>(context, listen: false);
  if (settings.darkMode && !settings.highContrast) {
    // Use lighter variants for dark mode
    if (color == Colors.teal) return Colors.teal[200]!;
    if (color == Colors.deepOrange) return Colors.deepOrange[200]!;
    if (color == Colors.blue) return Colors.lightBlue[200]!;
    if (color == Colors.purple) return Colors.purple[200]!;
    if (color == Colors.green) return Colors.lightGreen[200]!;
    if (color == Colors.deepOrangeAccent) return Colors.orange[200]!;
    if (color == Colors.red) return Colors.red[200]!;
    // Add more as needed
  }
  return color;
}

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
