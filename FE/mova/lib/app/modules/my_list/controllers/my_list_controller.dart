import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mova/app/controllers/model_controller.dart';
import 'package:mova/app/models/favorite_model.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/utils/is_connect.dart';
import 'package:mova/app/widget/error_message.dart';

class MyListController extends GetxController {

  List<String> categoryList = [
    "All Categories",
    "Movie",
    "TV Show",
    "K-Drama",
    "J-Drama",
    "Wibu",
  ];
  final selectedCategory = "All Categories".obs;

  final total = 0.obs;
  final modelC = Get.find<ModelController>();

  Future<void> getAllFavorites(BuildContext context)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      try{
        final response = await dio.get("/auth/favorites",
            options: Dio.Options(
                headers: {
                  Constant.Accept : Constant.app_json,
                  Constant.Authorization : "bearer ${box.read(Constant.token)}"
                }
            )
        );

        final data = response.data;

        if(response.statusCode == 200){
          modelC.favorites(FavoriteModel.fromJson(data));
          modelC.favorites.refresh();

          total.value = modelC.favorites.value.data!.length;
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

  Future<void> getAllFavoritesFilter(BuildContext context, String category)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      try{
        final response = await dio.get("/auth/favoritesfilter?category=$category",
            options: Dio.Options(
                headers: {
                  Constant.Accept : Constant.app_json,
                  Constant.Authorization : "bearer ${box.read(Constant.token)}"
                }
            )
        );

        final data = response.data;

        if(response.statusCode == 200){
          modelC.favorites(FavoriteModel.fromJson(data));
          modelC.favorites.refresh();

          total.value = modelC.favorites.value.data!.length;
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
