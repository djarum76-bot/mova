import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mova/app/modules/search/views/search_body.dart';
import 'package:mova/app/modules/search/views/search_head.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(Get.height * 0.02, Get.height * 0.02, Get.height * 0.02, 0),
            child: Column(
              children: [
                SearchHead(),
                SizedBox(height: Get.height * 0.02,),
                SearchBody(),
              ],
            ),
          )
      ),
    );
  }
}