import 'package:evergreen/widgets/joy_nest_app_bar.dart';
import 'package:flutter/material.dart';

class TravelSport extends StatelessWidget {
  const TravelSport({super.key});

  static List<Map<String, dynamic>> items = [
    {'icon': Icons.tour, 'title': 'Virtual Tour', 'color': Color(0xFFfe921f)},
    {
      'icon': Icons.sports_esports,
      'title': 'E-sport',
      'color': Color(0xFF0e86fe),
    },
    {
      'icon': Icons.travel_explore,
      'title': "Today's Travel",
      'color': Color(0xFFfe6309),
    },
    {
      'icon': Icons.music_note,
      'title': 'Live Concert',
      'color': Color(0xFF8838f8),
    },
    {
      'icon': Icons.theater_comedy,
      'title': 'Virtual Theater',
      'color': Color(0xFFfe5a36),
    },
    {
      'icon': Icons.event,
      'title': 'Cultural Festival',
      'color': Color(0xFF0abe50),
    },
    {
      'icon': Icons.favorite,
      'title': 'My Favorite Trip',
      'color': Color.fromARGB(255, 255, 0, 0),
    },
    {
      'icon': Icons.emoji_events,
      'title': 'Local Sports',
      'color': Color.fromARGB(255, 253, 234, 59),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JoyNestAppBar(showBackButton: true),
      body: Padding(
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
                  color: Colors.grey[200],
                  child: ListTile(
                    leading: Icon(
                      items[index]['icon'],
                      color: items[index]['color'],
                    ),
                    title: Text(items[index]['title']),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      // need to add navigation if we have time to add more info
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
