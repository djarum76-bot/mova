import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:mova/app/controllers/auth_controller.dart';
import 'package:mova/app/controllers/model_controller.dart';
import 'package:mova/app/modules/splash/splash_view.dart';
import 'package:mova/app/modules/video_play/controllers/video_play_controller.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/widget/material_color.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import 'app/routes/app_pages.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

// class MyApp extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       theme: ThemeData(
//           scaffoldBackgroundColor: Color(0xFF181a20),
//           primaryTextTheme: Typography().white,
//           textTheme: Typography().white,
//           primaryColorBrightness: Brightness.dark,
//           colorScheme: ColorScheme.fromSwatch(
//             primarySwatch: createMaterialColor(Color(0xFFE21221))
//           )
//       ),
//       initialRoute: Routes.CUSTOM_AUTH,
//       title: "Application",
//       getPages: AppPages.routes,
//     );
//   }
// }

class MyApp extends StatelessWidget{
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    Get.put(ModelController(), permanent: true);
    return FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 2000)),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return StreamBuilder<User?>(
                stream: authC.authStatus(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.active){
                    return GetMaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                          scaffoldBackgroundColor: Color(0xFF181a20),
                          primaryTextTheme: Typography().white,
                          textTheme: Typography().white,
                          colorScheme: ColorScheme.fromSwatch(
                              primarySwatch: createMaterialColor(Color(0xFFE21221))
                          )
                      ),
                      title: "Application",
                      initialRoute: box.read(Constant.skipIntro) == null
                          ? Routes.INTRODUCTION
                          : snapshot.data != null
                            ? Routes.INTERSECTION
                            : Routes.CUSTOM_AUTH,
                      getPages: AppPages.routes,
                    );
                  }
                  return SplashView();
                }
            );
          }
          return SplashView();
        }
    );
  }
}
