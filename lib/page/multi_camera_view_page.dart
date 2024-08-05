// multi_camera_view_page.dart
// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../api/models_video.dart';

class MultiCameraViewPage extends StatefulWidget {
  final List<Video> cameras;

  const MultiCameraViewPage({super.key, required this.cameras});

  @override
  MultiCameraViewPageState createState() => MultiCameraViewPageState();
}

class MultiCameraViewPageState extends State<MultiCameraViewPage> {
  @override
  void initState() {
    super.initState();
    // Ensure the orientation is portrait when starting
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    // Reset the orientation settings when the page is disposed
    SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      // Switch to portrait mode if the current orientation is landscape
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Multi-Camera View',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.teal,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (MediaQuery.of(context).orientation == Orientation.landscape) {
                SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            int crossAxisCount = orientation == Orientation.portrait ? 2 : 3;
            double childAspectRatio = orientation == Orientation.portrait ? 16 / 9 : 4 / 3;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: widget.cameras.length,
                itemBuilder: (context, index) {
                  final camera = widget.cameras[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: camera.embed,
                          flags: const YoutubePlayerFlags(
                            autoPlay: true,
                            mute: true,
                            enableCaption: false,
                          ),
                        ),
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.teal,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
