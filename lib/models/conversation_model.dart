// location_model.dart
class LocationModel {
  final String type;
  final List<int> coordinates;
  final String locationName;

  LocationModel({
    required this.type,
    required this.coordinates,
    required this.locationName,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json['type'],
      coordinates: List<int>.from(json['coordinates']),
      locationName: json['locationName'],
    );
  }
}


// subscription_model.dart
class SubscriptionModel {
  final String? subscriptionExpirationDate;
  final String status;
  final bool isSubscriptionTaken;

  SubscriptionModel({
    this.subscriptionExpirationDate,
    required this.status,
    required this.isSubscriptionTaken,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      subscriptionExpirationDate: json['subscriptionExpirationDate'],
      status: json['status'],
      isSubscriptionTaken: json['isSubscriptionTaken'],
    );
  }
}


// reaction_model.dart
class ReactionModel {
  final String user;
  final String reaction;
  final DateTime createdAt;

  ReactionModel({
    required this.user,
    required this.reaction,
    required this.createdAt,
  });

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    return ReactionModel(
      user: json['user'],
      reaction: json['reaction'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class UserModel {
  final String fullName;
  final String email;
  final String? firstName;
  final String? lastName;
  final String profileImage;
  final String coverImage;
  final List<String> photos;
  final String backgroundMusic;
  final String gender;
  final String role;
  final bool isProfileCompleted;
  final int credits;
  final int cupidCredits;
  final int hugCredits;
  final int kissCredits;
  final bool isBlock;
  final String mode;
  final List<String> modeOption;
  final LocationModel location;
  final SubscriptionModel subscription;
  final List<ReactionModel> reactBy;
  final List<ReactionModel> reactions;
  final String id;

  UserModel({
    required this.fullName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.coverImage,
    required this.photos,
    required this.backgroundMusic,
    required this.gender,
    required this.role,
    required this.isProfileCompleted,
    required this.credits,
    required this.cupidCredits,
    required this.hugCredits,
    required this.kissCredits,
    required this.isBlock,
    required this.mode,
    required this.modeOption,
    required this.location,
    required this.subscription,
    required this.reactBy,
    required this.reactions,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImage: json['profileImage'],
      coverImage: json['coverImage'],
      photos: List<String>.from(json['photos']),
      backgroundMusic: json['backgroundMusic'],
      gender: json['gender'],
      role: json['role'],
      isProfileCompleted: json['isProfileCompleted'],
      credits: json['credits'],
      cupidCredits: json['cupidCredits'],
      hugCredits: json['hugCredits'],
      kissCredits: json['kissCredits'],
      isBlock: json['isBlock'],
      mode: json['mode'],
      modeOption: List<String>.from(json['modeOption']),
      location: LocationModel.fromJson(json['location']),
      subscription: SubscriptionModel.fromJson(json['subscription']),
      reactBy: List<ReactionModel>.from(json['reactBy'].map((x) => ReactionModel.fromJson(x))),
      reactions: List<ReactionModel>.from(json['reactions'].map((x) => ReactionModel.fromJson(x))),
      id: json['id'],
    );
  }
}


// message_model.dart
class MessageModel {
  final String conversationId;
  final String text;
  final String imageUrl;
  final String videoUrl;
  final String fileUrl;
  final String type;
  final bool seen;
  final String msgByUserId;
  final DateTime createdAt;
  final String id;

  MessageModel({
    required this.conversationId,
    required this.text,
    required this.imageUrl,
    required this.videoUrl,
    required this.fileUrl,
    required this.type,
    required this.seen,
    required this.msgByUserId,
    required this.createdAt,
    required this.id,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      conversationId: json['conversationId'] ?? '',
      text: json['text'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
      type: json['type'] ?? '',
      seen: json['seen'] ?? false,
      msgByUserId: json['msgByUserId'] ?? '',
      createdAt: json['createdAt'] == null ?  DateTime.now() : DateTime.parse(json['createdAt']),
      id: json['id'] ?? '',
    );
  }
}

// conversation_model.dart
class ConversationModel {
  final String id;
  final UserModel sender;
  final UserModel receiver;
  final int unseenMsg;
  final MessageModel? lastMsg;

  ConversationModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.unseenMsg,
    required this.lastMsg,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['_id'],
      sender: UserModel.fromJson(json['sender']),
      receiver: UserModel.fromJson(json['receiver']),
      unseenMsg: json['unseenMsg'] ?? 0,
      lastMsg: json['lastMsg'] != null ? MessageModel.fromJson(json['lastMsg']) : null,
    );
  }
}

