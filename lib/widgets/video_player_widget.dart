// video_player_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../api/models_video.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Video video;
  final bool isLandscape;

  const VideoPlayerWidget({
    super.key,
    required this.video,
    required this.isLandscape,
  });

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.embed,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        forceHD: true,
      ),
    );
  }

  @override
  void didUpdateWidget(VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.video.embed != widget.video.embed) {
      _controller.load(widget.video.embed);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        bool isLandscape = orientation == Orientation.landscape;
        if (isLandscape) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
        } else {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        }

        return Visibility(
          visible: widget.isLandscape == isLandscape,
          child: AspectRatio(
            aspectRatio: isLandscape ? 16 / 9 : 4 / 3,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.teal,
              bufferIndicator: Center(
                child: LoadingAnimationWidget.dotsTriangle(
                  color: Colors.teal,
                  size: 100,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
