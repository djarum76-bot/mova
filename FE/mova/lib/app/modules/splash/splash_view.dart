import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class SplashView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black
      ),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.height * 0.3,
              height: Get.height * 0.3,
              child: Lottie.asset("asset/lottie/splash.json"),
            ),
            WidgetCircularAnimator(
                size: Get.height * 0.1,
                innerColor: Color(0xFFE21221),
                outerColor: Color(0xFFE21221),
                child: SizedBox()
            )
          ],
        ),
      ),
    );
  }
}