// models/video.dart
class Video {
  final String embed;
  final String description;
  final String thumbnail;
  final String status;

  Video({required this.embed, required this.description, required this.thumbnail, required this.status});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      embed: json['embed'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      status: json['status'],
    );
  }
}
