import 'dart:async';
import 'package:flutter/material.dart';

class PhotoItem extends StatelessWidget {
  final List<String> imageUrls;
  final int currentIndex;

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

  Widget _buildImageDialog(
    BuildContext context,
    List<String> imageUrls,
    int index,
  ) {
    final maxWidth = MediaQuery.of(context).size.width * 0.9;
    final maxHeight = MediaQuery.of(context).size.height * 0.8;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Center(
        child: FutureBuilder<ImageInfo>(
          future: _getImageInfo(imageUrls[index]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final imageInfo = snapshot.data!;
              final aspectRatio =
                  imageInfo.image.width / imageInfo.image.height;

              // Compute constrained size based on max width/height while preserving aspect ratio
              double displayWidth = maxWidth;
              double displayHeight = displayWidth / aspectRatio;

              if (displayHeight > maxHeight) {
                displayHeight = maxHeight;
                displayWidth = displayHeight * aspectRatio;
              }

              return Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: SizedBox(
                          width: displayWidth,
                          height: displayHeight,
                          child: Image.network(
                            imageUrls[index],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      // Bottom-only white bar
                      Container(
                        width: displayWidth,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: () => Navigator.of(context).pop(),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey.shade200,
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                            ),
                            icon: const Icon(Icons.close, color: Colors.black),
                            label: const Text(
                              'Close',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Left arrow
                  Positioned(
                    left: 8,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_left,
                        size: 36,
                        color: Colors.white,
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

                  // Right arrow
                  Positioned(
                    right: 8,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_right,
                        size: 36,
                        color: Colors.white,
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
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  // Gets the image info to calculate the aspect ratio
  Future<ImageInfo> _getImageInfo(String url) async {
    final completer = Completer<ImageInfo>();
    final image = NetworkImage(url);
    final stream = image.resolve(const ImageConfiguration());
    stream.addListener(
      ImageStreamListener((info, _) => completer.complete(info)),
    );
    return completer.future;
  }
}
