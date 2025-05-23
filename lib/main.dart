import 'package:evergreen/pages/medication_page.dart';
import 'package:evergreen/pages/photos_page.dart';
import 'package:evergreen/pages/video_music_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:color_blindness/color_blindness.dart';
import 'package:evergreen/pages/travel_sport.dart';
import 'pages/health_wellness_page.dart';
import 'pages/games_page.dart';
import 'pages/videocall_page.dart';
import 'widgets/joy_nest_app_bar.dart';
import 'widgets/evergreen_grid_button.dart';
import 'pages/settings_page.dart';
import 'providers/settings_provider.dart';
import 'pages/emergency_page.dart';
import 'package:evergreen/pages/contacts_page.dart';

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

        // Color blindness support
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
            iconTheme: const IconThemeData(color: Colors.white),
          );
        } else if (settings.darkMode) {
          // Dark mode (not high contrast)
          baseTheme = baseTheme.copyWith(
            scaffoldBackgroundColor: const Color(0xFF23272F),
          );
        }

        return MaterialApp(
          title: 'JoyNest',
          theme: baseTheme,
          home: const EvergreenHomePage(),
          debugShowCheckedModeBanner: false,
          routes: {
            '/settings': (context) => const SettingsPage(),
            '/videocall': (context) => const VideocallPage(),
            '/emergency': (context) => const EmergencyPage(),
          },
        );
      },
    );
  }
}

class EvergreenHomePage extends StatelessWidget {
  const EvergreenHomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      MaterialPageRoute(builder: (context) => GamesPage()),
                    );
                  },
                  color: getGridButtonColor(context, Colors.deepOrange),
                ),
                EvergreenGridButton(
                  icon: Icons.video_call_rounded,
                  label: 'Video Call',
                  onTap: () {
                    Navigator.of(context).pushNamed('/videocall');
                  },
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
                  label: 'Travel \n& Sports',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TravelSport(),
                      ),
                    );
                  },
                  color: getGridButtonColor(context, Colors.green),
                ),
                EvergreenGridButton(
                  icon: Icons.ondemand_video_rounded,
                  label: 'Video \n& Music',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const VideoMusicPage(),
                      ),
                    );
                  },
                  color: getGridButtonColor(context, Colors.deepOrangeAccent),
                ),
                EvergreenGridButton(
                  icon: Icons.emergency_rounded,
                  label: 'Help & Emergency',
                  onTap: () => Navigator.pushNamed(context, '/emergency'),
                  color: getGridButtonColor(context, Colors.red),
                ),
                EvergreenGridButton(
                  icon: Icons.medication_rounded,
                  label: 'Medication',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MedicationPage(),
                      ),
                    );
                  },
                  color: getGridButtonColor(context, Colors.teal),
                ),
                EvergreenGridButton(
                  icon: Icons.people_rounded,
                  label: 'Contacts',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ContactsPage(),
                      ),
                    );
                  },
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
