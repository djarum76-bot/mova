// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

FavoriteModel favoriteModelFromJson(String str) => FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  FavoriteModel({
    this.status,
    this.pesan,
    this.data,
  });

  int? status;
  String? pesan;
  List<Datum>? data;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
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
    this.userId,
    this.thumbnail,
    this.title,
    this.rating,
    this.category,
    this.createdAt,
    this.tipe,
    this.userUid,
  });

  int? id;
  int? filmId;
  int? userId;
  String? thumbnail;
  String? title;
  double? rating;
  String? category;
  DateTime? createdAt;
  String? tipe;
  String? userUid;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    filmId: json["film_id"],
    userId: json["user_id"],
    thumbnail: json["thumbnail"],
    title: json["title"],
    rating: json["rating"].toDouble(),
    category: json["category"],
    createdAt: DateTime.parse(json["createdAt"]),
    tipe: json["tipe"],
    userUid: json["user_uid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "film_id": filmId,
    "user_id": userId,
    "thumbnail": thumbnail,
    "title": title,
    "rating": rating,
    "category": category,
    "createdAt": createdAt!.toIso8601String(),
    "tipe": tipe,
    "user_uid": userUid,
  };
}
