// navigation_buttons_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class NavigationButtonsWidget extends StatelessWidget {
  final int currentIndex;
  final int totalVideos;
  final ValueChanged<int> onChangeVideo;

  const NavigationButtonsWidget({
    super.key,
    required this.currentIndex,
    required this.totalVideos,
    required this.onChangeVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: currentIndex > 0 ? () => onChangeVideo(currentIndex - 1) : null,
            icon: const Icon(Boxicons.bx_chevrons_left),
            label: const Text('Back'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              textStyle: const TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: currentIndex < totalVideos - 1
                ? () => onChangeVideo(currentIndex + 1)
                : null,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              textStyle: const TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Next'),
                SizedBox(width: 8.0), // Space between text and icon
                Icon(Boxicons.bx_chevrons_right),
              ],
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {}, // Placeholder for PiP mode toggle
          //   style: ElevatedButton.styleFrom(
          //     foregroundColor: Colors.white,
          //     backgroundColor: Colors.teal,
          //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //     textStyle: const TextStyle(fontSize: 16),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(12.0),
          //     ),
          //   ),
          //   child: const Text('PiP Mode'),
          // ),
        ],
      ),
    );
  }
}
