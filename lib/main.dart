import 'package:flutter/material.dart';
import 'pages/health_wellness_page.dart';
import 'pages/games_page.dart';
import 'widgets/joy_nest_app_bar.dart';
import 'widgets/evergreen_grid_button.dart';

void main() {
  runApp(const EvergreenApp());
}

class EvergreenApp extends StatelessWidget {
  const EvergreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JoyNest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const EvergreenHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EvergreenHomePage extends StatelessWidget {
  const EvergreenHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to determine orientation and size
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final padding = MediaQuery.of(context).size.shortestSide * 0.04;

    return Scaffold(
      appBar: const JoyNestAppBar(showBackButton: false),
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
                  icon: Icons.health_and_safety_rounded,
                  label: 'Health & Wellness',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HealthWellnessPage(),
                      ),
                    );
                  },
                  color: Colors.teal,
                ),
                EvergreenGridButton(
                  icon: Icons.videogame_asset_rounded,
                  label: 'Games',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const GamesPage(),
                      ),
                    );
                  },
                  color: Colors.deepOrange,
                ),
                EvergreenGridButton(
                  icon: Icons.video_call_rounded,
                  label: 'Video Call',
                  onTap: () {},
                  color: Colors.blue,
                ),
                EvergreenGridButton(
                  icon: Icons.photo_library_rounded,
                  label: 'Photos',
                  onTap: () {},
                  color: Colors.purple,
                ),
                EvergreenGridButton(
                  icon: Icons.airplanemode_on_rounded,
                  label: 'Travel &   Sports',
                  onTap: () {},
                  color: Colors.green,
                ),
                EvergreenGridButton(
                  icon: Icons.ondemand_video_rounded,
                  label: 'Video &    Music',
                  onTap: () {},
                  color: Colors.deepOrangeAccent,
                ),
                EvergreenGridButton(
                  icon: Icons.emergency_rounded,
                  label: 'Help & Emergency',
                  onTap: () {},
                  color: Colors.redAccent,
                ),
                EvergreenGridButton(
                  icon: Icons.medication_rounded,
                  label: 'Medication',
                  onTap: () {},
                  color: Colors.teal,
                ),
                EvergreenGridButton(
                  icon: Icons.people_rounded,
                  label: 'Contacts',
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
