// video_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../api/models_video.dart';
import '../widgets/footer.dart';
import '../widgets/no_internet_widget.dart';
import '../widgets/video_player_widget.dart';
import '../widgets/video_info_widget.dart';
import '../widgets/status_message_widget.dart';
import '../widgets/navigation_buttons_widget.dart';

class VideoDetailPage extends StatefulWidget {
  final Video initialVideo;
  final List<Video> videos;
  final int initialIndex;

  const VideoDetailPage({
    super.key,
    required this.initialVideo,
    required this.videos,
    required this.initialIndex,
  });

  @override
  VideoDetailPageState createState() => VideoDetailPageState();
}

class VideoDetailPageState extends State<VideoDetailPage> {
  late Video _video;
  late List<Video> _videos;
  int _currentIndex = 0;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _video = widget.initialVideo;
    _videos = widget.videos;
    _currentIndex = widget.initialIndex;
    _checkConnectivity();
  }

  Future<void> _retryConnection() async {
    await _checkConnectivity();
    if (_isConnected) {
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak ada koneksi internet')),
      );
    }
  }

  Future<void> _checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = result != ConnectivityResult.none;
    });
  }

  void _changeVideo(int index) {
    if (index >= 0 && index < _videos.length) {
      setState(() {
        _currentIndex = index;
        _video = _videos[_currentIndex];
      });
    }
  }

  void _handleBackButton() {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _handleBackButton();
        return false;
      },
      child: Scaffold(
        appBar: null,
        body: _isConnected
            ? OrientationBuilder(
                builder: (context, orientation) {
                  bool isLandscape = orientation == Orientation.landscape;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!isLandscape)
                        AppBar(
                          centerTitle: true,
                          title: const Text('Video Detail', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          iconTheme: const IconThemeData(color: Colors.white),
                          backgroundColor: Colors.teal,
                        ),
                      Expanded(
                        child: VideoPlayerWidget(
                          video: _video,
                          isLandscape: isLandscape,
                        ),
                      ),
                      if (_video.status != 'up') const StatusMessageWidget(),
                      if (!isLandscape) ...[
                        VideoInfoWidget(video: _video),
                        NavigationButtonsWidget(
                          currentIndex: _currentIndex,
                          totalVideos: _videos.length,
                          onChangeVideo: _changeVideo,
                        ),
                        const Footer(),
                      ],
                    ],
                  );
                },
              )
            : NoInternetWidget(onRetry: _retryConnection),
      ),
    );
  }
}
