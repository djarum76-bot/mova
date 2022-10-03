import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/widget/app_button.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(Get.height * 0.02),
            child: Obx((){
              return controller.loading.value
                  ? _onLoading(context)
                  : _editScreen(context);
            }),
          )
      ),
    );
  }

  Widget _onLoading(BuildContext context){
    return Stack(
      children: [
        _editScreen(context),
        Container(
          width: Get.width,
          height: Get.height,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }

  Widget _editScreen(BuildContext context){
    return Column(
      children: [
        _editScreenHeader(),
        SizedBox(height: Get.height * 0.04,),
        _editScreenForm(context),
        SizedBox(height: Get.height * 0.02,),
        _updateButton(context)
      ],
    );
  }

  Widget _editScreenHeader(){
    return Container(
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
            "Edit Profile",
            style: GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.w700),
            maxLines: 1,
          )
        ],
      ),
    );
  }

  Widget _editScreenForm(BuildContext context){
    return FutureBuilder(
        future: controller.getUser(context),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Expanded(
                child: ListView(
                  children: [
                    _editScreenFormImage(),
                    SizedBox(height: Get.height * 0.04,),
                    _editScreenFormName(),
                    SizedBox(height: Get.height * 0.01,),
                    _editScreenFormEmail(),
                    SizedBox(height: Get.height * 0.01,),
                    _editScreenFormPhone(),
                  ],
                )
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

  Widget _editScreenFormImage(){
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Obx((){
            return _image(controller.ambil, controller.imageUrl);
          }),
        ),
        _editScreenFormImageButton()
      ],
    );
  }

  Widget _image(Rx<bool> ambil, Rx<String> imageUrl){
    if(ambil.value){
      return CircleAvatar(
        backgroundImage: FileImage(controller.imageFile.value),
        backgroundColor: Color(0xFF464648),
        radius: Get.height * 0.07582720588235295,
      );
    }else{
      if(imageUrl.value != ""){
        return CircleAvatar(
          backgroundImage: NetworkImage("${Constant.baseUrl}/${controller.imageUrl.value}"),
          backgroundColor: Color(0xFF464648),
          radius: Get.height * 0.07582720588235295,
        );
      }else{
        return CircleAvatar(
          child: Icon(
            LineIcons.user,
            size: Get.height * 0.12637867647058823,
            color: Colors.white,
          ),
          backgroundColor: Color(0xFF464648),
          radius: Get.height * 0.07582720588235295,
        );
      }
    }
  }

  Widget _editScreenFormImageButton(){
    return Positioned(
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
    );
  }

  Widget _editScreenFormName(){
    return TextFormField(
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
    );
  }

  Widget _editScreenFormEmail(){
    return TextFormField(
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
    );
  }

  Widget _editScreenFormPhone(){
    return TextFormField(
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
      readOnly: true,
    );
  }

  Widget _updateButton(BuildContext context){
    return Container(
      width: Get.width,
      height: Get.height * 0.06,
      child: AppButton(
          onPressed: () {
            if(controller.usernameTEMP == controller.username.text && controller.imagePath == ""){
              Get.back();
            }else{
              _uodateDialog(context);
            }
          },
          child: AutoSizeText(
            "Update",
            style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
            maxLines: 1,
          )
      ),
    );
  }

  Future<dynamic> _uodateDialog(BuildContext context){
    return Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(Get.height * 0.02),
        height: Get.height * 0.24,
        decoration: BoxDecoration(
            color: Color(0xFF1f222a),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _updateDialogText(),
            _updateDialogButton(context)
          ],
        ),
      ),
    );
  }

  Widget _updateDialogText(){
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AutoSizeText(
              "Edit",
              style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 20, color: Color(0xFFef5252)),
            ),
          ),
          SizedBox(height: Get.height * 0.01,),
          Divider(color: Color(0xFF30333b), thickness: 2,),
          AutoSizeText(
            "Are you sure you want to edit your profile ?",
            style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _updateDialogButton(BuildContext context){
    return Container(
      width: Get.width,
      height: Get.height * 0.06,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
              flex: 1,
              child: SizedBox(
                height: Get.height * 0.06,
                child: AppButton(
                    color: Color(0xFF35383f),
                    onPressed: () {
                      Get.back();
                    },
                    child: AutoSizeText(
                      "Cancel",
                      style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
                      maxLines: 1,
                    )
                ),
              )
          ),
          SizedBox(width: Get.height * 0.02,),
          Expanded(
              flex: 1,
              child: SizedBox(
                height: Get.height * 0.06,
                child: AppButton(
                    onPressed: () {
                      controller.Update(context);
                    },
                    child: AutoSizeText(
                      "Yes, Edit",
                      style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
                      maxLines: 1,
                    )
                ),
              )
          ),
        ],
      ),
    );
  }
}
