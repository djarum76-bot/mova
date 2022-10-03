import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mova/app/controllers/model_controller.dart';
import 'package:mova/app/models/comment_model.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/utils/is_connect.dart';
import 'package:mova/app/widget/error_message.dart';

class SeriesCommentController extends GetxController {
  late TextEditingController comment;
  final loading = false.obs;

  final modelC = Get.find<ModelController>();

  final total = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    comment = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    comment.dispose();
  }

  Future<void> addComment(BuildContext context, int filmId)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      try{
        loading.value = true;

        Dio.FormData formData = Dio.FormData.fromMap({
          "film_id" : filmId,
          "comment" : comment.text,
          "createdAt" : DateTime.now().toIso8601String()
        });

        final response = await dio.post("/auth/comment",
            data: formData,
            options: Dio.Options(
                headers: {
                  Constant.Accept : Constant.app_json,
                  Constant.Authorization : "bearer ${box.read(Constant.token)}"
                }
            )
        );

        if(response.statusCode == 200){
          comment.clear();
          await getAllComment(context, filmId);
        }else{
          ErrorMessage(context, "Error");
        }

        loading.value = false;
      }on Dio.DioError catch(e){
        ErrorMessageExit(context, e.message);
      }catch(e){
        ErrorMessageExit(context, e.toString());
      }
    }else{
      ErrorMessage(context, "No Internet Connection");
    }
  }

  Future<void> getAllComment(BuildContext context, int filmId)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      try{
        final response = await dio.get("/auth/comment/$filmId",
            options: Dio.Options(
                headers: {
                  Constant.Accept : Constant.app_json,
                  Constant.Authorization : "bearer ${box.read(Constant.token)}"
                }
            )
        );

        final data = response.data;

        if(response.statusCode == 200){
          modelC.comments(CommentModel.fromJson(data));
          modelC.comments.refresh();

          total.value = modelC.comments.value.data!.length;
          total.refresh();
        }else{
          ErrorMessage(context, "Error");
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
