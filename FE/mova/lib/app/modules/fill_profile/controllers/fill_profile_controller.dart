import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mova/app/controllers/auth_controller.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/services/auth_service.dart';
import 'package:mova/app/utils/constant.dart';

class FillProfileController extends GetxController {
  final imageFile = File("").obs;
  final ambil = false.obs;
  final imagePath = "".obs;
  final ext = "".obs;

  final loading = false.obs;

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phone;

  final key = GlobalKey<FormState>();

  final authC = Get.find<AuthController>();

  check(BuildContext context)async{
    final form = key.currentState;
    if(form!.validate()){
      form.save();
      if(username.text == ""){
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
                "Please fill in the data",
                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
            ],
          ),
        )..show();
      }else if(phone.text == ""){
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
                "Please fill in the data",
                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
            ],
          ),
        )..show();
      }else{
        loading.value = true;
        await AuthService().checkUsernamePhone(context, username.text, phone.text, imagePath.value);
        loading.value = false;
      }
    }
  }

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
    email = TextEditingController(text: authC.auth.currentUser!.email);
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
}
