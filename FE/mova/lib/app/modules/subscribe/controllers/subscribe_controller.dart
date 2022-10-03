import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mova/app/controllers/model_controller.dart';
import 'package:mova/app/models/gopay_model.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/utils/is_connect.dart';
import 'package:mova/app/widget/error_message.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscribeController extends GetxController {
  final modelC = Get.find<ModelController>();

  Future<void> subscribe(BuildContext context, String id, String price, String name)async{
    final isConnect = await CheckUserConnection();
    if(isConnect){
      try{
        Dio.FormData formData = Dio.FormData.fromMap({
          "id" : id,
          "price" : price,
          "name" : name
        });

        final response = await dio.post("/auth/charge_transaction",
            data: formData,
            options: Dio.Options(
                headers: {
                  "Accept" : "application/json",
                  "Authorization" : "bearer ${box.read(Constant.token)}"
                }
            )
        );

        final data = response.data;

        if(response.statusCode == 200 || response.statusCode == 201){
          modelC.gopay(GopayModel.fromJson(data));
          modelC.gopay.refresh();

          // await launchGopay(modelC.gopay.value.actions![1].url!);
          Get.toNamed(Routes.SUBSCRIPTION, arguments: modelC.gopay.value.actions![1].url!);
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

  Future<void> launchGopay(String url) async {
    // if (await canLaunchUrl(Uri.parse("https://wa.me/${convertNoHp(phone)}"))) {
    //   await launchUrl(Uri.parse("https://wa.me/${convertNoHp(phone)}"));
    // } else {
    //   throw 'Could not launch https://wa.me/${convertNoHp(phone)}';
    // }
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
