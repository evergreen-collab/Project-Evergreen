import 'package:flutter/material.dart';

class PhotoItem extends StatelessWidget {
  final List<String> imageUrls; // List of image URLs
  final int currentIndex; // Current index of the image

  const PhotoItem({
    Key? key,
    required this.imageUrls,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder:
              (context) => _buildImageDialog(context, imageUrls, currentIndex),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(imageUrls[currentIndex], fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  // Helper method to build the image dialog
  Widget _buildImageDialog(
    BuildContext context,
    List<String> imageUrls,
    int index,
  ) {
    return Dialog(
      backgroundColor: Colors.transparent, // Make the background transparent
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image with arrows on sides
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrls[index],
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.6,
                    ),
                  ),
                  // Left Arrow
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      iconSize: 36,
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.arrow_left, color: Colors.white),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        shape: const CircleBorder(),
                      ),
                      onPressed: () {
                        if (index > 0) {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder:
                                (context) => _buildImageDialog(
                                  context,
                                  imageUrls,
                                  index - 1,
                                ),
                          );
                        }
                      },
                    ),
                  ),
                  // Right Arrow
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      iconSize: 36,
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.arrow_right, color: Colors.white),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        shape: const CircleBorder(),
                      ),
                      onPressed: () {
                        if (index < imageUrls.length - 1) {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder:
                                (context) => _buildImageDialog(
                                  context,
                                  imageUrls,
                                  index + 1,
                                ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),

              // Bottom "white border" container with Close button
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    label: const Text(
                      'Close',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
