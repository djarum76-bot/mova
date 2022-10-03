import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/services/auth_service.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/widget/error_message.dart';

class AuthController extends GetxController{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<User?> authStatus(){
    return auth.authStateChanges();
  }

  Future<void> passwordRegisterToFirebase(BuildContext context, String email, String password)async{
    try{
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      box.write(Constant.password, password);
      Get.offAllNamed(Routes.INTEREST);
    }on FirebaseAuthException catch(e){
      ErrorMessage(context, e.message!);
    }catch(e){
      ErrorMessage(context, e.toString());
    }
  }

  Future<void> passwordLoginToFirebase(BuildContext context, String email, String password)async{
    try{
      UserCredential myUser = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      CollectionReference users = firestore.collection(Constant.usersCollection);
      final dataUser = await users.doc(myUser.user!.uid).get();

      if(dataUser.data() == null){
        Get.offAllNamed(Routes.INTEREST);
      }else{
        await AuthService().loginPasswordToGolang(context, email, password);
      }
    }on FirebaseAuthException catch(e){
      ErrorMessage(context, e.message!);
    }catch(e){
      ErrorMessage(context, e.toString());
    }
  }

  Future<void> googleLoginToFirebase(BuildContext context)async{
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken,
        idToken: googleAuth.idToken
      );

      UserCredential myUser = await auth.signInWithCredential(credential);

      CollectionReference users = firestore.collection(Constant.usersCollection);
      final dataUser = await users.doc(myUser.user!.uid).get();

      if(dataUser.data() == null){
        Get.offAllNamed(Routes.INTEREST);
      }else{
        await AuthService().loginGoogleToGolang(context, myUser.user!.email!);
      }
    }on FirebaseAuthException catch(e){
      ErrorMessage(context, e.message!);
    }catch(e){
      ErrorMessage(context, e.toString());
    }
  }

  Future<void> logout(BuildContext context)async{
    try{
      final isSignIn = await GoogleSignIn().isSignedIn();

      if(isSignIn){
        await GoogleSignIn().signOut();
      }

      await auth.signOut();
      Get.offAllNamed(Routes.CUSTOM_AUTH);
    }on FirebaseAuthException catch(e){
      ErrorMessage(context, e.message!);
    }catch(e){
      ErrorMessage(context, e.toString());
    }
  }
}