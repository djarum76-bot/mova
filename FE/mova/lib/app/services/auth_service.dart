import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mova/app/controllers/auth_controller.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/utils/constant.dart';

class AuthService{
  AuthService({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
    FirebaseStorage? firebaseStorage
  }) :  _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  final authC = Get.find<AuthController>();

  routeSwitch(BuildContext context)async{
    CollectionReference users = _firebaseFirestore.collection(Constant.usersCollection);
    final dataUser = await users.doc(_firebaseAuth.currentUser!.uid).get();

    if(dataUser.data() == null){
      Get.offAllNamed(Routes.INTEREST);
    }else{
      final email = _firebaseAuth.currentUser!.email;
      final uid = _firebaseAuth.currentUser!.uid;
      if(box.read(Constant.token) != null){
        if(JwtDecoder.isExpired(box.read(Constant.token))){
          box.remove(Constant.token);
          await generateNewToken(context, email!, uid);
        }
      }else{
        await generateNewToken(context, email!, uid);
      }
      Get.offAllNamed(Routes.NAVBAR);
    }
  }

  Future<void> generateNewToken(BuildContext context, String email, String uid)async{
    try{
      Dio.FormData formData = Dio.FormData.fromMap({
        "email" : email,
        "uid" : uid
      });

      final response = await dio.post('/generatenewtoken',
        data: formData,
        options: Dio.Options(
          headers: {
            "Accept" : "application/json"
          }
        )
      );

      if(response.statusCode == 200){
        final data = response.data;
        final token = data[Constant.token];
        box.write(Constant.token, token);
      }else{
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          dialogBackgroundColor: Color(0xFF1f222a),
          dialogBorderRadius: BorderRadius.circular(16),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                "${response.statusMessage}",
                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
            ],
          ),
        )..show();
      }
    }on Dio.DioError catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "${e.message}",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "${e.toString()}",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }
  }

  Future<void> checkUsernamePhone(BuildContext context, String username, String phone, String imagePath)async{
    try{
      Dio.FormData formData = Dio.FormData.fromMap({
        "username" : username,
        "phone" : phone,
      });

      final response = await dio.post('/checkusernamephone',
          data: formData,
          options: Dio.Options(
              headers: {
                "Accept" : "application/json"
              }
          )
      );

      if(response.statusCode == 200){
        box.write(Constant.image, imagePath);
        box.write(Constant.username, username);
        box.write(Constant.phone, phone);
        Get.toNamed(Routes.NEW_PIN);
      }else{
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          dialogBackgroundColor: Color(0xFF1f222a),
          dialogBorderRadius: BorderRadius.circular(16),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                "Username or Phone Number already used",
                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
            ],
          ),
        )..show();
      }
    }on Dio.DioError catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "Username or Phone Number already used",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "Username or Phone Number already used",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }
  }

  Future<void> checkEmail(BuildContext context, String email, String password)async{
    try{
      Dio.FormData formData = Dio.FormData.fromMap({
        "email" : email
      });
      
      final response = await dio.post("/checkemail",
        data: formData,
        options: Dio.Options(
          headers: {
            "Accept" : "application/json"
          }
        )
      );

      if(response.statusCode == 200){
        await authC.passwordRegisterToFirebase(context, email, password);
      }else{
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          dialogBackgroundColor: Color(0xFF1f222a),
          dialogBorderRadius: BorderRadius.circular(16),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                "Email already used",
                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
            ],
          ),
        )..show();
      }
    }on Dio.DioError catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "Email already used",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "Email already used",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }
  }

  Future<void> addUserData(BuildContext context, String uid, String username, String email, String keyName, List<String> interest, String phone, String pin, String imagePath)async{
    try{
      CollectionReference users = _firebaseFirestore.collection(Constant.usersCollection);

      String dateNow = DateTime.now().toIso8601String();

      if(imagePath == ""){
        if(box.read(Constant.password) == null){
          await registerGoogleWithoutPictureToGolang(context, uid, username, email, phone, keyName, dateNow, pin, interest);
        }else{
          await registerPasswordWithoutPictureToGolang(context, uid, username, email, phone, keyName, dateNow, pin, interest, box.read(Constant.password) as String);
        }

        await users.doc(uid).set({
          "uid" : uid,
          "username" : username,
          "email" : email,
          "phone" : phone,
          "keyName" : keyName,
          "picture" : "",
          "createdAt" : dateNow,
          "interest" : interest,
          "pin" : pin
        });
      }else{
        final imageFile = File(imagePath);
        final imageName = imagePath.split('/').last;
        await _firebaseStorage.ref("profile/${imageName}").putFile(imageFile);

        String profileUrl = await _firebaseStorage.ref("profile/${imageName}").getDownloadURL();

        if(box.read(Constant.password) == null){
          await registerGoogleWithPictureToGolang(context, uid, username, email, phone, keyName, dateNow, imagePath, pin, interest);
        }else{
          await registerPasswordWithPictureToGolang(context, uid, username, email, phone, keyName, dateNow, imagePath, pin, interest, box.read(Constant.password) as String);
        }

        await users.doc(uid).set({
          "uid" : uid,
          "username" : username,
          "email" : email,
          "phone" : phone,
          "keyName" : keyName,
          "picture" : profileUrl,
          "createdAt" : dateNow,
          "interest" : interest,
          "pin" : pin
        });
      }

      box.remove(Constant.image);
      box.remove(Constant.interest);
      box.remove(Constant.username);
      box.remove(Constant.phone);
      box.remove(Constant.password);

      Get.offAllNamed(Routes.NAVBAR);

    }on FirebaseException catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "${e.message}",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "${e.toString()}",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }
  }

  //Google
  Future<void> registerGoogleWithoutPictureToGolang(BuildContext context,String uid, String username, String email, String phone, String keyName, String dateNow, String pin, List<String> interest)async{
    try{
      Dio.FormData formData = Dio.FormData.fromMap({
        "uid" : uid,
        "username" : username,
        "email" : email,
        "phone" : phone,
        "keyName" : keyName,
        "createdAt" : dateNow,
        "pin" : pin,
      });

      for (var inter in interest){
        formData.fields.addAll([
          MapEntry("interest", inter)
        ]);
      }

      final response = await dio.post("/registergooglewithoutpicture",
          data: formData,
          options: Dio.Options(
              headers:{
                "Accept" : "application/json"
              }
          )
      );

      if(response.statusCode != 200){
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          dialogBackgroundColor: Color(0xFF1f222a),
          dialogBorderRadius: BorderRadius.circular(16),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                "${response.statusMessage}",
                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
            ],
          ),
        )..show();
      }else{
        final data = response.data;
        final token = data[Constant.token];
        box.write(Constant.token, token);
      }
    }on Dio.DioError catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "${e.message}",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }
  }

  Future<void> registerGoogleWithPictureToGolang(BuildContext context, String uid, String username, String email, String phone, String keyName, String dateNow, String imagePath, String pin, List<String> interest)async{
    try{
      Dio.FormData formData = Dio.FormData.fromMap({
        "uid" : uid,
        "username" : username,
        "email" : email,
        "phone" : phone,
        "keyName" : keyName,
        "createdAt" : dateNow,
        "picture" : await Dio.MultipartFile.fromFile(imagePath, filename: imagePath.split('/').last),
        "pin" : pin,
      });

      for (var inter in interest){
        formData.fields.addAll([
          MapEntry("interest", inter)
        ]);
      }

      final response = await dio.post('/registergooglewithpicture',
          data: formData,
          options: Dio.Options(
              headers:{
                "Accept" : "application/json"
              }
          )
      );

      if(response.statusCode != 200){
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          dialogBackgroundColor: Color(0xFF1f222a),
          dialogBorderRadius: BorderRadius.circular(16),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                "${response.statusMessage}",
                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
            ],
          ),
        )..show();
      }else{
        final data = response.data;
        final token = data[Constant.token];
        box.write(Constant.token, token);
      }
    }on Dio.DioError catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "${e.message}",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }
  }

  Future<void> loginGoogleToGolang(BuildContext context, String email)async{
    try{
      Dio.FormData formData = Dio.FormData.fromMap({
        "email" : email
      });

      final response = await dio.post('/logingoogle',
        data: formData,
        options: Dio.Options(
          headers: {
            "Accept" : "application/json"
          }
        )
      );

      if(response.statusCode == 200){
        final data = response.data;
        final token = data[Constant.token];
        box.write(Constant.token, token);
        Get.offAllNamed(Routes.NAVBAR);
      }else{
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          dialogBackgroundColor: Color(0xFF1f222a),
          dialogBorderRadius: BorderRadius.circular(16),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                "${response.statusMessage}",
                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
            ],
          ),
        )..show();
      }
    }on Dio.DioError catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "${e.message}",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }
  }

  //Password
  Future<void> registerPasswordWithoutPictureToGolang(BuildContext context, String uid, String username, String email, String phone, String keyName, String dateNow, String pin, List<String> interest, String password)async{
    try{
      Dio.FormData formData = Dio.FormData.fromMap({
        "uid" : uid,
        "username" : username,
        "email" : email,
        "phone" : phone,
        "keyName" : keyName,
        "createdAt" : dateNow,
        "pin" : pin,
        "password" : password
      });

      for (var inter in interest){
        formData.fields.addAll([
          MapEntry("interest", inter)
        ]);
      }

      final response = await dio.post("/registerpasswordwithoutpicture",
        data: formData,
        options: Dio.Options(
          headers: {
            "Accept" : "application/json"
          }
        )
      );

      if(response.statusCode != 200){
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          dialogBackgroundColor: Color(0xFF1f222a),
          dialogBorderRadius: BorderRadius.circular(16),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                "${response.statusMessage}",
                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
            ],
          ),
        )..show();
      }else{
        final data = response.data;
        final token = data[Constant.token];
        box.write(Constant.token, token);
      }


    }on Dio.DioError catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "${e.message}",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "${e.toString()}",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }
  }

  Future<void> registerPasswordWithPictureToGolang(BuildContext context, String uid, String username, String email, String phone, String keyName, String dateNow, String imagePath, String pin, List<String> interest, String password)async{
    try{
      Dio.FormData formData = Dio.FormData.fromMap({
        "uid" : uid,
        "username" : username,
        "email" : email,
        "phone" : phone,
        "keyName" : keyName,
        "createdAt" : dateNow,
        "picture" : await Dio.MultipartFile.fromFile(imagePath, filename: imagePath.split('/').last),
        "pin" : pin,
        "password" : password
      });

      for (var inter in interest){
        formData.fields.addAll([
          MapEntry("interest", inter)
        ]);
      }

      final response = await dio.post("/registerpasswordwithpicture",
          data: formData,
          options: Dio.Options(
              headers: {
                "Accept" : "application/json"
              }
          )
      );

      if(response.statusCode != 200){
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          dialogBackgroundColor: Color(0xFF1f222a),
          dialogBorderRadius: BorderRadius.circular(16),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                "${response.statusMessage}",
                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
            ],
          ),
        )..show();
      }else{
        final data = response.data;
        final token = data[Constant.token];
        box.write(Constant.token, token);
      }
    }on Dio.DioError catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "${e.message}",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "${e.toString()}",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }
  }

  Future<void> loginPasswordToGolang(BuildContext context, String email, String password)async{
    try{
      Dio.FormData formData = Dio.FormData.fromMap({
        "email" : email,
        "password" : password
      });

      final response = await dio.post('/loginpassword',
          data: formData,
          options: Dio.Options(
              headers: {
                "Accept" : "application/json"
              }
          )
      );

      if(response.statusCode == 200){
        final data = response.data;
        final token = data[Constant.token];
        box.write(Constant.token, token);
        Get.offAllNamed(Routes.NAVBAR);
      }else{
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          dialogBackgroundColor: Color(0xFF1f222a),
          dialogBorderRadius: BorderRadius.circular(16),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                "${response.statusMessage}",
                style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                maxLines: 1,
              ),
              SizedBox(height: Get.height * 0.03,),
            ],
          ),
        )..show();
      }
    }on Dio.DioError catch(e){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        dialogBackgroundColor: Color(0xFF1f222a),
        dialogBorderRadius: BorderRadius.circular(16),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "${e.message}",
              style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
              maxLines: 1,
            ),
            SizedBox(height: Get.height * 0.03,),
          ],
        ),
      )..show();
    }
  }
}