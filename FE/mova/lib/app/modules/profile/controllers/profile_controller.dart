import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mova/app/controllers/auth_controller.dart';
import 'package:mova/app/controllers/model_controller.dart';
import 'package:mova/app/models/user_model.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/utils/is_connect.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:mova/app/widget/error_message.dart';

class ProfileController extends GetxController {
  // final imageFile = File("").obs;
  // final ambil = false.obs;
  // final ext = "".obs;

  final loading = false.obs;

  final authC = Get.find<AuthController>();
  final modelC = Get.find<ModelController>();

  final username = "".obs;
  final email = "".obs;
  final imageUrl = "".obs;

  // ambilGambar()async{
  //   XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
  //
  //   if(image != null){
  //     ambil.value = true;
  //     imageFile.value = File(image.path);
  //     ext.value = image.name.split('.').last;
  //   }
  // }

  Future<void> logout(BuildContext context)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      Get.back();
      loading.value = true;
      await authC.logout(context);
      loading.value = false;
    }else{
      ErrorMessage(context, "No Internet Connection");
    }
  }

  Future<void> getUser(BuildContext context)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      try{
        final response = await dio.get("/auth/user",
          options: Dio.Options(
            headers: {
              "Accept" : "application/json",
              "Authorization" : "bearer ${box.read(Constant.token)}"
            }
          )
        );

        final data = response.data;

        if(response.statusCode == 200){
          modelC.user(UserModel.fromJson(data));
          modelC.refresh();

          username.value = modelC.user.value.data!.username!;
          username.refresh();

          email.value = modelC.user.value.data!.email!;
          email.refresh();

          if(modelC.user.value.data!.picture!.valid!){
            imageUrl.value = modelC.user.value.data!.picture!.string!;
          }else{
            imageUrl.value = "";
          }
          imageUrl.refresh();
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
}
