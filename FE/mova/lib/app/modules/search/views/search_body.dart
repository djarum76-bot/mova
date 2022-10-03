import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mova/app/modules/search/controllers/search_controller.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/widget/loading.dart';
import 'package:mova/app/widget/movies_item.dart';
import 'package:mova/app/widget/no_data_found.dart';
import 'package:mova/app/widget/search_item.dart';

class SearchBody extends GetView<SearchController> {
  const SearchBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx((){
          return _searchBody(context, controller.searchKey, controller.sortFilterList);
        })
    );
  }

  Widget _searchBody(BuildContext context, Rx<String> searchKey, RxList<String> sortFilterList){
    if(searchKey.value == ""){
      if(sortFilterList.value.isEmpty){
        return _topSearch(context);
      }else{
        return _topSearchFilter(context);
      }
    }else{
      if(sortFilterList.value.isEmpty){
        return _exploreSearch(context);
      }else{
        return _exploreSearchFilter(context);
      }
    }
  }

  Widget _topSearch(BuildContext context){
    return FutureBuilder(
      future: controller.getTopSearch(context),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return controller.total.value == 0
              ? NoDataFound(context)
              : _topSearchResult(context);
        }
        return Loading();
      },
    );
  }

  Widget _topSearchResult(BuildContext context){
    return ListView.builder(
        itemCount: controller.total.value,
        itemBuilder: (context, index){
          var data = controller.modelC.film.value.data![index];
          return SearchItem(
            onPressed: (){
              if(data.tipe == Constant.movie){
                Get.toNamed(Routes.MOVIE_DETAIL, arguments: data.id);
              }else{
                Get.toNamed(Routes.SERIES_DETAIL, arguments: data.id);
              }
            },
            index: index,
            title: "${data.title}",
            url: "${Constant.baseUrl}/${data.thumbnail}",
          );
        }
    );
  }

  Widget _topSearchFilter(BuildContext context){
    return FutureBuilder(
      future: controller.getTopSearchFilter(context, controller.selectedCategory.value, controller.selectedRegion.value, controller.selectedGenre.value, controller.selectedTimePeriod.value),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return controller.total.value == 0
              ? NoDataFound(context)
              : _topSearchFilterResult(context);
        }
        return Loading();
      },
    );
  }

  Widget _topSearchFilterResult(BuildContext context){
    return GridView.builder(
        itemCount: controller.total.value,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: Get.height * 0.012637867647058824,
            mainAxisSpacing: Get.height * 0.012637867647058824
        ),
        itemBuilder: (context, index){
          var data = controller.modelC.film.value.data![index];
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
            rating: "${data.rating!.toDouble() * 2}",
          );
        }
    );
  }

  Widget _exploreSearch(BuildContext context){
    return FutureBuilder(
      future: controller.getExploreSearch(context, controller.searchKey.value),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return controller.total.value == 0
              ? NoDataFound(context)
              : _exploreSearchResult(context);
        }
        return Loading();
      },
    );
  }

  Widget _exploreSearchResult(BuildContext context){
    return GridView.builder(
        itemCount: controller.total.value,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: Get.height * 0.012637867647058824,
            mainAxisSpacing: Get.height * 0.012637867647058824
        ),
        itemBuilder: (context, index){
          var data = controller.modelC.film.value.data![index];
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
            rating: "${data.rating!.toDouble() * 2}",
          );
        }
    );
  }

  Widget _exploreSearchFilter(BuildContext context){
    return FutureBuilder(
      future: controller.getExploreSearchFilter(context, controller.searchKey.value, controller.selectedCategory.value, controller.selectedRegion.value, controller.selectedGenre.value, controller.selectedTimePeriod.value),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return controller.total.value == 0
              ? NoDataFound(context)
              : _exploreSearchFilterResult(context);
        }
        return Loading();
      },
    );
  }

  Widget _exploreSearchFilterResult(BuildContext context){
    return GridView.builder(
        itemCount: controller.total.value,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: Get.height * 0.012637867647058824,
            mainAxisSpacing: Get.height * 0.012637867647058824
        ),
        itemBuilder: (context, index){
          var data = controller.modelC.film.value.data![index];
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
            rating: "${data.rating!.toDouble() * 2}",
          );
        }
    );
  }
}