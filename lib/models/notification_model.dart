class NotificationModel {
  final String? userId;
  final String? sendBy;
  final dynamic subscriptionId;
  final dynamic conversationId;
  final String? role;
  final String? title;
  final String? content;
  final String? icon;
  final String? image;
  final dynamic reaction;
  final String? status;
  final String? devStatus;
  final String? type;
  final String? priority;
  final DateTime? createdAt;
  final String? id;

  NotificationModel({
    this.userId,
    this.sendBy,
    this.subscriptionId,
    this.conversationId,
    this.role,
    this.title,
    this.content,
    this.icon,
    this.image,
    this.reaction,
    this.status,
    this.devStatus,
    this.type,
    this.priority,
    this.createdAt,
    this.id,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    userId: json["userId"],
    sendBy: json["sendBy"],
    subscriptionId: json["subscriptionId"],
    conversationId: json["conversationId"],
    role: json["role"],
    title: json["title"],
    content: json["content"],
    icon: json["icon"],
    image: json["image"],
    reaction: json["reaction"],
    status: json["status"],
    devStatus: json["devStatus"],
    type: json["type"],
    priority: json["priority"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "sendBy": sendBy,
    "subscriptionId": subscriptionId,
    "conversationId": conversationId,
    "role": role,
    "title": title,
    "content": content,
    "icon": icon,
    "image": image,
    "reaction": reaction,
    "status": status,
    "devStatus": devStatus,
    "type": type,
    "priority": priority,
    "createdAt": createdAt?.toIso8601String(),
    "id": id,
  };
}
