// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  CommentModel({
    this.status,
    this.pesan,
    this.data,
  });

  int? status;
  String? pesan;
  List<Datum>? data;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
