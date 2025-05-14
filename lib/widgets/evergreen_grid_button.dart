import 'package:flutter/material.dart';

class EvergreenGridButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const EvergreenGridButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide;
        final backgroundColor = color.withValues(alpha: 1);

        // Calculate perceived brightness (Luma formula)
        final luminance = backgroundColor.computeLuminance();
        final isLight = luminance > 0.5;

        final iconTextColor = isLight ? Colors.black87 : Colors.white;

        return Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: backgroundColor.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon,
                    size: size * 0.38,
                    color: iconTextColor.withValues(alpha: 0.9),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: size * 0.14,
                      fontWeight: FontWeight.w600,
                      color: iconTextColor.withValues(alpha: 0.9),
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
