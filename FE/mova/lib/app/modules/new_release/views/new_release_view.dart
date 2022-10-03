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

import '../controllers/new_release_controller.dart';

class NewReleaseView extends GetView<NewReleaseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _newRelease(context),
    );
  }

  Widget _newRelease(BuildContext context){
    return SafeArea(
        child: Container(
          padding: EdgeInsets.all(Get.height * 0.02),
          child: Column(
            children: [
              _newReleaseHeader(),
              SizedBox(height: Get.height * 0.02,),
              _newReleaseBody(context),
            ],
          ),
        )
    );
  }

  Widget _newReleaseHeader(){
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
                "New Releases",
                style: GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.w700),
                maxLines: 1,
              ),
            ],
          ),
          // SearchButton(onPressed: (){},)
        ],
      ),
    );
  }

  Widget _newReleaseBody(BuildContext context){
    return Expanded(
      child: FutureBuilder(
        future: controller.getNewReleases(context),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return controller.total.value == 0
                ? NoDataFound(context)
                : _newReleaseResult();
          }
          return Loading();
        },
      ),
    );
  }

  Widget _newReleaseResult(){
    return GridView.builder(
        itemCount: controller.total.value,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: Get.height * 0.012637867647058824,
            mainAxisSpacing: Get.height * 0.012637867647058824
        ),
        itemBuilder: (context, index){
          var data = controller.modelC.newReleases.value.data![index];
          return MoviesItem(
            total: controller.total.value,
            index: index,
            onPressed: (){
              if(data.tipe == Constant.movie){
                Get.toNamed(Routes.MOVIE_DETAIL, arguments: data.id);
              }else{
                Get.toNamed(Routes.SERIES_DETAIL, arguments: data.id);
              }
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