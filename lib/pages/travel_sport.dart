import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/joy_nest_app_bar.dart';
import '../providers/settings_provider.dart';

class TravelSport extends StatelessWidget {
  const TravelSport({super.key});

  static List<Map<String, dynamic>> items = [
    {'icon': Icons.tour, 'title': 'Virtual Tour', 'color': Color(0xFFfe921f)},
    {'icon': Icons.sports_esports, 'title': 'E-sport', 'color': Color(0xFF0e86fe)},
    {'icon': Icons.travel_explore, 'title': "Today's Travel", 'color': Color(0xFFfe6309)},
    {'icon': Icons.music_note, 'title': 'Live Concert', 'color': Color(0xFF8838f8)},
    {'icon': Icons.theater_comedy, 'title': 'Virtual Theater', 'color': Color(0xFFfe5a36)},
    {'icon': Icons.event, 'title': 'Cultural Festival', 'color': Color(0xFF0abe50)},
    {'icon': Icons.favorite, 'title': 'My Favorite Trip', 'color': Color.fromARGB(255, 255, 0, 0)},
    {'icon': Icons.emoji_events, 'title': 'Local Sports', 'color': Color.fromARGB(255, 253, 234, 59)},
  ];

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final bool isDark = settings.darkMode || settings.highContrast;
    final Color cardColor = isDark ? Colors.grey[800]! : Colors.grey[200]!;
    final Color textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: const JoyNestAppBar(showBackButton: true),
      body: Container(
        color: isDark ? Colors.grey[900] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: cardColor,
                    child: ListTile(
                      leading: Icon(
                        items[index]['icon'],
                        color: items[index]['color'],
                      ),
                      title: Text(
                        items[index]['title'],
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: textColor.withValues(alpha: 0.7),
                      ),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
