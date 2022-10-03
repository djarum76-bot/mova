import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: Get.arguments,
          navigationDelegate: (navigation)async{
            await Future.delayed(Duration(seconds: 2)).then((value){
              Get.back();
            });
            // print(navigation.url);
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }
}
