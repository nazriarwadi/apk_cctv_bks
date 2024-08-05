// video_info_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../api/models_video.dart';

class VideoInfoWidget extends StatelessWidget {
  final Video video;

  const VideoInfoWidget({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Html(
        data: video.description,
        style: {
          "body": Style(
            fontSize: FontSize(20.0),
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            textAlign: TextAlign.center,
          ),
        },
      ),
    );
  }
}
