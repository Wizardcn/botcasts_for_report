// To parse this JSON data, do
//
//     final contents = contentsFromJson(jsonString);

import 'dart:convert';

List<Content> contentsFromJson(String str) =>
    List<Content>.from(json.decode(str).map((x) => Content.fromJson(x)));

String contentsToJson(List<Content> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Content {
  Content({
    required this.id,
    required this.contentId,
    required this.contentType,
    required this.title,
    required this.imageUrl,
    required this.aiSpeaker,
    required this.audioUrl,
    required this.contentDetail,
  });

  String? id;
  int contentId;
  int contentType;
  String title;
  String imageUrl;
  String aiSpeaker;
  String audioUrl;
  String contentDetail;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        contentId: json["content_id"],
        contentType: json["content_type"],
        title: json["title"],
        imageUrl: json["image_url"],
        aiSpeaker: json["ai_speaker"],
        audioUrl: json["audio_url"],
        contentDetail: json["content_detail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content_id": contentId,
        "content_type": contentType,
        "title": title,
        "image_url": imageUrl,
        "ai_speaker": aiSpeaker,
        "audio_url": audioUrl,
        "content_detail": contentDetail,
      };
}
