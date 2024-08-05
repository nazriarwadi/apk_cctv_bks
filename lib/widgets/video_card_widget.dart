// video_card_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class VideoCard extends StatelessWidget {
  final String videoId;
  final String title;
  final String thumbnail;
  final bool isLive;

  const VideoCard({
    super.key,
    required this.videoId,
    required this.title,
    required this.thumbnail,
    this.isLive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: thumbnail,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: LoadingAnimationWidget.fallingDot(
                      color: Colors.teal,
                      size: 100,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Boxicons.bx_error_circle, color: Colors.red),
                ),
              ),
              if (isLive)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              const Icon(
                Boxicons.bx_play_circle,
                color: Colors.white,
                size: 60.0,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Html(
                data: title,
                style: {
                  "body": Style(
                    fontSize: FontSize(14.0),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    textAlign: TextAlign.center,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
