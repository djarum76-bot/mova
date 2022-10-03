import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:mova/app/utils/constant.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _introduction()
      ),
    );
  }

  Widget _introduction(){
    return Container(
      height: Get.height,
      width: Get.height,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("asset/image/intro.png"))
      ),
      child: Stack(
        children: [
          _introductionImage(),
          _introductionGreeting()
        ],
      ),
    );
  }

  Widget _introductionImage(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: Get.width,
        height: Get.height * 0.6,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black
                ]
            )
        ),
      ),
    );
  }

  Widget _introductionGreeting(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.height * 0.03),
        width: Get.width,
        height: Get.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "Welcome to Mova",
              style: GoogleFonts.urbanist(fontSize: 40, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
            AutoSizeText(
              "The best movie streaming app of the century to make your days great!",
              style: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            _introductionButton()
          ],
        ),
      ),
    );
  }

  Widget _introductionButton(){
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.06,
      child: AppButton(
        onPressed: (){
          box.write(Constant.skipIntro, true);
          Get.offAllNamed(Routes.CUSTOM_AUTH);
        },
        child: AutoSizeText(
          "Get Started",
          style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
          maxLines: 1,
        ),
      ),
    );
  }
}