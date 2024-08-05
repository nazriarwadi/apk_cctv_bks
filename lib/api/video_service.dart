// services/video_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/models_video.dart';
import '../api/api_config.dart';

class VideoService {
  Future<List<Video>> fetchVideos() async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/api.php'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Video.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
