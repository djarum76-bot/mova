import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mova/app/controllers/model_controller.dart';
import 'package:mova/app/models/movie_model.dart';
import 'package:mova/app/modules/home/controllers/home_controller.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/utils/is_connect.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:mova/app/widget/error_message.dart';

class MovieDetailController extends GetxController {
  final modelC = Get.find<ModelController>();
  final homeC = Get.find<HomeController>();

  final genre = "".obs;
  final isFavorite = false.obs;

  final loadingFavorite = false.obs;
  final favoriteId = 0.obs;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final totalComment = 0.obs;

  Future<void> getMovieDetail(BuildContext context, int film_id)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      try{
        isFavorite.value = false;

        final currUser = _firebaseAuth.currentUser;
        final uid = currUser!.uid;

        final response = await dio.get("/auth/movie/${film_id}",
            options: Dio.Options(
                headers: {
                  "Accept" : "application/json",
                  "Authorization" : "bearer ${box.read(Constant.token)}"
                }
            )
        );

        final data = response.data;

        if(response.statusCode == 200){
          modelC.movie(MovieModel.fromJson(data));
          modelC.refresh();

          genre.value = modelC.movie.value.data!.genre!.join(", ");
          genre.refresh();

          for(int i=0;i<modelC.movie.value.data!.userFavorites!.length; i++){
            if(modelC.movie.value.data!.userFavorites![i].userUid == uid){
              isFavorite.value = true;
              favoriteId.value = modelC.movie.value.data!.userFavorites![i].id!;
              break;
            }else{
              isFavorite.value = false;
            }
          }
          isFavorite.refresh();

          totalComment.value = modelC.movie.value.data!.userComments!.length;
        }
      }on Dio.DioError catch(e){
        ErrorMessageExit(context, e.message);
      }catch(e){
        ErrorMessageExit(context, e.toString());
      }
    }else{
      ErrorMessage(context, "No Internet");
    }
  }

  Future<void> addFavorite(BuildContext context, int filmId, String thumbnail, String title, double rating, String category, String tipe)async{
    try{
      loadingFavorite.value = true;

      final currUser = _firebaseAuth.currentUser;
      final uid = currUser!.uid;

      Dio.FormData formData = Dio.FormData.fromMap({
        "film_id" : filmId,
        "thumbnail" : thumbnail,
        "title" : title,
        "rating" : rating,
        "category" : category,
        "createdAt" : DateTime.now().toIso8601String(),
        "tipe" : tipe,
        "user_uid" : uid
      });

      final response = await dio.post('/auth/favorite',
          data: formData,
          options: Dio.Options(
              headers: {
                "Accept" : "application/json",
                "Authorization" : "bearer ${box.read(Constant.token)}"
              }
          )
      );

      if(response.statusCode == 200){
        await getMovieDetail(context, Get.arguments);
        await homeC.getTop1(context);
      }else{
        ErrorMessageExit(context, response.statusMessage!);
      }

      loadingFavorite.value = false;
    }on Dio.DioError catch(e){
      ErrorMessageExit(context, e.toString());
    }
  }

  Future<void> deleteFavorite(BuildContext context, int favoriteId)async{
    try{
      loadingFavorite.value = true;

      final response = await dio.delete('/auth/favorite/$favoriteId',
          options: Dio.Options(
              headers: {
                "Accept" : "application/json",
                "Authorization" : "bearer ${box.read(Constant.token)}"
              }
          )
      );

      if(response.statusCode == 200){
        await getMovieDetail(context, Get.arguments);
        await homeC.getTop1(context);
      }else{
        ErrorMessageExit(context, response.statusMessage!);
      }

      loadingFavorite.value = false;
    }on Dio.DioError catch(e){
      ErrorMessageExit(context, e.toString());
    }
  }
}
