class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String profileImage;
  final String coverImage;
  final List<String> photos;
  final String role;
  final String country;
  final String state;
  final String city;
  final int kids;
  final String hobbiesAndActivities;
  final String musicAndEntertainment;
  final String sportsAndFitness;
  final String foodAndDrinks;
  final String lifestyleValues;
  final String bio;
  final bool isEmailVerified;
  final bool isResetPassword;
  final int credits;
  final bool isProfileCompleted;
  final String fcmToken;
  final bool isBlocked;
  final int setDistance;
  final bool isSubscriptionTaken;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int liveCredits;
  final String interestedIn;
  final String lookingFor;
  final int loveCredits;
  final int winkcredits;
  final String race;
  final int age;
  final String formattedDistance;
  final Location location;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.profileImage,
    required this.coverImage,
    required this.photos,
    required this.role,
    required this.country,
    required this.state,
    required this.city,
    required this.kids,
    required this.hobbiesAndActivities,
    required this.musicAndEntertainment,
    required this.sportsAndFitness,
    required this.foodAndDrinks,
    required this.lifestyleValues,
    required this.bio,
    required this.isEmailVerified,
    required this.isResetPassword,
    required this.credits,
    required this.isProfileCompleted,
    required this.fcmToken,
    required this.isBlocked,
    required this.setDistance,
    required this.isSubscriptionTaken,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.liveCredits,
    required this.interestedIn,
    required this.lookingFor,
    required this.loveCredits,
    required this.winkcredits,
    required this.race,
    required this.age,
    required this.formattedDistance,
    required this.location,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      email: json['email'],
      profileImage: json['profileImage'],
      coverImage: json['coverImage'],
      photos: List<String>.from(json['photos']),
      role: json['role'],
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      kids: json['kids'] ?? 0,
      hobbiesAndActivities: json['hobbiesAndActivities'] ?? '',
      musicAndEntertainment: json['musicAndEntertainment'] ?? '',
      sportsAndFitness: json['sportsAndFitness'] ?? '',
      foodAndDrinks: json['FoodAndDrinks'] ?? '',
      lifestyleValues: json['lifestyleValues'] ?? '',
      bio: json['bio'] ?? '',
      isEmailVerified: json['isEmailVerified'],
      isResetPassword: json['isResetPassword'],
      credits: json['credits'] ?? 0,
      isProfileCompleted: json['isProfileCompleted'],
      fcmToken: json['fcmToken'],
      isBlocked: json['isBlocked'],
      setDistance: json['setDistance'],
      isSubscriptionTaken: json['isSubscriptionTaken'],
      isDeleted: json['isDeleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      liveCredits: json['LiveCredits'] ?? 0,
      interestedIn: json['interestedIn'],
      lookingFor: json['lookingFor'],
      loveCredits: json['loveCredits'] ?? 0,
      winkcredits: json['winkcredits'] ?? 0,
      race: json['race'] ?? '',
      age: json['age'],
      formattedDistance: json['formattedDistance'] ?? '',
      location: Location.fromJson(json['location']),
    );
  }
}

class Location {
  final String type;
  final List<double> coordinates;
  final String locationName;

  Location({
    required this.type,
    required this.coordinates,
    required this.locationName,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates']),
      locationName: json['locationName'],
    );
  }
}
