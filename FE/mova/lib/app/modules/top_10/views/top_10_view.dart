import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/widget/loading.dart';
import 'package:mova/app/widget/movies_item.dart';
import 'package:mova/app/widget/no_data_found.dart';
import 'package:mova/app/widget/search_button.dart';

import '../controllers/top_10_controller.dart';

class Top10View extends GetView<Top10Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _top10(context),
    );
  }

  Widget _top10(BuildContext context){
    return SafeArea(
        child: Container(
          padding: EdgeInsets.all(Get.height * 0.02),
          child: Column(
            children: [
              _top10Header(),
              SizedBox(height: Get.height * 0.02,),
              _top10Body(context),
            ],
          ),
        )
    );
  }

  Widget _top10Header(){
    return Container(
      width: Get.width,
      height: Get.height * 0.04,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
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
                "Top 10 Movies This Week",
                style: GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.w700),
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _top10Body(BuildContext context){
    return Expanded(
      child: FutureBuilder(
        future: controller.getTop10Movie(context),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return controller.total.value == 0
                ? NoDataFound(context)
                : _top10Result();
          }
          return Loading();
        },
      ),
    );
  }

  Widget _top10Result(){
    return GridView.builder(
        itemCount: controller.total.value,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: Get.height * 0.012637867647058824,
            mainAxisSpacing: Get.height * 0.012637867647058824
        ),
        itemBuilder: (context, index){
          var data = controller.modelC.movies.value.data![index];
          return MoviesItem(
            index: index,
            total: controller.total.value,
            onPressed: (){
              Get.toNamed(Routes.MOVIE_DETAIL, arguments: data.id);
            },
            width: Get.width * 0.5,
            height: Get.height * 0.4,
            isList: false,
            thumbnail: "${Constant.baseUrl}/${data.thumbnail}",
            rating: data.rating == 0 ? "-" : "${(data.rating! * 2).toDouble()}",
          );
        }
    );
  }
}
