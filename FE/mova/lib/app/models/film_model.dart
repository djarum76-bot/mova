// To parse this JSON data, do
//
//     final filmModel = filmModelFromJson(jsonString);

import 'dart:convert';

FilmModel filmModelFromJson(String str) => FilmModel.fromJson(json.decode(str));

String filmModelToJson(FilmModel data) => json.encode(data.toJson());

class FilmModel {
  FilmModel({
    this.status,
    this.pesan,
    this.data,
  });

  int? status;
  String? pesan;
  List<Datum>? data;

  factory FilmModel.fromJson(Map<String, dynamic> json) => FilmModel(
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
  };
}
