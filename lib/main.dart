import 'package:evergreen/pages/photos_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:color_blindness/color_blindness.dart';
import 'pages/health_wellness_page.dart';
import 'pages/games_page.dart';
import 'widgets/joy_nest_app_bar.dart';
import 'widgets/evergreen_grid_button.dart';
import 'pages/settings_page.dart';
import 'providers/settings_provider.dart';

Color getGridButtonColor(BuildContext context, Color color) {
  final settings = Provider.of<SettingsProvider>(context, listen: true);
  if (settings.darkMode && !settings.highContrast) {
    // Use lighter variants for dark mode
    if (color == Colors.teal) return Colors.teal[200]!;
    if (color == Colors.deepOrange) return Colors.deepOrange[200]!;
    if (color == Colors.blue) return Colors.lightBlue[200]!;
    if (color == Colors.purple) return Colors.purple[100]!;
    if (color == Colors.green) return Colors.lightGreen[200]!;
    if (color == Colors.deepOrangeAccent) return Colors.orange[200]!;
    if (color == Colors.red) return Colors.red[100]!;
    // Add more as needed
  }
  return color;
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const EvergreenApp(),
    ),
  );
}

class EvergreenApp extends StatelessWidget {
  const EvergreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        ThemeData baseTheme = ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: settings.darkMode ? Brightness.dark : Brightness.light,
          ),
          useMaterial3: true,
        );

        // Color blindness support (unchanged)
        if (settings.colorBlindMode) {
          baseTheme = baseTheme.copyWith(
            colorScheme: colorBlindnessColorScheme(
              baseTheme.colorScheme,
              ColorBlindnessType.deuteranopia,
            ),
          );
        }

        // High contrast mode
        if (settings.highContrast) {
          baseTheme = baseTheme.copyWith(
            scaffoldBackgroundColor: Colors.black,
            cardColor: Colors.grey[900],
            textTheme: baseTheme.textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              decorationColor: Colors.white,
            ),
            // Optionally, set icon color globally if needed:
            iconTheme: const IconThemeData(color: Colors.white),
          );
        } else if (settings.darkMode) {
          // Dark mode (not high contrast)
          baseTheme = baseTheme.copyWith(
            scaffoldBackgroundColor: const Color(0xFF23272F), // dark grey
          );
        }

        return MaterialApp(
          title: 'JoyNest',
          theme: baseTheme,
          home: const EvergreenHomePage(),
          debugShowCheckedModeBanner: false,
          routes: {'/settings': (context) => const SettingsPage()},
        );
      },
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
                  color: getGridButtonColor(context, Colors.teal),
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
                  color: getGridButtonColor(context, Colors.deepOrange),
                ),
                EvergreenGridButton(
                  icon: Icons.video_call_rounded,
                  label: 'Video Call',
                  onTap: () {},
                  color: getGridButtonColor(context, Colors.blue),
                ),
                EvergreenGridButton(
                  icon: Icons.photo_library_rounded,
                  label: 'Photos',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PhotosPage(),
                      ),
                    );
                  },
                  color: getGridButtonColor(context, Colors.purple),
                ),
                EvergreenGridButton(
                  icon: Icons.airplanemode_on_rounded,
                  label: 'Travel &   Sports',
                  onTap: () {},
                  color: getGridButtonColor(context, Colors.green),
                ),
                EvergreenGridButton(
                  icon: Icons.ondemand_video_rounded,
                  label: 'Video &    Music',
                  onTap: () {},
                  color: getGridButtonColor(context, Colors.deepOrangeAccent),
                ),
                EvergreenGridButton(
                  icon: Icons.emergency_rounded,
                  label: 'Help & Emergency',
                  onTap: () {},
                  color: getGridButtonColor(context, Colors.red),
                ),
                EvergreenGridButton(
                  icon: Icons.medication_rounded,
                  label: 'Medication',
                  onTap: () {},
                  color: getGridButtonColor(context, Colors.teal),
                ),
                EvergreenGridButton(
                  icon: Icons.people_rounded,
                  label: 'Contacts',
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
