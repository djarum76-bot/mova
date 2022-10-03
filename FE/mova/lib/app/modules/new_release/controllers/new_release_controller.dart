import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mova/app/controllers/model_controller.dart';
import 'package:mova/app/models/film_model.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/utils/is_connect.dart';
import 'package:mova/app/widget/app_button.dart';

class NewReleaseController extends GetxController {
  final modelC = Get.find<ModelController>();

  final total = 0.obs;

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

          total.value = modelC.newReleases.value.data!.length;
          total.refresh();
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
