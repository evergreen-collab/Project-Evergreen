import 'package:flutter/material.dart';

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
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/JoyNest.png',
            height: 100,
            width: 100,
            semanticLabel: 'Logo',
          ),
        ),
        title: const Text(
          'JoyNest',
          style: TextStyle(
            fontFamily: 'Salisbury',
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.orangeAccent,
            letterSpacing: 0,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              // TODO: Open settings in the future
            },
          ),
        ],
        elevation: 0,
      ),
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
                  icon: Icons.ondemand_video,
                  label: 'Video Entertainment',
                  onTap: () {},
                ),
                EvergreenGridButton(
                  icon: Icons.spa,
                  label: 'Wellness & Relax',
                  onTap: () {},
                ),
                EvergreenGridButton(
                  icon: Icons.videogame_asset,
                  label: 'Games',
                  onTap: () {},
                ),
                EvergreenGridButton(
                  icon: Icons.public,
                  label: 'Travel &  Culture',
                  onTap: () {},
                ),
                EvergreenGridButton(
                  icon: Icons.sports_soccer,
                  label: 'Sports & Activity',
                  onTap: () {},
                ),
                EvergreenGridButton(
                  icon: Icons.people,
                  label: 'Family & Friends',
                  onTap: () {},
                ),
                EvergreenGridButton(
                  icon: Icons.photo_library,
                  label: 'Memories',
                  onTap: () {},
                ),
                EvergreenGridButton(
                  icon: Icons.medication,
                  label: 'Health & Medication',
                  onTap: () {},
                ),
                EvergreenGridButton(
                  icon: Icons.emergency,
                  label: 'Help & Emergency',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EvergreenGridButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const EvergreenGridButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Make the button square and responsive
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide;
        return Material(
          color: Colors.teal[50],
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.teal[50],
                border: Border.all(
                  color: Colors.teal, // Border color
                  width: 3,                   // Border thickness
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: size * 0.38, color: Colors.teal[400]),
                  const SizedBox(height: 12),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: size * 0.14,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
