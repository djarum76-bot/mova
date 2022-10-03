import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:mova/app/utils/constant.dart';

import '../controllers/fill_profile_controller.dart';

class FillProfileView extends GetView<FillProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(Get.height * 0.02),
            child: Obx((){
              return controller.loading.value
                  ? Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: Get.width,
                              height: Get.height * 0.04,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Get.back();
                                    },
                                    borderRadius: BorderRadius.circular(100),
                                    child: Icon(
                                      LineIcons.arrowLeft,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: Get.height * 0.02,),
                                  AutoSizeText(
                                    "Fill Your Profile",
                                    style: GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.w700),
                                    maxLines: 1,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: Get.height * 0.04,),
                            Expanded(
                                child: ListView(
                                  children: [
                                    Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Obx((){
                                            return controller.ambil.value
                                                ? CircleAvatar(
                                              backgroundImage: FileImage(controller.imageFile.value),
                                              backgroundColor: Color(0xFF464648),
                                              radius: Get.height * 0.07582720588235295,
                                            )
                                                : CircleAvatar(
                                              child: Icon(
                                                LineIcons.user,
                                                size: Get.height * 0.12637867647058823,
                                                color: Colors.white,
                                              ),
                                              backgroundColor: Color(0xFF464648),
                                              radius: Get.height * 0.07582720588235295,
                                            );
                                          }),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            right: Get.height * 0.1579733455882353,
                                            child: InkWell(
                                              onTap: (){
                                                controller.ambilGambar();
                                              },
                                              borderRadius: BorderRadius.circular(6),
                                              child: Container(
                                                width: Get.height * 0.035,
                                                height: Get.height * 0.035,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(6),
                                                    color: Color(0xFFE21221)
                                                ),
                                                child: Icon(Icons.edit),
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.04,),
                                    Form(
                                        key: controller.key,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Color(0xFF1f222a),
                                                hintText: "Username",
                                                hintStyle: GoogleFonts.urbanist(color: Color(0xFF9d9d9d)),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                                focusColor: Color(0xFFE21221),
                                              ),
                                              controller: controller.username,
                                              keyboardAppearance: Brightness.dark,
                                              keyboardType: TextInputType.name,
                                              validator: ValidationBuilder().build(),
                                            ),
                                            SizedBox(height: Get.height * 0.01,),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Color(0xFF1f222a),
                                                hintText: "Email",
                                                hintStyle: GoogleFonts.urbanist(color: Color(0xFF9d9d9d)),
                                                suffixIcon: Icon(
                                                  Icons.email,
                                                  color: Color(0xFF9d9d9d),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                                focusColor: Color(0xFFE21221),
                                              ),
                                              controller: controller.email,
                                              keyboardAppearance: Brightness.dark,
                                              keyboardType: TextInputType.emailAddress,
                                              readOnly: true,
                                            ),
                                            SizedBox(height: Get.height * 0.01,),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Color(0xFF1f222a),
                                                hintText: "Phone Number",
                                                hintStyle: GoogleFonts.urbanist(color: Color(0xFF9d9d9d)),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                                focusColor: Color(0xFFE21221),
                                              ),
                                              controller: controller.phone,
                                              keyboardAppearance: Brightness.dark,
                                              keyboardType: TextInputType.phone,
                                              validator: ValidationBuilder().phone("Not valid phone number").build(),
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                )
                            ),
                            SizedBox(height: Get.height * 0.02,),
                            Container(
                              width: Get.width,
                              height: Get.height * 0.06,
                              child: AppButton(
                                  onPressed: () {
                                    controller.check(context);
                                  },
                                  child: AutoSizeText(
                                    "Continue",
                                    style: GoogleFonts.urbanist(fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                    maxLines: 1,
                                  )
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: Get.width,
                          height: Get.height,
                          color: Colors.black.withOpacity(0.8),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      ],
                    )
                  : Column(
                children: [
                  Container(
                    width: Get.width,
                    height: Get.height * 0.04,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            Get.back();
                          },
                          borderRadius: BorderRadius.circular(100),
                          child: Icon(
                            LineIcons.arrowLeft,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: Get.height * 0.02,),
                        AutoSizeText(
                          "Fill Your Profile",
                          style: GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.w700),
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.04,),
                  Expanded(
                      child: ListView(
                        children: [
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Obx((){
                                  return controller.ambil.value
                                      ? CircleAvatar(
                                    backgroundImage: FileImage(controller.imageFile.value),
                                    backgroundColor: Color(0xFF464648),
                                    radius: Get.height * 0.07582720588235295,
                                  )
                                      : CircleAvatar(
                                    child: Icon(
                                      LineIcons.user,
                                      size: Get.height * 0.12637867647058823,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Color(0xFF464648),
                                    radius: Get.height * 0.07582720588235295,
                                  );
                                }),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: Get.height * 0.1579733455882353,
                                  child: InkWell(
                                    onTap: (){
                                      controller.ambilGambar();
                                    },
                                    borderRadius: BorderRadius.circular(6),
                                    child: Container(
                                      width: Get.height * 0.035,
                                      height: Get.height * 0.035,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          color: Color(0xFFE21221)
                                      ),
                                      child: Icon(Icons.edit),
                                    ),
                                  )
                              )
                            ],
                          ),
                          SizedBox(height: Get.height * 0.04,),
                          Form(
                              key: controller.key,
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFF1f222a),
                                      hintText: "Username",
                                      hintStyle: GoogleFonts.urbanist(color: Color(0xFF9d9d9d)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      focusColor: Color(0xFFE21221),
                                    ),
                                    controller: controller.username,
                                    keyboardAppearance: Brightness.dark,
                                    keyboardType: TextInputType.name,
                                    validator: ValidationBuilder().build(),
                                  ),
                                  SizedBox(height: Get.height * 0.01,),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFF1f222a),
                                      hintText: "Email",
                                      hintStyle: GoogleFonts.urbanist(color: Color(0xFF9d9d9d)),
                                      suffixIcon: Icon(
                                        Icons.email,
                                        color: Color(0xFF9d9d9d),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      focusColor: Color(0xFFE21221),
                                    ),
                                    controller: controller.email,
                                    keyboardAppearance: Brightness.dark,
                                    keyboardType: TextInputType.emailAddress,
                                    readOnly: true,
                                  ),
                                  SizedBox(height: Get.height * 0.01,),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFF1f222a),
                                      hintText: "Phone Number",
                                      hintStyle: GoogleFonts.urbanist(color: Color(0xFF9d9d9d)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      focusColor: Color(0xFFE21221),
                                    ),
                                    controller: controller.phone,
                                    keyboardAppearance: Brightness.dark,
                                    keyboardType: TextInputType.phone,
                                    validator: ValidationBuilder().phone("Not valid phone number").build(),
                                  ),
                                ],
                              )
                          )
                        ],
                      )
                  ),
                  SizedBox(height: Get.height * 0.02,),
                  Container(
                    width: Get.width,
                    height: Get.height * 0.06,
                    child: AppButton(
                        onPressed: () {
                          controller.check(context);
                        },
                        child: AutoSizeText(
                          "Continue",
                          style: GoogleFonts.urbanist(fontSize: 16,
                              fontWeight: FontWeight.w700),
                          maxLines: 1,
                        )
                    ),
                  )
                ],
              );
            }),
          )
      ),
    );
  }
}
