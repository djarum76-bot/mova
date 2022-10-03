import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/widget/app_button.dart';

import '../controllers/forget_password_1_controller.dart';

class ForgetPassword1View extends GetView<ForgetPassword1Controller> {
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
                          "Select which way should we use to reset your password",
                          style: GoogleFonts.urbanist(fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                          maxLines: 3,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: Get.height * 0.04,),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.via.value = "SMS";
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Obx(() {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: controller.via.value == "SMS" ? Color(0xFFea202f) : Color(0xFF2e3138), width: 3
                                      ),
                                      color: Color(0xFF1f222a)
                                  ),
                                  height: Get.height * 0.13,
                                  padding: EdgeInsets.only(
                                      left: Get.height * 0.025),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: Get.height * 0.1,
                                        height: Get.height * 0.09,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF2f202a)
                                        ),
                                        child: Center(
                                          child: Icon(
                                            LineIcons.sms,
                                            color: Color(0xFFec2432),
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: Get.height * 0.015,),
                                      AutoSizeText(
                                        "via SMS",
                                        style: GoogleFonts.urbanist(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: Get.height * 0.02,),
                            InkWell(
                              onTap: () {
                                controller.via.value = "Email";
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Obx(() {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: controller.via.value == "Email" ? Color(0xFFea202f) : Color(0xFF2e3138), width: 3
                                      ),
                                      color: Color(0xFF1f222a)
                                  ),
                                  height: Get.height * 0.13,
                                  padding: EdgeInsets.only(
                                      left: Get.height * 0.025),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: Get.height * 0.1,
                                        height: Get.height * 0.09,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF2f202a)
                                        ),
                                        child: Center(
                                          child: Icon(
                                            LineIcons.envelope,
                                            color: Color(0xFFec2432),
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: Get.height * 0.015,),
                                      AutoSizeText(
                                        "via Email",
                                        style: GoogleFonts.urbanist(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  ),
                                );
                              }),
                            )
                          ],
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
                          if(controller.via.value == "SMS"){
                            Get.toNamed(Routes.FORGET_PASSWORD_2_SMS);
                          }else if(controller.via.value == "Email"){
                            Get.toNamed(Routes.FORGET_PASSWORD_2_EMAIL);
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
                                    "Choose One Method",
                                    style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: Get.height * 0.03,),
                                ],
                              ),
                            )..show();
                          }
                        },
                        child: AutoSizeText(
                          "Continue",
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
