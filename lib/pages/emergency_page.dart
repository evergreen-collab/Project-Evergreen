import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/joy_nest_app_bar.dart';
import '../providers/settings_provider.dart';

// Utility function for button colors, matching your project style
Color getGridButtonColor(BuildContext context, Color color) {
  final settings = Provider.of<SettingsProvider>(context, listen: false);
  if (settings.darkMode && !settings.highContrast) {
    if (color == Colors.red) return Colors.red[200]!;
    if (color == Colors.redAccent) return Colors.redAccent[100]!;
    if (color == Colors.blue) return Colors.lightBlue[200]!;
  }
  return color;
}

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  void _showEmergencyPopup(BuildContext context, String title, String number, IconData icon) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => EmergencyCallPopup(
        title: title,
        number: number,
        icon: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final padding = MediaQuery.of(context).size.shortestSide * 0.04;

    // Example medical info (replace with real data as needed)
    const bloodGroup = 'O+';
    const allergies = 'Penicillin, Nuts';
    const conditions = 'Hypertension, Diabetes';

    return Scaffold(
      appBar: const JoyNestAppBar(showBackButton: true),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Emergency Button
                SizedBox(
                  width: isLandscape ? 350 : double.infinity,
                  height: isLandscape ? 200 : 120,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.emergency_rounded,
                      size: isLandscape ? 80 : 60,
                      color: Colors.white,
                    ),
                    label: Text(
                      'EMERGENCY CALL',
                      style: TextStyle(
                        fontSize: isLandscape ? 42 : 34,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: getGridButtonColor(context, Colors.redAccent),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: () => _showEmergencyPopup(
                      context,
                      'Emergency Contact',
                      '+351 912 345 678',
                      Icons.emergency_rounded,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                // Medical Info Card
                Card(
                  color: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Medical Info',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        _medicalInfoRow('Blood Group', bloodGroup, context),
                        const SizedBox(height: 10),
                        _medicalInfoRow('Allergies', allergies, context),
                        const SizedBox(height: 10),
                        _medicalInfoRow('Conditions', conditions, context),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                // 112 Button
                SizedBox(
                  width: isLandscape ? 350 : double.infinity,
                  height: isLandscape ? 200 : 120,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.local_police_rounded,
                      size: isLandscape ? 80 : 60,
                      color: Colors.white,
                    ),
                    label: Text(
                      'LOCAL CARE SERVICES',
                      style: TextStyle(
                        fontSize: isLandscape ? 42 : 34,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: getGridButtonColor(context, Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: () => _showEmergencyPopup(
                      context,
                      'Emergency Services',
                      '112',
                      Icons.local_police_rounded,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _medicalInfoRow(String label, String value, BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class EmergencyCallPopup extends StatelessWidget {
  final String title;
  final String number;
  final IconData icon;

  const EmergencyCallPopup({
    super.key,
    required this.title,
    required this.number,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final isDark = settings.darkMode || settings.highContrast;

    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withAlpha(isDark ? 230 : 204),
              Colors.black.withAlpha(isDark ? 250 : 230),
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[700],
                    child: Icon(
                      icon,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Calling $number...',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.call_end, size: 32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
