// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

List<MessageModel> messageModelFromJson(String str) => List<MessageModel>.from(json.decode(str).map((x) => MessageModel.fromJson(x)));

String messageModelToJson(List<MessageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageModel {
  final String? conversationId;
  final String? text;
  final String? imageUrl;
  final String? videoUrl;
  final String? fileUrl;
  final String? type;
  final bool? seen;
  final String? msgByUserId;
  final DateTime? createdAt;
  final String? id;

  MessageModel({
    this.conversationId,
    this.text,
    this.imageUrl,
    this.videoUrl,
    this.fileUrl,
    this.type,
    this.seen,
    this.msgByUserId,
    this.createdAt,
    this.id,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    conversationId: json["conversationId"],
    text: json["text"],
    imageUrl: json["imageUrl"],
    videoUrl: json["videoUrl"],
    fileUrl: json["fileUrl"],
    type: json["type"],
    seen: json["seen"],
    msgByUserId: json["msgByUserId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "conversationId": conversationId,
    "text": text,
    "imageUrl": imageUrl,
    "videoUrl": videoUrl,
    "fileUrl": fileUrl,
    "type": type,
    "seen": seen,
    "msgByUserId": msgByUserId,
    "createdAt": createdAt?.toIso8601String(),
    "id": id,
  };
}
