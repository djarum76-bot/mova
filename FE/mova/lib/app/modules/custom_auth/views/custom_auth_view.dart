import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:mova/app/widget/auth_button.dart';
import 'package:mova/app/widget/error_message.dart';

import '../controllers/custom_auth_controller.dart';

class CustomAuthView extends GetView<CustomAuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _customAuth(context)
      ),
    );
  }

  Widget _customAuth(BuildContext context){
    return Container(
      height: Get.height,
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.02, horizontal: Get.height * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              _customAuthLottie(),
              SizedBox(height: Get.height * 0.04,),
              AutoSizeText(
                "Let's you in",
                style: GoogleFonts.urbanist(fontSize: 40, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
              _socialAuth(context),
              SizedBox(height: Get.height * 0.04,),
              _or(),
              SizedBox(height: Get.height * 0.04,),
              _goToLogin(),
            ],
          ),
          _goToSignUp()
        ],
      ),
    );
  }

  Widget _customAuthLottie(){
    return Container(
      width: Get.height * 0.3,
      height: Get.height * 0.3,
      child: Lottie.asset("asset/lottie/signin.json", fit: BoxFit.cover),
    );
  }

  Widget _socialAuth(BuildContext context){
    return Column(
      children: [
        Obx((){
          return controller.facebook.value
              ? _loading()
              : _facebookButton(context);
        }),
        SizedBox(height: Get.height * 0.015,),
        Obx((){
          return controller.google.value
              ? _loading()
              : _googleButton(context);
        }),
        SizedBox(height: Get.height * 0.015,),
        Obx((){
          return controller.apple.value
              ? _loading()
              : _appleButton(context);
        }),
      ],
    );
  }

  Widget _loading(){
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.065,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _facebookButton(BuildContext context){
    return AuthButton(
      onPressed: (){
        ErrorMessage(context, "Not Available Yet");
      },
      icon: LineIcons.facebookF,
      label: "Continue with Facebook",
    );
  }

  Widget _googleButton(BuildContext context){
    return AuthButton(
      onPressed: (){
        controller.googleLogin(context);
      },
      icon: LineIcons.googlePlus,
      label: "Continue with Google",
    );
  }

  Widget _appleButton(BuildContext context){
    return AuthButton(
      onPressed: (){
        ErrorMessage(context, "Not Available Yet");
      },
      icon: LineIcons.apple,
      label: "Continue with Apple",
    );
  }

  Widget _or(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Divider(
          color: Color(0xFF32353c),
          thickness: 1,
        ),
        Text(
          "or",
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        Divider(
          color: Color(0xFF32353c),
          thickness: 1,
        ),
      ],
    );
  }

  Widget _goToLogin(){
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.06,
      child: AppButton(
          onPressed: (){
            Get.offAllNamed(Routes.LOGIN);
          },
          child: AutoSizeText(
            "Sign in with password",
            style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
            maxLines: 1,
          )
      ),
    );
  }

  Widget _goToSignUp(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          "Don't have an account?",
          style: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.w500),
          maxLines: 1,
        ),
        TextButton(
            onPressed: (){
              Get.offAllNamed(Routes.REGISTER);
            },
            child: AutoSizeText(
              "Sign up",
              style: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFFE21221)),
              maxLines: 1,
            )
        )
      ],
    );
  }
}
