import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/forget_password_3_sms_controller.dart';

class ForgetPassword3SmsView extends GetView<ForgetPassword3SmsController> {
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
                        "Forgot Password",
                        style: GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.w700),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.15,),
                Expanded(
                    child: ListView(
                      children: [
                        AutoSizeText(
                          "Code has been send to ${Get.arguments}",
                          style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                          maxLines: 3,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Get.height * 0.04,),
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
                          controller: controller.pin,
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
                        ),
                        SizedBox(height: Get.height * 0.1,),
                        Align(
                          alignment: Alignment.center,
                          child: CountdownTimer(
                            endTime: controller.endTime,
                            widgetBuilder: (_, time) {
                              if (time == null) {
                                return TextButton(
                                    onPressed: (){
                                      GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500);
                                    },
                                    child: Text('Resend?')
                                );
                              }
                              return RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "Resend in ",
                                            style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500)
                                        ),
                                        TextSpan(
                                            text: time.sec.toString(),
                                            style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFFa21420))
                                        ),
                                        TextSpan(
                                            text: " s",
                                            style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500)
                                        )
                                      ]
                                  )
                              );
                            },
                          ),
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
                          // AwesomeDialog(
                          //   context: context,
                          //   animType: AnimType.SCALE,
                          //   dialogType: DialogType.NO_HEADER,
                          //   dialogBackgroundColor: Color(0xFF1f222a),
                          //   dialogBorderRadius: BorderRadius.circular(16),
                          //   body: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Container(
                          //         width: Get.height * 0.2,
                          //         height: Get.height * 0.2,
                          //         child: Lottie.asset(
                          //             "asset/lottie/user.json", fit: BoxFit.cover
                          //         ),
                          //       ),
                          //       AutoSizeText(
                          //         "Congratulations!",
                          //         style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                          //         maxLines: 1,
                          //       ),
                          //       SizedBox(height: Get.height * 0.02,),
                          //       AutoSizeText(
                          //         "Your account is ready to use. You will be redirected to the Home page in a few second",
                          //         style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                          //         textAlign: TextAlign.center,
                          //         maxLines: 3,
                          //       ),
                          //       SizedBox(height: Get.height * 0.03,),
                          //       WidgetCircularAnimator(
                          //           size: Get.height * 0.08,
                          //           innerColor: Color(0xFFE21221),
                          //           outerColor: Color(0xFFE21221),
                          //           child: SizedBox()
                          //       ),
                          //       SizedBox(height: Get.height * 0.03,),
                          //     ],
                          //   ),
                          // )..show();
                          Get.toNamed(Routes.CREATE_NEW_PASSWORD);
                        },
                        child: AutoSizeText(
                          "Verify",
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
