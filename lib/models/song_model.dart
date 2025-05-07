class SongModel {
  final String? createdBy;
  final String? name;
  final String? subTitle;
  final String? image;
  final String? music;
  final DateTime? createdAt;
  final String? id;

  SongModel({
    this.createdBy,
    this.name,
    this.subTitle,
    this.image,
    this.music,
    this.createdAt,
    this.id,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
    createdBy: json["createdBy"],
    name: json["name"],
    subTitle: json["subTitle"],
    image: json["image"],
    music: json["music"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "name": name,
    "subTitle": subTitle,
    "image": image,
    "music": music,
    "createdAt": createdAt?.toIso8601String(),
    "id": id,
  };
}
