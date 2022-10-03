import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mova/app/controllers/auth_controller.dart';
import 'package:mova/app/utils/is_connect.dart';

class LoginController extends GetxController {
  final secure = true.obs;
  final remember = false.obs;

  final google = false.obs;
  final facebook = false.obs;
  final apple = false.obs;

  late TextEditingController email;
  late TextEditingController password;

  final key = GlobalKey<FormState>();
  final loading = false.obs;

  final authC = Get.find<AuthController>();

  Future<void> passwordLoginToFirebase(BuildContext context)async{
    final form = key.currentState;
    if(form!.validate()){
      form.save();
      final isConnect = await CheckUserConnection();
      if(isConnect){
        loading.value = true;
        await authC.passwordLoginToFirebase(context, email.text, password.text);
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

  Future<void> googleLogin(BuildContext context)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      google.value = true;
      await authC.googleLoginToFirebase(context);
      google.value = false;
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

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }
}
