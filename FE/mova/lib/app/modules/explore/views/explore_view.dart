import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mova/app/modules/explore/views/explore_body.dart';
import 'package:mova/app/modules/explore/views/explore_head.dart';

import '../controllers/explore_controller.dart';

class ExploreView extends GetView<ExploreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(Get.height * 0.02, Get.height * 0.02, Get.height * 0.02, 0),
            child: Column(
              children: [
                ExploreHead(),
                SizedBox(height: Get.height * 0.02,),
                ExploreBody(),
              ],
            ),
          )
      ),
    );
  }
}