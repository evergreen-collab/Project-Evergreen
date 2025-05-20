import 'package:evergreen/widgets/photo_item.dart';
import 'package:flutter/material.dart';
import '../widgets/joy_nest_app_bar.dart';
import '../widgets/photo_item.dart'; // Import the PhotoItem widget

class PhotosPage extends StatelessWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample image URLs (replace with your own images)
    final List<Map<String, String>> photos = [
      {'url': 'assets/images/JoyNest.png', 'label': 'Photo 1'},
      {'url': 'assets/images/rectangle_porto.jpg', 'label': 'Photo 2'},
      {'url': 'assets/images/square_porto.jpg', 'label': 'Photo 3'},
      {'url': 'assets/images/rectangle_porto.jpg', 'label': 'Photo 4'},
      {'url': 'assets/images/square_porto.jpg', 'label': 'Photo 5'},
      {'url': 'assets/images/JoyNest.png', 'label': 'Photo 6'},
    ];

    // Use MediaQuery to determine orientation and size
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final padding =
        MediaQuery.of(context).size.shortestSide * 0.02; // Reduced padding

    return Scaffold(
      appBar: JoyNestAppBar(showBackButton: true),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isLandscape ? 4 : 3, // Adjust based on orientation
            mainAxisSpacing: padding,
            crossAxisSpacing: padding,
          ),
          itemCount: photos.length,
          itemBuilder: (context, index) {
            return PhotoItem(
              imageUrl: photos[index]['url']!,
              label: photos[index]['label']!,
            );
          },
        ),
      ),
    );
  }
}
