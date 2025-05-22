import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/joy_nest_app_bar.dart';
import 'package:flutter/services.dart';
import '../providers/settings_provider.dart';

Color getGridButtonColor(BuildContext context, Color color) {
  final settings = Provider.of<SettingsProvider>(context, listen: false);
  if (settings.darkMode && !settings.highContrast) {
    if (color == Colors.teal) return Colors.teal[200]!;
    if (color == Colors.deepOrange) return Colors.deepOrange[200]!;
    if (color == Colors.blue) return Colors.lightBlue[200]!;
    if (color == Colors.purple) return Colors.purple[200]!;
    if (color == Colors.green) return Colors.lightGreen[200]!;
    if (color == Colors.deepOrangeAccent) return Colors.orange[200]!;
    if (color == Colors.red) return Colors.red[200]!;
  }
  return color;
}

class HealthWellnessPage extends StatefulWidget {
  const HealthWellnessPage({super.key});

  @override
  State<HealthWellnessPage> createState() => _HealthWellnessPageState();
}

class _HealthWellnessPageState extends State<HealthWellnessPage> {
  final Map<String, String> values = {
    'Steps': '2500',
    'Water Intake': '1.2',
    'Meditation': '10',
    'Sleep Hours': '7.5',
    'Calories': '1800',
  };

  final List<Map<String, dynamic>> cardData = [
    {
      'title': 'Steps',
      'icon': Icons.directions_walk,
      'color': Colors.teal,
      'unit': 'steps',
    },
    {
      'title': 'Water Intake',
      'icon': Icons.local_drink,
      'color': Colors.blue,
      'unit': 'liters',
    },
    {
      'title': 'Meditation',
      'icon': Icons.self_improvement,
      'color': Colors.purple,
      'unit': 'minutes',
    },
    {
      'title': 'Sleep Hours',
      'icon': Icons.hotel,
      'color': Colors.green,
      'unit': 'hours',
    },
    {
      'title': 'Calories',
      'icon': Icons.local_fire_department,
      'color': Colors.deepOrange,
      'unit': 'kcal',
    },
  ];

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
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Daily Summary',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              ...cardData.map((data) {
                final title = data['title'] as String;
                final icon = data['icon'] as IconData;
                final color = data['color'] as Color;
                final unit = data['unit'] as String;

                return Column(
                  children: [
                    Card(
                      child: ListTile(
                        leading: Icon(
                          icon,
                          color: getGridButtonColor(context, color),
                        ),
                        title: Text(
                          title,
                          style: const TextStyle(fontSize: 24),
                        ),
                        subtitle: Text(
                          '${values[title]} $unit',
                          style: const TextStyle(fontSize: 18),
                        ),
                        onTap:
                            () => _editValue(
                              title: title,
                              initialValue: values[title]!,
                              onSave:
                                  (newValue) =>
                                      setState(() => values[title] = newValue),
                            ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
