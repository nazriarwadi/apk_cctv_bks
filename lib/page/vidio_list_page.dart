// video_list_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../widgets/footer.dart';
import 'multi_camera_view_page.dart';
import '../api/video_service.dart';
import '../api/models_video.dart';
import '../widgets/no_internet_widget.dart';
import '../widgets/video_card_widget.dart';

class VideoListPage extends StatefulWidget {
  const VideoListPage({super.key});

  @override
  VideoListPageState createState() => VideoListPageState();
}

class VideoListPageState extends State<VideoListPage> {
  bool _isConnected = true;
  late Future<List<Video>> _videoFuture;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _videoFuture = VideoService().fetchVideos();
  }

  Future<void> _checkConnectivity() async {
    // Here, you can implement a custom check for connectivity if required
    // For now, we'll assume the connectivity is always true.
    setState(() {
      _isConnected = true;
    });
  }

  Future<void> _retryConnection() async {
    await _checkConnectivity();
    if (_isConnected) {
      setState(() {
        _videoFuture = VideoService().fetchVideos();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak ada koneksi internet')),
      );
    }
  }

  Future<void> _refreshVideos() async {
    await _checkConnectivity();
    if (_isConnected) {
      setState(() {
        _videoFuture = VideoService().fetchVideos();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak ada koneksi internet')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CCTV Bengkalis',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Boxicons.bx_desktop, color: Colors.white),
            onPressed: () async {
              if (_isConnected) {
                final videos = await VideoService().fetchVideos();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiCameraViewPage(cameras: videos),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tidak ada koneksi internet')),
                );
              }
            },
            tooltip: 'Multi-Camera View',
          ),
        ],
      ),
      body: _isConnected
          ? RefreshIndicator(
              onRefresh: _refreshVideos,
              child: FutureBuilder<List<Video>>(
                future: _videoFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.fallingDot(
                        color: Colors.teal,
                        size: 100,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return NoInternetWidget(onRetry: _retryConnection); // Display NoInternetWidget on error
                  } else if (snapshot.hasData) {
                    final videos = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: videos.length,
                              itemBuilder: (context, index) {
                                final video = videos[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/videoDetail',
                                      arguments: {
                                        'video': video,
                                        'videos': videos,
                                        'index': index,
                                      },
                                    );
                                  },
                                  child: VideoCard(
                                    videoId: video.embed,
                                    title: video.description,
                                    thumbnail: video.thumbnail,
                                    isLive: true, // Adjust based on live status if available
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
            )
          : NoInternetWidget(onRetry: _retryConnection),
      bottomNavigationBar: const Footer(),
    );
  }
}
