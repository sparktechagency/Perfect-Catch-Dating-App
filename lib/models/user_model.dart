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
  final String? country;
  final String? state;
  final String? city;
  final int? kids;
  final String? hobbiesAndActivities;
  final String? musicAndEntertainment;
  final String? sportsAndFitness;
  final String? foodAndDrinks;
  final String? lifestyleValues;
  final List<dynamic> lickList;
  final List<dynamic> idealMatch;
  final List<dynamic> language;
  final Location location;
  final String? bio;
  final bool isEmailVerified;
  final bool isResetPassword;
  final int credits;
  final bool isProfileCompleted;
  final String fcmToken;
  final bool isBlocked;
  final int setDistance;
  final bool isSubscriptionTaken;
  final bool isDeleted;
  final int liveCredits;
  final String interestedIn;
  final String lookingFor;
  final int loveCredits;
  final String race;
  final int winkCredits;
  final int? age;
  final String formattedDistance;
  final String dateOfBirth;
  final double weight;
  final String gender;
  final String religion;
  final String educationQualification;
  final double height;

  UserModel({
    required this.id,
    required this.weight,
    required this.gender,
    required this.educationQualification,
    required this.height,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.profileImage,
    required this.coverImage,
    required this.photos,
    required this.role,
    required this.religion,
    this.country,
    this.state,
    this.city,
    this.kids,
    required this.dateOfBirth,
    this.hobbiesAndActivities,
    this.musicAndEntertainment,
    this.sportsAndFitness,
    this.foodAndDrinks,
    this.lifestyleValues,
    required this.lickList,
    required this.idealMatch,
    required this.language,
    required this.location,
    this.bio,
    required this.isEmailVerified,
    required this.isResetPassword,
    required this.credits,
    required this.isProfileCompleted,
    required this.fcmToken,
    required this.isBlocked,
    required this.setDistance,
    required this.isSubscriptionTaken,
    required this.isDeleted,
    required this.liveCredits,
    required this.interestedIn,
    required this.lookingFor,
    required this.loveCredits,
    required this.race,
    required this.winkCredits,
    this.age,
    required this.formattedDistance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? json['id'],
      firstName: json['firstName'],
      dateOfBirth: json['dateOfBirth'] ?? '',
      lastName: json['lastName'] ?? "",
      fullName: json['fullName'],
      email: json['email'],
      profileImage: json['profileImage'],
      coverImage: json['coverImage'],
      photos: List<String>.from(json['photos'] ?? []),
      role: json['role'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      kids: json['kids'],
      hobbiesAndActivities: json['hobbiesAndActivities'],
      musicAndEntertainment: json['musicAndEntertainment'],
      sportsAndFitness: json['sportsAndFitness'],
      foodAndDrinks: json['FoodAndDrinks'],
      lifestyleValues: json['lifestyleValues'],
      lickList: json['lickList'] ?? [],
      idealMatch: json['idealMatch'] ?? [],
      language: json['language'] ?? [],
      location: Location.fromJson(json['location']),
      bio: json['bio'],
      isEmailVerified: json['isEmailVerified'] ?? false,
      isResetPassword: json['isResetPassword'] ?? false,
      credits: json['credits'],
      isProfileCompleted: json['isProfileCompleted'],
      fcmToken: json['fcmToken'] ?? '',
      isBlocked: json['isBlocked'] ?? false,
      setDistance: json['setDistance'],
      isSubscriptionTaken: json['isSubscriptionTaken'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      liveCredits: json['LiveCredits'] ?? 0,
      interestedIn: json['interestedIn'] ?? '',
      lookingFor: json['lookingFor'] ?? '',
      loveCredits: json['loveCredits'] ?? 0,
      race: json['race'] ?? '',
      winkCredits: json['winkcredits'] ?? 0,
      age: json['age'],
      formattedDistance: json['formattedDistance'] ?? "",
      weight: json['weight'] ?? 0.0,
      gender: json['gender'] ?? "",
      religion: json['religion'] ?? "",
      educationQualification: json['educationQualification'] ?? "",
      height: json['height'] ?? 0.0,
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