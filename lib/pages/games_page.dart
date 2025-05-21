import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/joy_nest_app_bar.dart';
import '../widgets/evergreen_grid_button.dart';
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

class GamesPage extends StatelessWidget {
  GamesPage({super.key});

  final List<Map<String, dynamic>> games = [
    {
      'icon': Icons.grid_3x3_outlined,
      'label': 'Tic Tac Toe',
      'onTap': () {
        // Add your navigation or game logic here
      },
      'color': Colors.teal,
    },
    {
      'icon': Icons.crop_square,
      'label': 'Memory',
      'onTap': () {
        // Add your navigation or game logic here
      },
      'color': Colors.deepOrange,
    },
    {
      'icon': Icons.question_mark,
      'label': 'Higher Lower Game',
      'onTap': () {
        // Add your navigation or game logic here
      },
      'color': Colors.blue,
    },
    {
      'icon': Icons.grid_on,
      'label': 'Sudoku',
      'onTap': () {
        // Add your navigation or game logic here
      },
      'color': Colors.purple,
    },
    {
      'icon': Icons.add,
      'label': '2048',
      'onTap': () {
        // Add your navigation or game logic here
      },
      'color': Colors.green,
    },
    {
      'icon': Icons.link,
      'label': 'Connect Four',
      'onTap': () {
        // Add your navigation or game logic here
      },
      'color': Colors.red,
    },
    {
      'icon': Icons.play_arrow,
      'label': 'Simon Says',
      'onTap': () {
        // Add your navigation or game logic here
      },
      'color': Colors.orange,
    },
    {
      'icon': Icons.text_fields,
      'label': 'Hangman',
      'onTap': () {
        // Add your navigation or game logic here
      },
      'color': Colors.blueAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to determine orientation and size
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final padding = MediaQuery.of(context).size.shortestSide * 0.04;

    return Scaffold(
      appBar: const JoyNestAppBar(showBackButton: true),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          children: [
            Center(
              child: const Text(
                'Games',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20), // Space between text and buttons
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: isLandscape ? 3 / 2 : 1,
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: padding,
                    crossAxisSpacing: padding,
                    children:
                        games.map((game) {
                          return EvergreenGridButton(
                            icon: game['icon'],
                            label: game['label'],
                            onTap: game['onTap'],
                            color: getGridButtonColor(context, game['color']),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
