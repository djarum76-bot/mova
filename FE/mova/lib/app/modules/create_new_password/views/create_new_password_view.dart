import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import '../controllers/create_new_password_controller.dart';

class CreateNewPasswordView extends GetView<CreateNewPasswordController> {
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
                        onTap: (){
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
                        "Create New Password",
                        style: GoogleFonts.urbanist(fontSize: 26, fontWeight: FontWeight.w700),
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
                          "Create Your New Password",
                          style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                          maxLines: 3,
                        ),
                        SizedBox(height: Get.height * 0.04,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(() {
                              return TextFormField(
                                obscureText: controller.pass_sec.value,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFF1f222a),
                                    hintText: "Password",
                                    hintStyle: GoogleFonts.urbanist(
                                        color: Color(0xFF9d9d9d)),
                                    prefixIcon: Icon(
                                      LineIcons.lock,
                                      color: Color(0xFF9d9d9d),
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.pass_sec.toggle();
                                        },
                                        icon: Icon(controller.pass_sec.value ? Icons.visibility_off : Icons.visibility,
                                          color: Color(0xFF9d9d9d),)
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    focusColor: Color(0xFFE21221)
                                ),
                                controller: controller.pass,
                                keyboardAppearance: Brightness.dark,
                              );
                            }),
                            SizedBox(height: Get.height * 0.01,),
                            Obx(() {
                              return TextFormField(
                                obscureText: controller.conf_pass_sec.value,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFF1f222a),
                                    hintText: "Confirmation Password",
                                    hintStyle: GoogleFonts.urbanist(
                                        color: Color(0xFF9d9d9d)),
                                    prefixIcon: Icon(
                                      LineIcons.lock,
                                      color: Color(0xFF9d9d9d),
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.conf_pass_sec.toggle();
                                        },
                                        icon: Icon(controller.conf_pass_sec.value ? Icons
                                            .visibility_off : Icons.visibility,
                                          color: Color(0xFF9d9d9d),)
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    focusColor: Color(0xFFE21221)
                                ),
                                controller: controller.conf_pass,
                                keyboardAppearance: Brightness.dark,
                              );
                            }),
                            SizedBox(height: Get.height * 0.04,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.remember.toggle();
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: Obx(() {
                                    return Container(
                                        width: Get.height * 0.03,
                                        height: Get.height * 0.03,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xFFE21221), width: 4
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                            color: controller.remember.value ? Color(0xFFE21221) : Colors.black
                                        ),
                                        child: controller.remember.value
                                            ? Center(
                                          child: SvgPicture.asset(
                                            "asset/svg/checkmark.svg",
                                            color: Colors.white,
                                            height: Get.height,
                                            width: Get.height,
                                          ),
                                        )
                                            : SizedBox()
                                    );
                                  }),
                                ),
                                SizedBox(width: Get.height * 0.01,),
                                AutoSizeText(
                                  "Remember me",
                                  style: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.w700, fontSize: 14),
                                  maxLines: 1,
                                ),
                              ],
                            ),
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
                          if(controller.pass.text != controller.conf_pass.text){
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
                                    "Confirmation Password must be the same",
                                    style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: Get.height * 0.03,),
                                ],
                              ),
                            )..show();
                          }else{
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
                          }
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
