// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final Location? location;
  final Subscription? subscription;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final String? profileImage;
  final String? coverImage;
  final List<String>? photos;
  final String? backgroundMusic;
  final String? gender;
  final String? role;
  final dynamic callingCode;
  final dynamic phoneNumber;
  final dynamic dateOfBirth;
  final dynamic country;
  final dynamic state;
  final dynamic city;
  final dynamic religion;
  final List<dynamic>? interested;
  final List<dynamic>? lickList;
  final dynamic height;
  final dynamic weight;
  final List<dynamic>? idealMatch;
  final List<dynamic>? language;
  final dynamic about;
  final String? mode;
  final List<String>? modeOption;
  final dynamic personalStatus;
  final dynamic educationQualification;
  final int? credits;
  final bool? isProfileCompleted;
  final int? setDistance;
  final int? cupidCredits;
  final int? hugCredits;
  final int? kissCredits;
  final bool? isBlock;
  final List<dynamic>? reactBy;
  final List<dynamic>? reactions;
  final DateTime? createdAt;
  final String? id;

  UserModel({
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
    this.weight,
    this.idealMatch,
    this.language,
    this.about,
    this.mode,
    this.modeOption,
    this.personalStatus,
    this.educationQualification,
    this.credits,
    this.isProfileCompleted,
    this.setDistance,
    this.cupidCredits,
    this.hugCredits,
    this.kissCredits,
    this.isBlock,
    this.reactBy,
    this.reactions,
    this.createdAt,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
    firstName: json["firstName"],
    lastName: json["lastName"],
    fullName: json["fullName"],
    email: json["email"],
    profileImage: json["profileImage"],
    coverImage: json["coverImage"],
    photos: json["photos"] == null ? [] : List<String>.from(json["photos"]!.map((x) => x)),
    backgroundMusic: json["backgroundMusic"],
    gender: json["gender"],
    role: json["role"],
    callingCode: json["callingCode"],
    phoneNumber: json["phoneNumber"],
    dateOfBirth: json["dateOfBirth"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    religion: json["religion"],
    interested: json["interested"] == null ? [] : List<dynamic>.from(json["interested"]!.map((x) => x)),
    lickList: json["lickList"] == null ? [] : List<dynamic>.from(json["lickList"]!.map((x) => x)),
    height: json["height"],
    weight: json["weight"],
    idealMatch: json["idealMatch"] == null ? [] : List<dynamic>.from(json["idealMatch"]!.map((x) => x)),
    language: json["language"] == null ? [] : List<dynamic>.from(json["language"]!.map((x) => x)),
    about: json["about"],
    mode: json["mode"],
    modeOption: json["modeOption"] == null ? [] : List<String>.from(json["modeOption"]!.map((x) => x)),
    personalStatus: json["personalStatus"],
    educationQualification: json["educationQualification"],
    credits: json["credits"],
    isProfileCompleted: json["isProfileCompleted"],
    setDistance: json["setDistance"],
    cupidCredits: json["cupidCredits"],
    hugCredits: json["hugCredits"],
    kissCredits: json["kissCredits"],
    isBlock: json["isBlock"],
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
    "callingCode": callingCode,
    "phoneNumber": phoneNumber,
    "dateOfBirth": dateOfBirth,
    "country": country,
    "state": state,
    "city": city,
    "religion": religion,
    "interested": interested == null ? [] : List<dynamic>.from(interested!.map((x) => x)),
    "lickList": lickList == null ? [] : List<dynamic>.from(lickList!.map((x) => x)),
    "height": height,
    "weight": weight,
    "idealMatch": idealMatch == null ? [] : List<dynamic>.from(idealMatch!.map((x) => x)),
    "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
    "about": about,
    "mode": mode,
    "modeOption": modeOption == null ? [] : List<dynamic>.from(modeOption!.map((x) => x)),
    "personalStatus": personalStatus,
    "educationQualification": educationQualification,
    "credits": credits,
    "isProfileCompleted": isProfileCompleted,
    "setDistance": setDistance,
    "cupidCredits": cupidCredits,
    "hugCredits": hugCredits,
    "kissCredits": kissCredits,
    "isBlock": isBlock,
    "reactBy": reactBy == null ? [] : List<dynamic>.from(reactBy!.map((x) => x)),
    "reactions": reactions == null ? [] : List<dynamic>.from(reactions!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "id": id,
  };
}

class Location {
  final String? type;
  final List<double>? coordinates;
  final String? locationName;

  Location({
    this.type,
    this.coordinates,
    this.locationName,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
    locationName: json["locationName"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    "locationName": locationName,
  };
}

class Subscription {
  final dynamic subscriptionExpirationDate;
  final String? status;
  final bool? isSubscriptionTaken;

  Subscription({
    this.subscriptionExpirationDate,
    this.status,
    this.isSubscriptionTaken,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
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
