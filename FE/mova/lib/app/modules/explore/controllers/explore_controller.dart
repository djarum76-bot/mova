import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mova/app/controllers/model_controller.dart';
import 'package:mova/app/models/film_model.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/utils/is_connect.dart';
import 'package:mova/app/utils/url_generator.dart';
import 'package:mova/app/widget/error_message.dart';

class ExploreController extends GetxController {
  late TextEditingController search;
  final onSearch = false.obs;

  final modelC = Get.find<ModelController>();
  final total = 0.obs;

  final sortFilterList = <String>[].obs;

  List<String> categoryList = [
    "Movie",
    "TV Show",
    "K-Drama",
    "J-Drama",
    "Wibu",
  ];
  final selectedCategory = "".obs;

  List<String> regionList = [
    "All Region",
    "US",
    "South Korea",
    "Japan",
    "Indonesia",
  ];
  final selectedRegion = "".obs;

  List<String> genreList = [
    "Action",
    "Drama",
    "Comedy",
    "Horror",
    "Adventure",
    "Thriller",
    "Romance",
    "Science",
    "Music",
    "Documentary",
    "Crime",
    "Fantasy",
    "Mistery",
    "Fiction",
    "War",
    "History",
    "Superheroes",
    "Sport",
  ];
  final selectedGenre = "".obs;

  List<String> timePeriodList = [
    "All Periods",
    "2022",
    "2021",
    "2020",
    "2019",
  ];
  final selectedTimePeriod = "".obs;

  List<String> sortList = [
    "Popularity",
    "Latest Release",
  ];
  final selectedSort = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    search = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    search.dispose();
  }

  sedangCari(String val){
    if(val == ""){
      onSearch.value = false;
    }else{
      onSearch.value = true;
    }
  }

  Future<void> getExplore(BuildContext context)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      try{
        final response = await dio.get("/auth/explore",
          options: Dio.Options(
            headers: {
              Constant.Accept : Constant.app_json,
              Constant.Authorization : "bearer ${box.read(Constant.token)}"
            }
          )
        );

        final data = response.data;

        if(response.statusCode == 200){
          modelC.explore(FilmModel.fromJson(data));
          modelC.explore.refresh();

          total.value = modelC.explore.value.data!.length;
          total.refresh();
        }else{
          ErrorMessage(context, "Fail to get data");
        }
      }on Dio.DioError catch(e){
        ErrorMessageExit(context, e.message);
      }catch(e){
        ErrorMessageExit(context, e.toString());
      }
    }else{
      ErrorMessage(context, "No Internet Connection");
    }
  }

  Future<void> getExploreFilter(BuildContext context, String category, String region, String genre, String release)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      try{
        String url = await urlGenerator("explorefilter", category, region, genre, release);

        final response = await dio.get(url,
            options: Dio.Options(
                headers: {
                  Constant.Accept : Constant.app_json,
                  Constant.Authorization : "bearer ${box.read(Constant.token)}"
                }
            )
        );

        final data = response.data;

        if(response.statusCode == 200){
          modelC.explore(FilmModel.fromJson(data));
          modelC.explore.refresh();

          total.value = modelC.explore.value.data!.length;
          total.refresh();
        }else{
          ErrorMessage(context, "Fail to get data");
        }
      }on Dio.DioError catch(e){
        ErrorMessageExit(context, e.message);
      }catch(e){
        ErrorMessageExit(context, e.toString());
      }
    }else{
      ErrorMessage(context, "No Internet Connection");
    }
  }
}
