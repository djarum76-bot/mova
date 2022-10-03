import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import '../controllers/forget_password_2_email_controller.dart';

class ForgetPassword2EmailView extends GetView<ForgetPassword2EmailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(Get.height * 0.02),
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * 0.04,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        borderRadius: BorderRadius.circular(100),
                        child: Icon(
                          LineIcons.arrowLeft,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: Get.height * 0.02,),
                      AutoSizeText(
                        "Forgot Password",
                        style: GoogleFonts.urbanist(
                            fontSize: 22, fontWeight: FontWeight.w700),
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.04,),
                Expanded(
                    child: ListView(
                      children: [
                        AutoSizeText(
                          "Input your email so we can send reset your password",
                          style: GoogleFonts.urbanist(fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                          maxLines: 3,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: Get.height * 0.04,),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFF1f222a),
                            hintText: "Email",
                            hintStyle: GoogleFonts.urbanist(color: Color(0xFF9d9d9d)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusColor: Color(0xFFE21221),
                          ),
                          controller: controller.email,
                          keyboardAppearance: Brightness.dark,
                          keyboardType: TextInputType.emailAddress,
                        )
                      ],
                    )
                ),
                SizedBox(height: Get.height * 0.02,),
                Container(
                  width: Get.width,
                  height: Get.height * 0.06,
                  child: SizedBox(
                    height: Get.height * 0.06,
                    child: AppButton(
                        onPressed: () {
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
                                  width: Get.height * 0.3,
                                  height: Get.height * 0.3,
                                  child: Lottie.asset(
                                      "asset/lottie/success.json", fit: BoxFit.cover
                                  ),
                                ),
                                AutoSizeText(
                                  "Congratulations!",
                                  style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                                  maxLines: 1,
                                ),
                                SizedBox(height: Get.height * 0.02,),
                                AutoSizeText(
                                  "We have send link to your email. Go check for it",
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
                          Future.delayed(Duration(seconds: 5)).then((value) => Get.offAllNamed(Routes.LOGIN));
                        },
                        child: AutoSizeText(
                          "Finish",
                          style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
                          maxLines: 1,
                        )
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
