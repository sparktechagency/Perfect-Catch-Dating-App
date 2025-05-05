
class ConversationModel {
  final String? id;
  final Sender? sender;
  final Receiver? receiver;
  final int? unseenMsg;
  final LastMsg? lastMsg;

  ConversationModel({
    this.id,
    this.sender,
    this.receiver,
    this.unseenMsg,
    this.lastMsg,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    id: json["_id"],
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
    unseenMsg: json["unseenMsg"],
    lastMsg: json["lastMsg"] == null ? null : LastMsg.fromJson(json["lastMsg"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sender": sender?.toJson(),
    "receiver": receiver?.toJson(),
    "unseenMsg": unseenMsg,
    "lastMsg": lastMsg?.toJson(),
  };
}

class LastMsg {
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

  LastMsg({
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

  factory LastMsg.fromJson(Map<String, dynamic> json) => LastMsg(
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

class Receiver {
  final Location? location;
  final ReceiverSubscription? subscription;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final String? profileImage;
  final String? coverImage;
  final List<dynamic>? photos;
  final String? backgroundMusic;
  final String? role;
  final String? callingCode;
  final int? phoneNumber;
  final DateTime? dateOfBirth;
  final String? country;
  final String? state;
  final String? city;
  final dynamic religion;
  final List<String>? interested;
  final List<dynamic>? lickList;
  final dynamic height;
  final List<dynamic>? idealMatch;
  final List<dynamic>? language;
  final dynamic about;
  final List<dynamic>? modeOption;
  final int? credits;
  final bool? isProfileCompleted;
  final int? setDistance;
  final int? cupidCredits;
  final int? hugCredits;
  final int? kissCredits;
  final List<dynamic>? reactBy;
  final List<dynamic>? reactions;
  final DateTime? createdAt;
  final String? id;

  Receiver({
    this.location,
    this.subscription,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.profileImage,
    this.coverImage,
    this.photos,
    this.backgroundMusic,
    this.role,
    this.callingCode,
    this.phoneNumber,
    this.dateOfBirth,
    this.country,
    this.state,
    this.city,
    this.religion,
    this.interested,
    this.lickList,
    this.height,
    this.idealMatch,
    this.language,
    this.about,
    this.modeOption,
    this.credits,
    this.isProfileCompleted,
    this.setDistance,
    this.cupidCredits,
    this.hugCredits,
    this.kissCredits,
    this.reactBy,
    this.reactions,
    this.createdAt,
    this.id,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    subscription: json["subscription"] == null ? null : ReceiverSubscription.fromJson(json["subscription"]),
    firstName: json["firstName"],
    lastName: json["lastName"],
    fullName: json["fullName"],
    email: json["email"],
    profileImage: json["profileImage"],
    coverImage: json["coverImage"],
    photos: json["photos"] == null ? [] : List<dynamic>.from(json["photos"]!.map((x) => x)),
    backgroundMusic: json["backgroundMusic"],
    role: json["role"],
    callingCode: json["callingCode"],
    phoneNumber: json["phoneNumber"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    country: json["country"],
    state: json["state"],
    city: json["city"],
    religion: json["religion"],
    interested: json["interested"] == null ? [] : List<String>.from(json["interested"]!.map((x) => x)),
    lickList: json["lickList"] == null ? [] : List<dynamic>.from(json["lickList"]!.map((x) => x)),
    height: json["height"],
    idealMatch: json["idealMatch"] == null ? [] : List<dynamic>.from(json["idealMatch"]!.map((x) => x)),
    language: json["language"] == null ? [] : List<dynamic>.from(json["language"]!.map((x) => x)),
    about: json["about"],
    modeOption: json["modeOption"] == null ? [] : List<dynamic>.from(json["modeOption"]!.map((x) => x)),
    credits: json["credits"],
    isProfileCompleted: json["isProfileCompleted"],
    setDistance: json["setDistance"],
    cupidCredits: json["cupidCredits"],
    hugCredits: json["hugCredits"],
    kissCredits: json["kissCredits"],
    reactBy: json["reactBy"] == null ? [] : List<dynamic>.from(json["reactBy"]!.map((x) => x)),
    reactions: json["reactions"] == null ? [] : List<dynamic>.from(json["reactions"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "subscription": subscription?.toJson(),
    "firstName": firstName,
    "lastName": lastName,
    "fullName": fullName,
    "email": email,
    "profileImage": profileImage,
    "coverImage": coverImage,
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
    "backgroundMusic": backgroundMusic,
    "role": role,
    "callingCode": callingCode,
    "phoneNumber": phoneNumber,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "country": country,
    "state": state,
    "city": city,
    "religion": religion,
    "interested": interested == null ? [] : List<dynamic>.from(interested!.map((x) => x)),
    "lickList": lickList == null ? [] : List<dynamic>.from(lickList!.map((x) => x)),
    "height": height,
    "idealMatch": idealMatch == null ? [] : List<dynamic>.from(idealMatch!.map((x) => x)),
    "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
    "about": about,
    "modeOption": modeOption == null ? [] : List<dynamic>.from(modeOption!.map((x) => x)),
    "credits": credits,
    "isProfileCompleted": isProfileCompleted,
    "setDistance": setDistance,
    "cupidCredits": cupidCredits,
    "hugCredits": hugCredits,
    "kissCredits": kissCredits,
    "reactBy": reactBy == null ? [] : List<dynamic>.from(reactBy!.map((x) => x)),
    "reactions": reactions == null ? [] : List<dynamic>.from(reactions!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "id": id,
  };
}

class Location {
  final String? type;
  final List<int>? coordinates;
  final String? locationName;

  Location({
    this.type,
    this.coordinates,
    this.locationName,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<int>.from(json["coordinates"]!.map((x) => x)),
    locationName: json["locationName"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    "locationName": locationName,
  };
}

class ReceiverSubscription {
  final dynamic subscriptionExpirationDate;
  final String? status;
  final bool? isSubscriptionTaken;

  ReceiverSubscription({
    this.subscriptionExpirationDate,
    this.status,
    this.isSubscriptionTaken,
  });

  factory ReceiverSubscription.fromJson(Map<String, dynamic> json) => ReceiverSubscription(
    subscriptionExpirationDate: json["subscriptionExpirationDate"],
    status: json["status"],
    isSubscriptionTaken: json["isSubscriptionTaken"],
  );

  Map<String, dynamic> toJson() => {
    "subscriptionExpirationDate": subscriptionExpirationDate,
    "status": status,
    "isSubscriptionTaken": isSubscriptionTaken,
  };
}

class Sender {
  final Location? location;
  final SenderSubscription? subscription;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final String? profileImage;
  final String? coverImage;
  final List<dynamic>? photos;
  final String? backgroundMusic;
  final String? gender;
  final String? role;
  final dynamic country;
  final dynamic state;
  final dynamic city;
  final dynamic religion;
  final List<dynamic>? interested;
  final List<dynamic>? lickList;
  final dynamic height;
  final List<dynamic>? idealMatch;
  final List<dynamic>? language;
  final dynamic about;
  final String? mode;
  final List<String>? modeOption;
  final int? credits;
  final bool? isProfileCompleted;
  final int? setDistance;
  final int? cupidCredits;
  final int? hugCredits;
  final int? kissCredits;
  final List<dynamic>? reactBy;
  final List<dynamic>? reactions;
  final DateTime? createdAt;
  final String? id;

  Sender({
    this.location,
    this.subscription,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.profileImage,
    this.coverImage,
    this.photos,
    this.backgroundMusic,
    this.gender,
    this.role,
    this.country,
    this.state,
    this.city,
    this.religion,
    this.interested,
    this.lickList,
    this.height,
    this.idealMatch,
    this.language,
    this.about,
    this.mode,
    this.modeOption,
    this.credits,
    this.isProfileCompleted,
    this.setDistance,
    this.cupidCredits,
    this.hugCredits,
    this.kissCredits,
    this.reactBy,
    this.reactions,
    this.createdAt,
    this.id,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    subscription: json["subscription"] == null ? null : SenderSubscription.fromJson(json["subscription"]),
    firstName: json["firstName"],
    lastName: json["lastName"],
    fullName: json["fullName"],
    email: json["email"],
    profileImage: json["profileImage"],
    coverImage: json["coverImage"],
    photos: json["photos"] == null ? [] : List<dynamic>.from(json["photos"]!.map((x) => x)),
    backgroundMusic: json["backgroundMusic"],
    gender: json["gender"],
    role: json["role"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    religion: json["religion"],
    interested: json["interested"] == null ? [] : List<dynamic>.from(json["interested"]!.map((x) => x)),
    lickList: json["lickList"] == null ? [] : List<dynamic>.from(json["lickList"]!.map((x) => x)),
    height: json["height"],
    idealMatch: json["idealMatch"] == null ? [] : List<dynamic>.from(json["idealMatch"]!.map((x) => x)),
    language: json["language"] == null ? [] : List<dynamic>.from(json["language"]!.map((x) => x)),
    about: json["about"],
    mode: json["mode"],
    modeOption: json["modeOption"] == null ? [] : List<String>.from(json["modeOption"]!.map((x) => x)),
    credits: json["credits"],
    isProfileCompleted: json["isProfileCompleted"],
    setDistance: json["setDistance"],
    cupidCredits: json["cupidCredits"],
    hugCredits: json["hugCredits"],
    kissCredits: json["kissCredits"],
    reactBy: json["reactBy"] == null ? [] : List<dynamic>.from(json["reactBy"]!.map((x) => x)),
    reactions: json["reactions"] == null ? [] : List<dynamic>.from(json["reactions"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "subscription": subscription?.toJson(),
    "firstName": firstName,
    "lastName": lastName,
    "fullName": fullName,
    "email": email,
    "profileImage": profileImage,
    "coverImage": coverImage,
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
    "backgroundMusic": backgroundMusic,
    "gender": gender,
    "role": role,
    "country": country,
    "state": state,
    "city": city,
    "religion": religion,
    "interested": interested == null ? [] : List<dynamic>.from(interested!.map((x) => x)),
    "lickList": lickList == null ? [] : List<dynamic>.from(lickList!.map((x) => x)),
    "height": height,
    "idealMatch": idealMatch == null ? [] : List<dynamic>.from(idealMatch!.map((x) => x)),
    "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
    "about": about,
    "mode": mode,
    "modeOption": modeOption == null ? [] : List<dynamic>.from(modeOption!.map((x) => x)),
    "credits": credits,
    "isProfileCompleted": isProfileCompleted,
    "setDistance": setDistance,
    "cupidCredits": cupidCredits,
    "hugCredits": hugCredits,
    "kissCredits": kissCredits,
    "reactBy": reactBy == null ? [] : List<dynamic>.from(reactBy!.map((x) => x)),
    "reactions": reactions == null ? [] : List<dynamic>.from(reactions!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "id": id,
  };
}

class SenderSubscription {
  final String? subscriptionId;
  final String? stripeSubId;
  final DateTime? subscriptionExpirationDate;
  final String? status;
  final bool? isSubscriptionTaken;

  SenderSubscription({
    this.subscriptionId,
    this.stripeSubId,
    this.subscriptionExpirationDate,
    this.status,
    this.isSubscriptionTaken,
  });

  factory SenderSubscription.fromJson(Map<String, dynamic> json) => SenderSubscription(
    subscriptionId: json["subscriptionId"],
    stripeSubId: json["stripeSubId"],
    subscriptionExpirationDate: json["subscriptionExpirationDate"] == null ? null : DateTime.parse(json["subscriptionExpirationDate"]),
    status: json["status"],
    isSubscriptionTaken: json["isSubscriptionTaken"],
  );

  Map<String, dynamic> toJson() => {
    "subscriptionId": subscriptionId,
    "stripeSubId": stripeSubId,
    "subscriptionExpirationDate": subscriptionExpirationDate?.toIso8601String(),
    "status": status,
    "isSubscriptionTaken": isSubscriptionTaken,
  };
}
