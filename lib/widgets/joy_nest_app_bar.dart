import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class JoyNestAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final VoidCallback? onBack;

  const JoyNestAppBar({super.key, this.showBackButton = false, this.onBack});

  @override
  Size get preferredSize => const Size.fromHeight(200);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 200,
      leadingWidth: 180,
      leading:
          showBackButton
              ? Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ), // Adjust the padding as needed
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 40),
                  onPressed: onBack ?? () => Navigator.of(context).pop(),
                  tooltip: 'Back',
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'assets/images/JoyNest.png',
                  height: 200,
                  width: 200,
                  semanticLabel: 'Logo',
                ),
              ),
      title: const Text(
        'JoyNest',
        style: TextStyle(
          fontFamily: 'Salisbury',
          fontWeight: FontWeight.bold,
          fontSize: 80,
          color: Colors.orangeAccent,
          letterSpacing: 0,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Consumer<SettingsProvider>(
            builder: (context, settings, _) {
              final isDark = settings.darkMode;
              final isHighContrast = settings.highContrast;

              return SizedBox(
                width: 80,
                height: 80,
                child: Material(
                  color:
                      isDark && !isHighContrast
                          ? const Color(0xFF424242) // Dark grey
                          : Colors.orangeAccent,
                  shape: const CircleBorder(),
                  elevation: 4,
                  child: IconButton(
                    icon: Icon(
                      Icons.settings,
                      color:
                          isDark && !isHighContrast
                              ? Colors.orangeAccent
                              : Colors.white,
                    ),
                    iconSize: 50,
                    tooltip: 'Settings',
                    onPressed: () => Navigator.pushNamed(context, '/settings'),
                  ),
                ),
              );
            },
          ),
        ),
      ],
      elevation: 0,
    );
  }
}
