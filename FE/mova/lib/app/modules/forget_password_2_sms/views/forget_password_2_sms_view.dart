import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/widget/app_button.dart';

import '../controllers/forget_password_2_sms_controller.dart';

class ForgetPassword2SmsView extends GetView<ForgetPassword2SmsController> {
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
                          "Input your phone number so we can send code",
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
                            hintText: "Phone Number",
                            hintStyle: GoogleFonts.urbanist(color: Color(0xFF9d9d9d)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusColor: Color(0xFFE21221),
                          ),
                          controller: controller.phone,
                          keyboardAppearance: Brightness.dark,
                          keyboardType: TextInputType.phone,
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
                          Get.toNamed(Routes.FORGET_PASSWORD_3_SMS, arguments: controller.phone.text);
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
