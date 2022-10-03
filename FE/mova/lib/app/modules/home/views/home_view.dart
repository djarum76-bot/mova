import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:mova/app/modules/home/views/new_releases.dart';
import 'package:mova/app/modules/home/views/top_1.dart';
import 'package:mova/app/modules/home/views/top_10_movies.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/widget/search_button.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              _bodyHome(),
              _headerHome(),
            ],
          )
      ),
    );
  }

  Widget _headerHome(){
    return Container(
      width: Get.width,
      height: Get.height * 0.1,
      padding: EdgeInsets.all(Get.height * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Get.height * 0.05,
            height: Get.height * 0.05,
            child: Lottie.asset("asset/lottie/splash.json"),
          ),
          Row(
            children: [
              SearchButton(
                onPressed: (){
                  Get.toNamed(Routes.SEARCH);
                },
              ),
              InkWell(
                child: Container(
                  width: Get.height * 0.05,
                  height: Get.height * 0.05,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle
                  ),
                  child: Icon(LineIcons.bell, color: Colors.white, size: Get.height * 0.04,),
                ),
                onTap: (){
                  Get.toNamed(Routes.NOTIFICATION);
                },
                borderRadius: BorderRadius.circular(200),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _bodyHome(){
    return ListView(
      children: [
        Top1(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Get.height * 0.02, vertical: Get.height * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Top10Movies(),
              SizedBox(height: Get.height * 0.04,),
              NewReleases(),
              SizedBox(height: Get.height * 0.05,),
            ],
          ),
        )
      ],
    );
  }
}