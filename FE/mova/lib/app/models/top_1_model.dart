// To parse this JSON data, do
//
//     final top1Model = top1ModelFromJson(jsonString);

import 'dart:convert';

Top1Model top1ModelFromJson(String str) => Top1Model.fromJson(json.decode(str));

String top1ModelToJson(Top1Model data) => json.encode(data.toJson());

class Top1Model {
  Top1Model({
    this.status,
    this.pesan,
    this.data,
  });

  int? status;
  String? pesan;
  Data? data;

  factory Top1Model.fromJson(Map<String, dynamic> json) => Top1Model(
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
    this.thumbnail,
    this.title,
    this.rating,
    this.category,
    this.genre,
    this.release,
    this.region,
    this.createdAt,
    this.tipe,
    this.url,
    this.userFavorites,
  });

  int? id;
  String? thumbnail;
  String? title;
  double? rating;
  String? category;
  List<String>? genre;
  String? release;
  String? region;
  DateTime? createdAt;
  String? tipe;
  String? url;
  List<UserFavorite>? userFavorites;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    thumbnail: json["thumbnail"],
    title: json["title"],
    rating: json["rating"].toDouble(),
    category: json["category"],
    genre: List<String>.from(json["genre"].map((x) => x)),
    release: json["release"],
    region: json["region"],
    createdAt: DateTime.parse(json["createdAt"]),
    tipe: json["tipe"],
    url: json["url"],
    userFavorites: List<UserFavorite>.from(json["user_favorites"].map((x) => UserFavorite.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "thumbnail": thumbnail,
    "title": title,
    "rating": rating,
    "category": category,
    "genre": List<dynamic>.from(genre!.map((x) => x)),
    "release": release,
    "region": region,
    "createdAt": createdAt!.toIso8601String(),
    "tipe": tipe,
    "url": url,
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
