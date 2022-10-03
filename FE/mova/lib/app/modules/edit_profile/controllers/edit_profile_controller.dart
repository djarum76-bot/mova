import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mova/app/controllers/model_controller.dart';
import 'package:mova/app/models/user_model.dart';
import 'package:mova/app/modules/profile/controllers/profile_controller.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/utils/is_connect.dart';
import 'package:mova/app/widget/app_button.dart';

class EditProfileController extends GetxController {
  final imageFile = File("").obs;
  final imagePath = "".obs;
  final ambil = false.obs;
  final ext = "".obs;
  final loading = false.obs;

  final usernameTEMP = "".obs;

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phone;

  final modelC = Get.find<ModelController>();
  final profileC = Get.find<ProfileController>();

  final imageUrl = "".obs;

  ambilGambar()async{
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

    if(image != null){
      ambil.value = true;
      imageFile.value = File(image.path);
      imagePath.value = image.path;
      ext.value = image.name.split('.').last;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    username = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    username.dispose();
    email.dispose();
    phone.dispose();
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

          username.text = modelC.user.value.data!.username!;
          email.text = modelC.user.value.data!.email!;
          phone.text = modelC.user.value.data!.phone!;

          imageUrl.value = modelC.user.value.data!.picture!.string!;
          imageUrl.refresh();

          usernameTEMP.value = modelC.user.value.data!.username!;
          usernameTEMP.refresh();
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

  Future<void> EditProfileWithPicture(BuildContext context, String username, String imagePath)async{
    try{
      Dio.FormData formData = Dio.FormData.fromMap({
        "username" : username,
        "picture" : await Dio.MultipartFile.fromFile(imagePath, filename: imagePath.split('/').last),
      });

      final response = await dio.put("/auth/editprofilewithpicture",
          data: formData,
          options: Dio.Options(
              headers: {
                "Accept" : "application/json",
                "Authorization" : "bearer ${box.read(Constant.token)}"
              }
          )
      );

      if(response.statusCode == 200){
        await profileC.getUser(context);
        Get.back();
        Get.back();
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
  }

  Future<void> EditProfileWithoutPicture(BuildContext context, String username)async{
    try{
      Dio.FormData formData = Dio.FormData.fromMap({
        "username" : username,
      });

      final response = await dio.put("/auth/editprofilewithoutpicture",
          data: formData,
          options: Dio.Options(
              headers: {
                "Accept" : "application/json",
                "Authorization" : "bearer ${box.read(Constant.token)}"
              }
          )
      );

      if(response.statusCode == 200){
        await profileC.getUser(context);
        Get.back();
        Get.back();
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
  }

  Future<void> Update(BuildContext context)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      Get.back();
      loading.value = true;
      if(imagePath.value == ""){
        await EditProfileWithoutPicture(context, username.text);
      }else{
        await EditProfileWithPicture(context, username.text, imagePath.value);
      }
      loading.value = false;
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
