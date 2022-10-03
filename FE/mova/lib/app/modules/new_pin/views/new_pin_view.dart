import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import '../controllers/new_pin_controller.dart';

class NewPinView extends GetView<NewPinController> {
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
                        "Create New Pin",
                        style: GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.w700),
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.15,),
                Expanded(
                    child: ListView(
                      children: [
                        AutoSizeText(
                          "Add a PIN number to make your account more secure",
                          style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                          maxLines: 3,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Get.height * 0.2,),
                        PinCodeTextField(
                          length: 4,
                          obscureText: true,
                          pinTheme: PinTheme(
                            selectedColor: Color(0xFFE21221),
                            activeColor: Color(0xFF1f222a),
                            shape: PinCodeFieldShape.box,
                            fieldHeight: Get.height * 0.1,
                            fieldWidth: Get.height * 0.1,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          keyboardType: TextInputType.number,
                          backgroundColor: Color(0xFF181a20),
                          animationDuration: Duration(milliseconds: 300),
                          controller: controller.pinTEC,
                          onCompleted: (v) {
                            print("Completed");
                          },
                          onChanged: (value) {
                            print(value);
                          },
                          beforeTextPaste: (text) {
                            return true;
                          },
                          appContext: context,
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
                          if(controller.pinTEC.text == ""){
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
                            controller.addUserData(context);
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
