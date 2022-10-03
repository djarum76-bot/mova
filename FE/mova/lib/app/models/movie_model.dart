// To parse this JSON data, do
//
//     final movieModel = movieModelFromJson(jsonString);

import 'dart:convert';

MovieModel movieModelFromJson(String str) => MovieModel.fromJson(json.decode(str));

String movieModelToJson(MovieModel data) => json.encode(data.toJson());

class MovieModel {
  MovieModel({
    this.status,
    this.pesan,
    this.data,
  });

  int? status;
  String? pesan;
  Data? data;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
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
  List<UserFavorite>? userFavorites;
  List<UserComment>? userComments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    userFavorites: List<UserFavorite>.from(json["user_favorites"].map((x) => UserFavorite.fromJson(x))),
    userComments: List<UserComment>.from(json["user_comments"].map((x) => UserComment.fromJson(x))),
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
    "user_favorites": List<dynamic>.from(userFavorites!.map((x) => x.toJson())),
    "user_comments": List<dynamic>.from(userComments!.map((x) => x.toJson())),
  };
}

class UserComment {
  UserComment({
    this.id,
    this.filmId,
    this.userId,
    this.userUid,
    this.username,
    this.picture,
    this.comment,
    this.createdAt,
  });

  int? id;
  int? filmId;
  int? userId;
  String? userUid;
  String? username;
  Picture? picture;
  String? comment;
  DateTime? createdAt;

  factory UserComment.fromJson(Map<String, dynamic> json) => UserComment(
    id: json["id"],
    filmId: json["film_id"],
    userId: json["user_id"],
    userUid: json["user_uid"],
    username: json["username"],
    picture: Picture.fromJson(json["picture"]),
    comment: json["comment"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "film_id": filmId,
    "user_id": userId,
    "user_uid": userUid,
    "username": username,
    "picture": picture!.toJson(),
    "comment": comment,
    "createdAt": createdAt!.toIso8601String(),
  };
}

class Picture {
  Picture({
    this.string,
    this.valid,
  });

  String? string;
  bool? valid;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    string: json["String"],
    valid: json["Valid"],
  );

  Map<String, dynamic> toJson() => {
    "String": string,
    "Valid": valid,
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
