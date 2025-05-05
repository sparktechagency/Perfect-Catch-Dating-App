class MatchesModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final String? profileImage;
  final String? coverImage;
  final List<String>? photos;
  final String? role;
  final String? country;
  final String? state;
  final String? city;
  final int? kids;
  final String? hobbiesAndActivities;
  final String? musicAndEntertainment;
  final String? sportsAndFitness;
  final String? foodAndDrinks;
  final String? lifestyleValues;
  final List<dynamic>? lickList;
  final List<dynamic>? idealMatch;
  final List<dynamic>? language;
  final Location? location;
  final String? bio;
  final dynamic oneTimeCode;
  final bool? isEmailVerified;
  final bool? isResetPassword;
  final int? credits;
  final bool? isProfileCompleted;
  final String? fcmToken;
  final bool? isBlocked;
  final int? setDistance;
  final int? lickCredits;
  final int? loveCredits;
  final int? winkCredits;
  final Subscription? subscription;
  final bool? isDeleted;
  final List<React>? reactBy;
  final List<React>? reactions;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final DateTime? dateOfBirth;
  final String? interestedIn;
  final String? lookingFor;
  final String? race;
  final dynamic phoneNumber;
  final int? age;
  final String? formattedDistance;

  MatchesModel({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.profileImage,
    this.coverImage,
    this.photos,
    this.role,
    this.country,
    this.state,
    this.city,
    this.kids,
    this.hobbiesAndActivities,
    this.musicAndEntertainment,
    this.sportsAndFitness,
    this.foodAndDrinks,
    this.lifestyleValues,
    this.lickList,
    this.idealMatch,
    this.language,
    this.location,
    this.bio,
    this.oneTimeCode,
    this.isEmailVerified,
    this.isResetPassword,
    this.credits,
    this.isProfileCompleted,
    this.fcmToken,
    this.isBlocked,
    this.setDistance,
    this.lickCredits,
    this.loveCredits,
    this.winkCredits,
    this.subscription,
    this.isDeleted,
    this.reactBy,
    this.reactions,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.dateOfBirth,
    this.interestedIn,
    this.lookingFor,
    this.race,
    this.phoneNumber,
    this.age,
    this.formattedDistance,
  });

  factory MatchesModel.fromJson(Map<String, dynamic> json) => MatchesModel(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    fullName: json["fullName"],
    email: json["email"],
    profileImage: json["profileImage"],
    coverImage: json["coverImage"],
    photos: json["photos"] == null ? [] : List<String>.from(json["photos"]!.map((x) => x)),
    role: json["role"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    kids: json["kids"],
    hobbiesAndActivities: json["hobbiesAndActivities"],
    musicAndEntertainment: json["musicAndEntertainment"],
    sportsAndFitness: json["sportsAndFitness"],
    foodAndDrinks: json["foodAndDrinks"],
    lifestyleValues: json["lifestyleValues"],
    lickList: json["lickList"] == null ? [] : List<dynamic>.from(json["lickList"]!.map((x) => x)),
    idealMatch: json["idealMatch"] == null ? [] : List<dynamic>.from(json["idealMatch"]!.map((x) => x)),
    language: json["language"] == null ? [] : List<dynamic>.from(json["language"]!.map((x) => x)),
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    bio: json["bio"],
    oneTimeCode: json["oneTimeCode"],
    isEmailVerified: json["isEmailVerified"],
    isResetPassword: json["isResetPassword"],
    credits: json["credits"],
    isProfileCompleted: json["isProfileCompleted"],
    fcmToken: json["fcmToken"],
    isBlocked: json["isBlocked"],
    setDistance: json["setDistance"],
    lickCredits: json["lickCredits"],
    loveCredits: json["loveCredits"],
    winkCredits: json["winkCredits"],
    subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
    isDeleted: json["isDeleted"],
    reactBy: json["reactBy"] == null ? [] : List<React>.from(json["reactBy"]!.map((x) => React.fromJson(x))),
    reactions: json["reactions"] == null ? [] : List<React>.from(json["reactions"]!.map((x) => React.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    interestedIn: json["interestedIn"],
    lookingFor: json["lookingFor"],
    race: json["race"],
    phoneNumber: json["phoneNumber"],
    age: json["age"],
    formattedDistance: json["formattedDistance"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "fullName": fullName,
    "email": email,
    "profileImage": profileImage,
    "coverImage": coverImage,
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
    "role": role,
    "country": country,
    "state": state,
    "city": city,
    "kids": kids,
    "hobbiesAndActivities": hobbiesAndActivities,
    "musicAndEntertainment": musicAndEntertainment,
    "sportsAndFitness": sportsAndFitness,
    "foodAndDrinks": foodAndDrinks,
    "lifestyleValues": lifestyleValues,
    "lickList": lickList == null ? [] : List<dynamic>.from(lickList!.map((x) => x)),
    "idealMatch": idealMatch == null ? [] : List<dynamic>.from(idealMatch!.map((x) => x)),
    "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
    "location": location?.toJson(),
    "bio": bio,
    "oneTimeCode": oneTimeCode,
    "isEmailVerified": isEmailVerified,
    "isResetPassword": isResetPassword,
    "credits": credits,
    "isProfileCompleted": isProfileCompleted,
    "fcmToken": fcmToken,
    "isBlocked": isBlocked,
    "setDistance": setDistance,
    "lickCredits": lickCredits,
    "loveCredits": loveCredits,
    "winkCredits": winkCredits,
    "subscription": subscription?.toJson(),
    "isDeleted": isDeleted,
    "reactBy": reactBy == null ? [] : List<dynamic>.from(reactBy!.map((x) => x.toJson())),
    "reactions": reactions == null ? [] : List<dynamic>.from(reactions!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "interestedIn": interestedIn,
    "lookingFor": lookingFor,
    "race": race,
    "phoneNumber": phoneNumber,
    "age": age,
    "formattedDistance": formattedDistance,
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

class React {
  final String? user;
  final String? reaction;
  final DateTime? createdAt;

  React({
    this.user,
    this.reaction,
    this.createdAt,
  });

  factory React.fromJson(Map<String, dynamic> json) => React(
    user: json["user"],
    reaction: json["reaction"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "reaction": reaction,
    "createdAt": createdAt?.toIso8601String(),
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
