import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:mova/app/widget/error_message.dart';
import 'package:mova/app/widget/social_button.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _login(context)
      ),
    );
  }

  Widget _login(BuildContext context){
    return Container(
      width: Get.width,
      height: Get.height,
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.04, horizontal: Get.height * 0.02),
      child: ListView(
        children: [
          _loginLottie(),
          SizedBox(height: Get.height * 0.03,),
          AutoSizeText(
            "Login to Your Account",
            style: GoogleFonts.urbanist(fontSize: 30, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
          SizedBox(height: Get.height * 0.02,),
          _loginForm(),
          SizedBox(height: Get.height * 0.02,),
          _rememberMe(),
          SizedBox(height: Get.height * 0.02,),
          _signInOrLoading(context),
          _forgotPassword(),
          _or(),
          SizedBox(height: Get.height * 0.02,),
          _socialButton(context),
          SizedBox(height: Get.height * 0.0375,),
          _goToSignUp()
        ],
      ),
    );
  }

  Widget _loginLottie(){
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: Get.height * 0.25,
        height: Get.height * 0.25,
        child: Lottie.asset(
            "asset/lottie/splash.json", fit: BoxFit.cover),
      ),
    );
  }

  Widget _loginForm(){
    return Form(
      key: controller.key,
      child: Column(
        children: [
          _loginEmailForm(),
          SizedBox(height: Get.height * 0.015,),
          _loginPasswordForm()
        ],
      ),
    );
  }

  Widget _loginEmailForm(){
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFF1f222a),
        hintText: "Email",
        hintStyle: GoogleFonts.urbanist(color: Color(0xFF9d9d9d)),
        prefixIcon: Icon(
          Icons.email,
          color: Color(0xFF9d9d9d),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusColor: Color(0xFFE21221),
      ),
      controller: controller.email,
      keyboardAppearance: Brightness.dark,
      validator: ValidationBuilder().email("Not valid email").build(),
    );
  }

  Widget _loginPasswordForm(){
    return Obx((){
      return TextFormField(
        obscureText: controller.secure.value,
        decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFF1f222a),
            hintText: "Password",
            hintStyle: GoogleFonts.urbanist(color: Color(0xFF9d9d9d)),
            prefixIcon: Icon(
              LineIcons.lock,
              color: Color(0xFF9d9d9d),
            ),
            suffixIcon: IconButton(
                onPressed: () {
                  controller.secure.toggle();
                },
                icon: Icon(controller.secure.value ? Icons.visibility_off : Icons.visibility, color: Color(0xFF9d9d9d),)
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            focusColor: Color(0xFFE21221)
        ),
        controller: controller.password,
        keyboardAppearance: Brightness.dark,
        validator: ValidationBuilder().build(),
      );
    });
  }

  Widget _rememberMe(){
    return Row(
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
                    border: Border.all(color: Color(0xFFE21221), width: 4),
                    borderRadius: BorderRadius.circular(8),
                    color: controller.remember.value ? Color(0xFFE21221) : Colors.black
                ),
                child: controller.remember.value
                    ? _rememberMeCheck()
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
    );
  }

  Widget _rememberMeCheck(){
    return Center(
      child: SvgPicture.asset(
        "asset/svg/checkmark.svg",
        color: Colors.white,
        height: Get.height,
        width: Get.height,
      ),
    );
  }

  Widget _signInOrLoading(BuildContext context){
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.06,
      child: Obx((){
        return controller.loading.value
            ? _loadingSignIn()
            : _signInButton(context);
      }),
    );
  }

  Widget _loadingSignIn(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _signInButton(BuildContext context){
    return AppButton(
        onPressed: () {
          controller.passwordLoginToFirebase(context);
        },
        child: AutoSizeText(
          "Sign in",
          style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
          maxLines: 1,
        )
    );
  }

  Widget _forgotPassword(){
    return TextButton(
        onPressed: (){
          Get.toNamed(Routes.FORGET_PASSWORD_1);
        },
        child: AutoSizeText(
          "Forgot the password?",
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 14),
          maxLines: 1,
        )
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
          "or continue with",
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        Divider(
          color: Color(0xFF32353c),
          thickness: 1,
        ),
      ],
    );
  }

  Widget _socialButton(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx((){
          return controller.facebook.value
              ? _loadingSocialButton()
              : _facebookButton(context);
        }),
        Obx((){
          return controller.google.value
              ? _loadingSocialButton()
              : _googleButton(context);
        }),
        Obx((){
          return controller.facebook.value
              ? _loadingSocialButton()
              : _appleButton(context);
        }),
      ],
    );
  }

  Widget _loadingSocialButton(){
    return Container(
      width: Get.height * 0.1,
      height: Get.height * 0.08,
      margin: EdgeInsets.symmetric(horizontal: Get.height * 0.01),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _facebookButton(BuildContext context){
    return SocialButton(
      icon: LineIcons.facebookF,
      onPressed: (){
        ErrorMessage(context, "Not Available Yet");
      },
    );
  }

  Widget _googleButton(BuildContext context){
    return SocialButton(
      icon: LineIcons.googlePlusG,
      onPressed: (){
        controller.googleLogin(context);
      },
    );
  }

  Widget _appleButton(BuildContext context){
    return SocialButton(
      icon: LineIcons.apple,
      onPressed: (){
        ErrorMessage(context, "Not Available Yet");
      },
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
        InkWell(
          onTap: (){
            Get.offAllNamed(Routes.REGISTER);
          },
          borderRadius: BorderRadius.circular(10),
          child: AutoSizeText(
            "Sign up",
            style: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFFE21221)),
            maxLines: 1,
          ),
        )
      ],
    );
  }
}
