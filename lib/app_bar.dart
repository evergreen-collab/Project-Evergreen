import 'package:flutter/material.dart';

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
              ? IconButton(
                icon: const Icon(Icons.arrow_back, size: 40),
                onPressed: onBack ?? () => Navigator.of(context).pop(),
                tooltip: 'Back',
              )
              : Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'assets/JoyNest.png',
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
        IconButton(
          icon: const Icon(Icons.settings),
          iconSize: 50,
          tooltip: 'Settings',
          onPressed: () {
            // TODO: Open settings
          },
        ),
      ],
      elevation: 0,
    );
  }
}
