import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mova/app/controllers/auth_controller.dart';
import 'package:mova/app/services/auth_service.dart';
import 'package:mova/app/utils/is_connect.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class NewPinController extends GetxController {
  late TextEditingController pinTEC;
  final authC = Get.find<AuthController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pinTEC = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pinTEC.dispose();
  }

  Future<void> addUserData(BuildContext context)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.NO_HEADER,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.height * 0.2,
              height: Get.height * 0.2,
              child: Lottie.asset(
                  "asset/lottie/user.json", fit: BoxFit.cover
              ),
            ),
            AutoSizeText(
              "Congratulations!",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.02,),
            AutoSizeText(
              "Your account is ready to use. You will be redirected to the Home page in a few second",
              style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            SizedBox(height: Get.height * 0.03,),
            WidgetCircularAnimator(
                size: Get.height * 0.08,
                innerColor: Color(0xFFE21221),
                outerColor: Color(0xFFE21221),
                child: SizedBox()
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();

      final uid = authC.auth.currentUser!.uid;
      final username = box.read(Constant.username) as String;
      final email = authC.auth.currentUser!.email;
      final keyName = username.substring(0,1).toUpperCase();
      final interest = box.read(Constant.interest) as List<String>;
      final phone = box.read(Constant.phone) as String;
      final pin = pinTEC.text;
      final imagePath = box.read(Constant.image) as String;

      await AuthService().addUserData(context, uid, username, email!, keyName, interest, phone, pin, imagePath);
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
