import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mova/app/services/auth_service.dart';

import '../controllers/intersection_controller.dart';

class IntersectionView extends GetView<IntersectionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: AuthService().routeSwitch(context),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          )
      ),
    );
  }
}
