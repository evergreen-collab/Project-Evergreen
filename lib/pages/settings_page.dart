import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Log In Button
          ListTile(
            title: Text('Log In', style: Theme.of(context).textTheme.bodyLarge),
            trailing: ElevatedButton(
              child: const Text('Log In'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    // Controllers for text fields
                    final usernameController = TextEditingController();
                    final passwordController = TextEditingController();
                    return AlertDialog(
                      title: const Text('Log In'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        ElevatedButton(
                          child: const Text('Log In'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),

          // Existing settings switches and dropdown
          SwitchListTile(
            title: Text('Dark Mode', style: Theme.of(context).textTheme.bodyLarge),
            value: settings.darkMode,
            onChanged: (v) => settings.toggleDarkMode(v),
          ),
          SwitchListTile(
            title: Text('Colorblind Mode', style: Theme.of(context).textTheme.bodyLarge),
            value: settings.colorBlindMode,
            onChanged: (v) => settings.toggleColorBlindMode(v),
          ),
          SwitchListTile(
            title: Text('High Contrast Mode', style: Theme.of(context).textTheme.bodyLarge),
            value: settings.highContrast,
            onChanged: (v) => settings.toggleHighContrast(v),
          ),
          ListTile(
            title: Text('Language', style: Theme.of(context).textTheme.bodyLarge),
            trailing: DropdownButton(
              style: Theme.of(context).textTheme.bodyLarge,
              value: settings.locale,
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
    );
  }
}
