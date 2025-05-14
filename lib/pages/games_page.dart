import 'package:flutter/material.dart';
import '../widgets/joy_nest_app_bar.dart';
import '../widgets/evergreen_grid_button.dart';

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
                  color: Colors.teal,
                ),
                EvergreenGridButton(
                  icon: Icons.crop_square,
                  label: 'Memory',
                  onTap: () {},
                  color: Colors.deepOrange,
                ),
                EvergreenGridButton(
                  icon: Icons.question_mark,
                  label: 'Higher lower game',
                  onTap: () {},
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
