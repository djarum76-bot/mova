import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();

var options = BaseOptions(
  baseUrl: Constant.baseUrl,
  connectTimeout: 5000,
  receiveTimeout: 3000
);

Dio dio = Dio(options);

class Constant{
  Constant._();

  static const baseUrl = "http://192.168.100.51:8080";

  static const skipIntro = "skipIntro";

  static const usersCollection = 'users';

  static const interest = "interest";
  static const username = "username";
  static const phone = "phone";
  static const image = "image";
  static const password = "password";

  static const token = "token";

  static const Accept = "Accept";
  static const app_json = "application/json";
  static const Authorization = "Authorization";

  static const movie = "movie";
  static const series = "series";
}