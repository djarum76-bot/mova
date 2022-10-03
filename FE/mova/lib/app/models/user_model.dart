// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.status,
    this.pesan,
    this.data,
  });

  int? status;
  String? pesan;
  Data? data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
    this.uid,
    this.username,
    this.email,
    this.phone,
    this.keyName,
    this.picture,
    this.createdAt,
    this.pin,
    this.interest,
  });

  int? id;
  String? uid;
  String? username;
  String? email;
  String? phone;
  String? keyName;
  Picture? picture;
  DateTime? createdAt;
  String? pin;
  List<String>? interest;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    uid: json["uid"],
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    keyName: json["keyName"],
    picture: Picture.fromJson(json["picture"]),
    createdAt: DateTime.parse(json["createdAt"]),
    pin: json["pin"],
    interest: List<String>.from(json["interest"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "username": username,
    "email": email,
    "phone": phone,
    "keyName": keyName,
    "picture": picture!.toJson(),
    "createdAt": createdAt!.toIso8601String(),
    "pin": pin,
    "interest": List<dynamic>.from(interest!.map((x) => x)),
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
