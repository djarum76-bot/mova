// To parse this JSON data, do
//
//     final moviesModel = moviesModelFromJson(jsonString);

import 'dart:convert';

MoviesModel moviesModelFromJson(String str) => MoviesModel.fromJson(json.decode(str));

String moviesModelToJson(MoviesModel data) => json.encode(data.toJson());

class MoviesModel {
  MoviesModel({
    this.status,
    this.pesan,
    this.data,
  });

  int? status;
  String? pesan;
  List<Datum>? data;

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
    status: json["status"],
    pesan: json["pesan"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "pesan": pesan,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.filmId,
    this.thumbnail,
    this.title,
    this.rating,
    this.category,
    this.genre,
    this.description,
    this.url,
    this.release,
    this.region,
    this.createdAt,
    this.userFavorites,
    this.userComments,
  });

  int? id;
  int? filmId;
  String? thumbnail;
  String? title;
  double? rating;
  String? category;
  List<String>? genre;
  String? description;
  String? url;
  String? release;
  String? region;
  DateTime? createdAt;
  List<dynamic>? userFavorites;
  List<dynamic>? userComments;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    filmId: json["film_id"],
    thumbnail: json["thumbnail"],
    title: json["title"],
    rating: json["rating"].toDouble(),
    category: json["category"],
    genre: List<String>.from(json["genre"].map((x) => x)),
    description: json["description"],
    url: json["url"],
    release: json["release"],
    region: json["region"],
    createdAt: DateTime.parse(json["createdAt"]),
    userFavorites: List<dynamic>.from(json["user_favorites"].map((x) => x)),
    userComments: List<dynamic>.from(json["user_comments"].map((x) => x)),
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
    "url": url,
    "release": release,
    "region": region,
    "createdAt": createdAt!.toIso8601String(),
    "user_favorites": List<dynamic>.from(userFavorites!.map((x) => x)),
    "user_comments": List<dynamic>.from(userComments!.map((x) => x)),
  };
}
