import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    final isHighContrast = settings.highContrast;
    final isDark = settings.darkMode || isHighContrast;
    final textColor = isHighContrast ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color;

    // Styles
    const double labelFontSize = 26;
    const double buttonFontSize = 24;
    const double dropdownFontSize = 24;
    const double horizontalPadding = 32.0;
    const double verticalPadding = 20.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: isHighContrast ? Colors.black : null,
        iconTheme: isHighContrast ? const IconThemeData(color: Colors.white) : null,
      ),
      backgroundColor: isHighContrast ? Colors.black : null,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: horizontalPadding),
        children: [
          // Log In Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: verticalPadding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: labelFontSize,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                    minimumSize: const Size(120, 56),
                    textStyle: const TextStyle(fontSize: buttonFontSize, fontWeight: FontWeight.bold),
                    backgroundColor: isHighContrast ? Colors.white12 : null,
                    foregroundColor: isHighContrast ? Colors.white : null,
                    alignment: Alignment.center,
                  ),
                  child: const Text(
                    'Log In',
                    strutStyle: StrutStyle(forceStrutHeight: true, height: 1.3),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final usernameController = TextEditingController();
                        final passwordController = TextEditingController();
                        return AlertDialog(
                          backgroundColor: isHighContrast ? Colors.black : null,
                          title: Text(
                            'Log In',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  labelStyle: TextStyle(fontSize: 22, color: textColor),
                                ),
                                style: TextStyle(fontSize: 22, color: textColor),
                              ),
                              const SizedBox(height: 24),
                              TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(fontSize: 22, color: textColor),
                                ),
                                style: TextStyle(fontSize: 22, color: textColor),
                                obscureText: true,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text('Cancel', style: TextStyle(fontSize: buttonFontSize, color: textColor)),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isHighContrast ? Colors.white12 : null,
                                foregroundColor: isHighContrast ? Colors.white : null,
                              ),
                              child: Text('Log In', style: TextStyle(fontSize: buttonFontSize, color: textColor)),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          // Switches
          Padding(
            padding: const EdgeInsets.symmetric(vertical: verticalPadding / 2),
            child: _largeSwitchTile(
              context,
              label: 'Dark Mode',
              value: settings.darkMode,
              onChanged: settings.toggleDarkMode,
              icon: Icons.dark_mode,
              textColor: textColor,
              horizontalPadding: horizontalPadding,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: verticalPadding / 2),
            child: _largeSwitchTile(
              context,
              label: 'Colorblind Mode',
              value: settings.colorBlindMode,
              onChanged: settings.toggleColorBlindMode,
              icon: Icons.visibility,
              textColor: textColor,
              horizontalPadding: horizontalPadding,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: verticalPadding / 2),
            child: _largeSwitchTile(
              context,
              label: 'High Contrast Mode',
              value: settings.highContrast,
              onChanged: settings.toggleHighContrast,
              icon: Icons.contrast,
              textColor: textColor,
              horizontalPadding: horizontalPadding,
            ),
          ),
          // Language Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(vertical: verticalPadding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    'Language',
                    style: TextStyle(fontSize: labelFontSize, fontWeight: FontWeight.w600, color: textColor),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: isHighContrast ? Colors.black : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButton<String>(
                    value: settings.locale,
                    style: TextStyle(
                      fontSize: dropdownFontSize,
                      fontWeight: FontWeight.w600,
                      color: isHighContrast ? Colors.white : Colors.black,
                    ),
                    dropdownColor: isHighContrast ? Colors.black : Theme.of(context).cardColor,
                    iconEnabledColor: isHighContrast ? Colors.white : Colors.black,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(value: 'en', child: Text('English')),
                      DropdownMenuItem(value: 'pt', child: Text('Portuguese')),
                      DropdownMenuItem(value: 'es', child: Text('Spanish')),
                      DropdownMenuItem(value: 'fr', child: Text('French')),
                      DropdownMenuItem(value: 'de', child: Text('German')),
                      DropdownMenuItem(value: 'it', child: Text('Italian')),
                      DropdownMenuItem(value: 'pl', child: Text('Polish')),
                      DropdownMenuItem(value: 'tr', child: Text('Turkish')),
                      DropdownMenuItem(value: 'hr', child: Text('Croatian')),
                    ],
                    onChanged: (v) => v != null ? settings.setLocale(v) : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _largeSwitchTile(
      BuildContext context, {
        required String label,
        required bool value,
        required ValueChanged<bool> onChanged,
        required IconData icon,
        required Color? textColor,
        required double horizontalPadding,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 0, right: 12),
          child: Row(
            children: [
              Icon(icon, size: 36, color: textColor),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: textColor),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 0),
          child: Transform.scale(
            scale: 1.5,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.teal,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[300],
              materialTapTargetSize: MaterialTapTargetSize.padded,
            ),
          ),
        ),
      ],
    );
  }
}
