import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mova/app/modules/explore/controllers/explore_controller.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/widget/movies_item.dart';
import 'package:mova/app/widget/no_data_found.dart';

class ExploreBody extends GetView<ExploreController> {
  const ExploreBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx((){
          return controller.sortFilterList.value.isEmpty
              ? _exploreResult(context)
              : _exploreFilterResult(context);
        })
    );
  }

  Widget _exploreResult(BuildContext context){
    return FutureBuilder(
      future: controller.getExplore(context),
      builder: (context, snapshot){
        return controller.total.value == 0
            ? NoDataFound(context)
            : GridView.builder(
            itemCount: controller.total.value,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: Get.height * 0.012637867647058824,
                mainAxisSpacing: Get.height * 0.012637867647058824
            ),
            itemBuilder: (context, index){
              var data = controller.modelC.explore.value.data![index];
              return MoviesItem(
                index: index,
                total: controller.total.value,
                onPressed: (){
                  if(data.tipe == Constant.movie){
                    Get.toNamed(Routes.MOVIE_DETAIL, arguments: data.id);
                  }else{
                    Get.toNamed(Routes.SERIES_DETAIL);
                  }
                },
                width: Get.width * 0.5,
                height: Get.height * 0.4,
                isList: false,
                thumbnail: "${Constant.baseUrl}/${data.thumbnail}",
                rating: "${data.rating!.toDouble() * 2}",
              );
            }
        );
      },
    );
  }

  Widget _exploreFilterResult(BuildContext context){
    return FutureBuilder(
      future: controller.getExploreFilter(context, controller.selectedCategory.value, controller.selectedRegion.value, controller.selectedGenre.value, controller.selectedTimePeriod.value),
      builder: (context, snapshot){
        return controller.total.value == 0
            ? NoDataFound(context)
            : GridView.builder(
            itemCount: controller.total.value,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: Get.height * 0.012637867647058824,
                mainAxisSpacing: Get.height * 0.012637867647058824
            ),
            itemBuilder: (context, index){
              var data = controller.modelC.explore.value.data![index];
              return MoviesItem(
                index: index,
                total: controller.total.value,
                onPressed: (){
                  if(data.tipe == Constant.movie){
                    Get.toNamed(Routes.MOVIE_DETAIL, arguments: data.id);
                  }else{
                    Get.toNamed(Routes.SERIES_DETAIL);
                  }
                },
                width: Get.width * 0.5,
                height: Get.height * 0.4,
                isList: false,
                thumbnail: "${Constant.baseUrl}/${data.thumbnail}",
                rating: "${data.rating!.toDouble() * 2}",
              );
            }
        );
      },
    );
  }
}