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
  const GamesPage({super.key});

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
        child: Center(
          child: AspectRatio(
            aspectRatio: isLandscape ? 3 / 2 : 1,
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: padding,
              crossAxisSpacing: padding,
              children: [
                EvergreenGridButton(
                  icon: Icons.grid_3x3_outlined,
                  label: 'Tic Tac Toe',
                  onTap: () {},
                  color: getGridButtonColor(context, Colors.teal),
                ),
                EvergreenGridButton(
                  icon: Icons.crop_square,
                  label: 'Memory',
                  onTap: () {},
                  color: getGridButtonColor(context, Colors.deepOrange),
                ),
                EvergreenGridButton(
                  icon: Icons.question_mark,
                  label: 'Higher lower game',
                  onTap: () {},
                  color: getGridButtonColor(context, Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
