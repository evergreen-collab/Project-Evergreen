import 'package:evergreen/widgets/joy_nest_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoMusicPage extends StatefulWidget {
  const VideoMusicPage({Key? key}) : super(key: key);

  @override
  State<VideoMusicPage> createState() => _VideoMusicSubpageState();
}

class _VideoMusicSubpageState extends State<VideoMusicPage> {
  final List<Map<String, dynamic>> musicCategories = [
    {'icon': Icons.music_note, 'title': 'Entertainment'},
    {'icon': Icons.photo_album, 'title': 'Memories'},
    {'icon': Icons.spa, 'title': 'Relaxation'},
    {'icon': Icons.forest, 'title': 'Nature Sounds'},
  ];

  final List<Map<String, dynamic>> videoHighlights = [
    {
      'thumbnail': 'assets/images/another_fish.png',
      'title': 'Friendly fish',
      'videoUrl': 'assets/videos/another_fish.mp4',
    },
    {
      'thumbnail': 'assets/images/color_palete.png',
      'title': 'Paint picking',
      'videoUrl': 'assets/videos/color_palete.mp4',
    },
    {
      'thumbnail': 'assets/images/sample.png',
      'title': 'Globe',
      'videoUrl': 'assets/videos/sample_video.mp4',
    },
  ];

  final List<Map<String, dynamic>> allVideos = [
    {
      'thumbnail': 'assets/images/fish_catch.png',
      'videoUrl': 'assets/videos/catch_fish.mp4',
    },
    {
      'thumbnail': 'assets/images/sample.png',
      'videoUrl': 'assets/videos/sample_video.mp4',
    },
    {
      'thumbnail': 'assets/images/studio.png',
      'videoUrl': 'assets/videos/studio_video.mp4',
    },
    {
      'thumbnail': 'assets/images/another_fish.png',
      'videoUrl': 'assets/videos/another_fish.mp4',
    },
    {
      'thumbnail': 'assets/images/color_palete.png',
      'videoUrl': 'assets/videos/color_palete.mp4',
    },
    {
      'thumbnail': 'assets/images/fish_catch.png',
      'videoUrl': 'assets/videos/catch_fish.mp4',
    },
    {
      'thumbnail': 'assets/images/sample.png',
      'videoUrl': 'assets/videos/sample_video.mp4',
    },
    {
      'thumbnail': 'assets/images/studio.png',
      'videoUrl': 'assets/videos/studio_video.mp4',
    },
    {
      'thumbnail': 'assets/images/another_fish.png',
      'videoUrl': 'assets/videos/another_fish.mp4',
    },
    {
      'thumbnail': 'assets/images/color_palete.png',
      'videoUrl': 'assets/videos/color_palete.mp4',
    },
  ];

  void _openVideoDialog(String videoUrl) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            insetPadding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayerWidget(videoUrl: videoUrl),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double buttonSize =
        MediaQuery.of(context).size.width < 600 ? 150 : 200;

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final padding = MediaQuery.of(context).size.shortestSide * 0.02;

    final gridHeight = ((allVideos.length / 4) + 1).floor() * 300;

    return Scaffold(
      appBar: JoyNestAppBar(showBackButton: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Music Playlist',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children:
                    musicCategories.map((category) {
                      return SizedBox(
                        width: buttonSize,
                        height: buttonSize,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors
                                    .primaries[musicCategories.indexOf(
                                          category,
                                        ) %
                                        Colors.primaries.length]
                                    .shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            foregroundColor:
                                Colors.white, // <-- white text and icon
                          ),
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(category['icon'], size: 40),
                              const SizedBox(height: 8),
                              Text(
                                category['title'],
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 32),
              const Text(
                'Video Highlights',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children:
                    videoHighlights.map((video) {
                      return GestureDetector(
                        onTap: () => _openVideoDialog(video['videoUrl']),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                video['thumbnail'],
                                width: 300,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: 150,
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              color: Colors.black.withOpacity(0.5),
                              child: Text(
                                video['title'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 32),
              const Text(
                'Videos',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: gridHeight.toDouble(), // Set a fixed height
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isLandscape ? 4 : 3,
                    mainAxisSpacing: padding,
                    crossAxisSpacing: padding,
                  ),
                  itemCount: allVideos.length,
                  itemBuilder: (context, index) {
                    final video = allVideos[index];
                    return GestureDetector(
                      onTap: () => _openVideoDialog(video['videoUrl']),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          video['thumbnail'],
                          width: 150,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Wrap(
              //   spacing: 16,
              //   runSpacing: 16,
              //   alignment: WrapAlignment.center,
              //   children:
              //       allVideos.map((video) {
              //         return GestureDetector(
              //           onTap: () => _openVideoDialog(video['videoUrl']),
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(12),
              //             child: Image.asset(
              //               video['thumbnail'],
              //               width: 150,
              //               height: 100,
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         );
              //       }).toList(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
            VideoProgressIndicator(_controller, allowScrubbing: true),
            Positioned(
              bottom: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
              ),
            ),
          ],
        )
        : const Center(child: CircularProgressIndicator());
  }
}
