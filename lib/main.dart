import 'package:apk_cctv/page/full_page.dart';
import 'package:flutter/material.dart';
import 'page/splash_screen.dart';
import 'page/vidio_list_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/videoList': (context) => const VideoListPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/videoDetail') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => VideoDetailPage(
              initialVideo: args['video'],
              videos: args['videos'],
              initialIndex: args['index'],
            ),
          );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}