import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mova/app/controllers/model_controller.dart';
import 'package:mova/app/models/favorite_model.dart';
import 'package:mova/app/models/film_model.dart';
import 'package:mova/app/models/movie_model.dart';
import 'package:mova/app/models/movies_model.dart';
import 'package:mova/app/models/top_1_model.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/utils/is_connect.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:mova/app/widget/error_message.dart';

class HomeController extends GetxController {
  final modelC = Get.find<ModelController>();

  final lengthTop10Movie = 0.obs;
  final lengthNewReleases = 0.obs;

  final liked = false.obs;
  final favoriteId = 0.obs;
  final genre = "".obs;

  final loadingFavorite = false.obs;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> getTop1(BuildContext context)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      try{
        liked.value = false;

        final currUser = _firebaseAuth.currentUser;
        final uid = currUser!.uid;

        final response = await dio.get("/auth/top1",
            options: Dio.Options(
                headers: {
                  "Accept" : "application/json",
                  "Authorization" : "bearer ${box.read(Constant.token)}"
                }
            )
        );

        final data = response.data;

        if(response.statusCode == 200){
          modelC.top1(Top1Model.fromJson(data));
          modelC.top1.refresh();

          genre.value = modelC.top1.value.data!.genre!.join(", ");
          genre.refresh();

          for(int i=0;i<modelC.top1.value.data!.userFavorites!.length; i++){
            if(modelC.top1.value.data!.userFavorites![i].userUid == uid){
              liked.value = true;
              favoriteId.value = modelC.top1.value.data!.userFavorites![i].id!;
              break;
            }else{
              liked.value = false;
            }
          }
          liked.refresh();
        }
      }on Dio.DioError catch(e){
        ErrorMessageExit(context, e.message);
      }catch(e){
        ErrorMessageExit(context, e.toString());
      }
    }else{
      ErrorMessage(context, "No Internet Connection");
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
        await getTop1(context);
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
        await getTop1(context);
      }else{
        ErrorMessageExit(context, response.statusMessage!);
      }

      loadingFavorite.value = false;
    }on Dio.DioError catch(e){
      ErrorMessageExit(context, e.toString());
    }
  }

  Future<void> getTop10Movie(BuildContext context)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      try{
        final response = await dio.get("/auth/top10movie",
            options: Dio.Options(
                headers: {
                  "Accept" : "application/json",
                  "Authorization" : "bearer ${box.read(Constant.token)}"
                }
            )
        );

        final data = response.data;

        if(response.statusCode == 200){
          modelC.movies(MoviesModel.fromJson(data));
          modelC.movies.refresh();

          lengthTop10Movie.value = modelC.movies.value.data!.length;
          lengthTop10Movie.refresh();
        }
      }on Dio.DioError catch(e){
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          dialogBackgroundColor: Color(0xFF1f222a),
          dialogBorderRadius: BorderRadius.circular(16),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                "${e.message}",
                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
              SizedBox(
                width: Get.width,
                child: AppButton(
                    onPressed: (){
                      exit(0);
                    },
                    child: AutoSizeText(
                      "Exit App",
                      style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
                      maxLines: 1,
                    )
                ),
              ),
              SizedBox(height: Get.height * 0.03,),
            ],
          ),
        )..show();
      }catch(e){
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          dialogBackgroundColor: Color(0xFF1f222a),
          dialogBorderRadius: BorderRadius.circular(16),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                "${e.toString()}",
                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
              SizedBox(
                width: Get.width,
                child: AppButton(
                    onPressed: (){
                      exit(0);
                    },
                    child: AutoSizeText(
                      "Exit App",
                      style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
                      maxLines: 1,
                    )
                ),
              ),
              SizedBox(height: Get.height * 0.03,),
            ],
          ),
        )..show();
      }
    }else{
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "Not Internet Connection",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }
  }

  Future<void> getNewReleases(BuildContext context)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      try{
        final response = await dio.get("/auth/newreleases",
            options: Dio.Options(
                headers: {
                  "Accept" : "application/json",
                  "Authorization" : "bearer ${box.read(Constant.token)}"
                }
            )
        );

        final data = response.data;

        if(response.statusCode == 200){
          modelC.newReleases(FilmModel.fromJson(data));
          modelC.newReleases.refresh();

          lengthNewReleases.value = modelC.newReleases.value.data!.length;
          lengthNewReleases.refresh();
        }
      }on Dio.DioError catch(e){
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          dialogBackgroundColor: Color(0xFF1f222a),
          dialogBorderRadius: BorderRadius.circular(16),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                "${e.message}",
                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
              SizedBox(
                width: Get.width,
                child: AppButton(
                    onPressed: (){
                      exit(0);
                    },
                    child: AutoSizeText(
                      "Exit App",
                      style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
                      maxLines: 1,
                    )
                ),
              ),
              SizedBox(height: Get.height * 0.03,),
            ],
          ),
        )..show();
      }catch(e){
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          dialogBackgroundColor: Color(0xFF1f222a),
          dialogBorderRadius: BorderRadius.circular(16),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                "${e.toString()}",
                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
              SizedBox(
                width: Get.width,
                child: AppButton(
                    onPressed: (){
                      exit(0);
                    },
                    child: AutoSizeText(
                      "Exit App",
                      style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
                      maxLines: 1,
                    )
                ),
              ),
              SizedBox(height: Get.height * 0.03,),
            ],
          ),
        )..show();
      }
    }else{
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "Not Internet Connection",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }
  }
}
