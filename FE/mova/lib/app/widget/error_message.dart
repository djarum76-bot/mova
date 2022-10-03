import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mova/app/widget/app_button.dart';

AwesomeDialog ErrorMessage(BuildContext context, String message){
  return AwesomeDialog(
    context: context,
    animType: AnimType.SCALE,
    dialogType: DialogType.ERROR,
    dialogBackgroundColor: Color(0xFF1f222a),
    dialogBorderRadius: BorderRadius.circular(16),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          "${message}",
          style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
          maxLines: 1,
        ),
        SizedBox(height: Get.height * 0.03,),
      ],
    ),
  )..show();
}

AwesomeDialog ErrorMessageExit(BuildContext context, String message){
  return AwesomeDialog(
    context: context,
    animType: AnimType.SCALE,
    dialogType: DialogType.ERROR,
    dialogBackgroundColor: Color(0xFF1f222a),
    dialogBorderRadius: BorderRadius.circular(16),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          "${message}",
          style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
          maxLines: 1,
        ),
        SizedBox(height: Get.height * 0.03,),
        SizedBox(
          width: Get.width,
          child: AppButton(
              onPressed: (){
                exit(0);
              },
              child: AutoSizeText(
                "Exit App",
                style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
                maxLines: 1,
              )
          ),
        ),
        SizedBox(height: Get.height * 0.03,),
      ],
    ),
  )..show();
}