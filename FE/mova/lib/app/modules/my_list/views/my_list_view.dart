import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/widget/movies_item.dart';
import 'package:mova/app/widget/search_button.dart';

import '../controllers/my_list_controller.dart';

class MyListView extends GetView<MyListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx((){
            return controller.selectedCategory.value == controller.categoryList[0]
                ? _allCategory(context)
                : _otherCategory(context);
          })
      ),
    );
  }

  _buildCategoriesChip() {
    List<Widget> choices = [];

    controller.categoryList.forEach((item) {
      choices.add(
          Obx(() {
            return Container(
              margin: EdgeInsets.only(left: Get.height * 0.01),
              child: ChoiceChip(
                label: AutoSizeText(item, maxLines: 1,),
                labelStyle: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700, color: controller.selectedCategory.value == item ? Colors.white : Color(0xFFE21221)),
                selected: controller.selectedCategory.value == item,
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.017913602941176475),
                labelPadding: EdgeInsets.symmetric(vertical: Get.height * 0.000527573529411765),
                selectedColor: Color(0xFFE21221),
                backgroundColor: Colors.black,
                side: BorderSide(color: Color(0xFFE21221)),
                onSelected: (selected) {
                  controller.selectedCategory.value = item;
                },
              ),
            );
          })
      );
    });

    return choices;
  }

  Widget _allCategory(BuildContext context){
    return FutureBuilder(
      future: controller.getAllFavorites(context),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return Obx((){
            return controller.total.value == 0
                ? _emptyList()
                : _notEmptyList();
          });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _otherCategory(BuildContext context){
    return FutureBuilder(
      future: controller.getAllFavoritesFilter(context, controller.selectedCategory.value),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return Obx((){
            return controller.total.value == 0
                ? _emptyListFilter()
                : _notEmptyList();
          });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _emptyList(){
    return Column(
      children: [
        Container(
          width: Get.width,
          height: Get.height * 0.09,
          padding: EdgeInsets.all(Get.height * 0.02),
          child: Row(
            children: [
              Lottie.asset("asset/lottie/splash.json"),
              SizedBox(width: Get.height * 0.01,),
              AutoSizeText(
                "My List",
                style: GoogleFonts.urbanist(
                    fontSize: 22, fontWeight: FontWeight.w700),
                maxLines: 1,
              )
            ],
          ),
        ),
        Container(),
        SizedBox(),
        Expanded(
            child: Container(
              padding: EdgeInsets.all(Get.height * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset("asset/lottie/empty.json"),
                  AutoSizeText(
                    "Your List is Empty",
                    style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFce1221)),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  AutoSizeText(
                    "It seems that you haven't added any movies to the list",
                    style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )
        )
      ],
    );
  }

  Widget _notEmptyList(){
    return Column(
      children: [
        Container(
          width: Get.width,
          height: Get.height * 0.09,
          padding: EdgeInsets.all(Get.height * 0.02),
          child: Row(
            children: [
              Lottie.asset("asset/lottie/splash.json"),
              SizedBox(width: Get.height * 0.01,),
              AutoSizeText(
                "My List",
                style: GoogleFonts.urbanist(
                    fontSize: 22, fontWeight: FontWeight.w700),
                maxLines: 1,
              )
            ],
          ),
        ),
        Container(
          width: Get.width,
          height: Get.height * 0.05,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _buildCategoriesChip(),
          ),
        ),
        SizedBox(height: Get.height * 0.02,),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Get.height * 0.02),
            child: GridView.builder(
                itemCount: controller.total.value,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: Get.height * 0.012637867647058824,
                    mainAxisSpacing: Get.height * 0.012637867647058824
                ),
                itemBuilder: (context, index){
                  var data = controller.modelC.favorites.value.data![index];
                  return MoviesItem(
                    index: index,
                    total: controller.total.value,
                    onPressed: (){
                      if(data.tipe == Constant.movie){
                        Get.toNamed(Routes.MOVIE_DETAIL, arguments: data.filmId);
                      }else{
                        Get.toNamed(Routes.SERIES_DETAIL);
                      }
                    },
                    width: Get.width * 0.5,
                    height: Get.height * 0.4,
                    isList: false,
                    thumbnail: "${Constant.baseUrl}/${data.thumbnail}",
                    rating: "${(data.rating! * 2).toDouble()}",
                  );
                }
            ),
          ),
        )
      ],
    );
  }

  Widget _emptyListFilter(){
    return Column(
      children: [
        Container(
          width: Get.width,
          height: Get.height * 0.09,
          padding: EdgeInsets.all(Get.height * 0.02),
          child: Row(
            children: [
              Lottie.asset("asset/lottie/splash.json"),
              SizedBox(width: Get.height * 0.01,),
              AutoSizeText(
                "My List",
                style: GoogleFonts.urbanist(
                    fontSize: 22, fontWeight: FontWeight.w700),
                maxLines: 1,
              )
            ],
          ),
        ),
        Container(
          width: Get.width,
          height: Get.height * 0.05,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _buildCategoriesChip(),
          ),
        ),
        Expanded(
            child: Container(
              padding: EdgeInsets.all(Get.height * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset("asset/lottie/empty.json"),
                  AutoSizeText(
                    "Your List is Empty",
                    style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFce1221)),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  AutoSizeText(
                    "It seems that you haven't added any movies to the list",
                    style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )
        )
      ],
    );
  }
}
