import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/joy_nest_app_bar.dart';
import '../providers/settings_provider.dart';

class PhotosPage extends StatelessWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final bool isDark = settings.darkMode || settings.highContrast;
    final Color backgroundColor = isDark ? Colors.grey[900]! : Colors.white;

    final List<Map<String, String>> photos = [
      {'url': 'assets/images/JoyNest.png', 'label': 'Photo 1'},
      {'url': 'assets/images/rectangle_porto.jpg', 'label': 'Photo 2'},
      {'url': 'assets/images/square_porto.jpg', 'label': 'Photo 3'},
      {'url': 'assets/images/rectangle_porto.jpg', 'label': 'Photo 4'},
      {'url': 'assets/images/square_porto.jpg', 'label': 'Photo 5'},
      {'url': 'assets/images/JoyNest.png', 'label': 'Photo 6'},
    ];

    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final padding = MediaQuery.of(context).size.shortestSide * 0.02;

    return Scaffold(
      appBar: const JoyNestAppBar(showBackButton: true),
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isLandscape ? 4 : 3,
              mainAxisSpacing: padding,
              crossAxisSpacing: padding,
            ),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return PhotoItem(
                imageUrls: photos.map((photo) => photo['url']!).toList(),
                currentIndex: index,
                borderColor: isDark ? Colors.white54 : Colors.grey[800],
                textColor: isDark ? Colors.white : Colors.black,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => FullscreenPhotoDialog(
                      photos: photos,
                      initialIndex: index,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class PhotoItem extends StatelessWidget {
  final List<String> imageUrls;
  final int currentIndex;
  final Color? borderColor;
  final Color? textColor;
  final VoidCallback? onTap;

  const PhotoItem({
    Key? key,
    required this.imageUrls,
    required this.currentIndex,
    this.borderColor,
    this.textColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrls[currentIndex],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              bottom: 4,
              left: 4,
              child: Text(
                'Photo ${currentIndex + 1}',
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black.withValues(alpha: 0.5),
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullscreenPhotoDialog extends StatefulWidget {
  final List<Map<String, String>> photos;
  final int initialIndex;

  const FullscreenPhotoDialog({
    Key? key,
    required this.photos,
    required this.initialIndex,
  }) : super(key: key);

  @override
  FullscreenPhotoDialogState createState() => FullscreenPhotoDialogState();
}

class FullscreenPhotoDialogState extends State<FullscreenPhotoDialog> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void _goToPrevious() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  void _goToNext() {
    setState(() {
      if (currentIndex < widget.photos.length - 1) {
        currentIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String imageUrl = widget.photos[currentIndex]['url']!;
    final String label = widget.photos[currentIndex]['label'] ?? 'Photo ${currentIndex + 1}';

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          Container(
            color: Colors.black.withValues(alpha: 0.95),
            child: Center(
              child: InteractiveViewer(
                child: Image.asset(imageUrl),
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            left: 32,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black.withValues(alpha: 0.7),
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 24,
            right: 24,
            child: IconButton(
              icon: Icon(Icons.close, size: 36, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // Left arrow
          Positioned(
            left: 16,
            top: MediaQuery.of(context).size.height / 2 - 24,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 48, color: currentIndex > 0 ? Colors.white : Colors.white54),
              onPressed: currentIndex > 0 ? _goToPrevious : null,
              tooltip: 'Previous photo',
            ),
          ),
          // Right arrow
          Positioned(
            right: 16,
            top: MediaQuery.of(context).size.height / 2 - 24,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios, size: 48, color: currentIndex < widget.photos.length - 1 ? Colors.white : Colors.white54),
              onPressed: currentIndex < widget.photos.length - 1 ? _goToNext : null,
              tooltip: 'Next photo',
            ),
          ),
        ],
      ),
    );
  }
}
