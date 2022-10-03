// To parse this JSON data, do
//
//     final seriesModel = seriesModelFromJson(jsonString);

import 'dart:convert';

SeriesModel seriesModelFromJson(String str) => SeriesModel.fromJson(json.decode(str));

String seriesModelToJson(SeriesModel data) => json.encode(data.toJson());

class SeriesModel {
  SeriesModel({
    this.status,
    this.pesan,
    this.data,
  });

  int? status;
  String? pesan;
  Data? data;

  factory SeriesModel.fromJson(Map<String, dynamic> json) => SeriesModel(
    status: json["status"],
    pesan: json["pesan"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "pesan": pesan,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.filmId,
    this.thumbnail,
    this.title,
    this.rating,
    this.category,
    this.genre,
    this.description,
    this.episode,
    this.release,
    this.region,
    this.createdAt,
    this.userFavorites,
  });

  int? id;
  int? filmId;
  String? thumbnail;
  String? title;
  double? rating;
  String? category;
  List<String>? genre;
  String? description;
  List<String>? episode;
  String? release;
  String? region;
  DateTime? createdAt;
  List<UserFavorite>? userFavorites;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    filmId: json["film_id"],
    thumbnail: json["thumbnail"],
    title: json["title"],
    rating: json["rating"].toDouble(),
    category: json["category"],
    genre: List<String>.from(json["genre"].map((x) => x)),
    description: json["description"],
    episode: List<String>.from(json["episode"].map((x) => x)),
    release: json["release"],
    region: json["region"],
    createdAt: DateTime.parse(json["createdAt"]),
    userFavorites: List<UserFavorite>.from(json["user_favorites"].map((x) => UserFavorite.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "film_id": filmId,
    "thumbnail": thumbnail,
    "title": title,
    "rating": rating,
    "category": category,
    "genre": List<dynamic>.from(genre!.map((x) => x)),
    "description": description,
    "episode": List<dynamic>.from(episode!.map((x) => x)),
    "release": release,
    "region": region,
    "createdAt": createdAt!.toIso8601String(),
    "user_favorites": List<dynamic>.from(userFavorites!.map((x) => x.toJson())),
  };
}

class UserFavorite {
  UserFavorite({
    this.id,
    this.filmId,
    this.userId,
    this.userUid,
  });

  int? id;
  int? filmId;
  int? userId;
  String? userUid;

  factory UserFavorite.fromJson(Map<String, dynamic> json) => UserFavorite(
    id: json["id"],
    filmId: json["film_id"],
    userId: json["user_id"],
    userUid: json["user_uid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "film_id": filmId,
    "user_id": userId,
    "user_uid": userUid,
  };
}
