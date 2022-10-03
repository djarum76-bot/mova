import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mova/app/controllers/model_controller.dart';
import 'package:mova/app/models/movies_model.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/utils/is_connect.dart';
import 'package:mova/app/widget/error_message.dart';

class Top10Controller extends GetxController {
  final modelC = Get.find<ModelController>();

  final total = 0.obs;

  Future<void> getTop10Movie(BuildContext context)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      try{
        final response = await dio.get("/auth/top10movie",
          options: Dio.Options(
            headers: {
              Constant.Accept : Constant.app_json,
              Constant.Authorization : "bearer ${box.read(Constant.token)}"
            }
          )
        );

        final data = response.data;

        if(response.statusCode == 200){
          modelC.movies(MoviesModel.fromJson(data));
          modelC.movies.refresh();

          total.value = modelC.movies.value.data!.length;
          total.refresh();
        }else{
          ErrorMessageExit(context, "Error");
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
