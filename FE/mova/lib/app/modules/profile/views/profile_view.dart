import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:mova/app/widget/profile_item.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(() {
            return controller.loading.value
                ? _onLoading(context)
                : _profileMainScreen(context);
          })
      ),
    );
  }

  Widget _onLoading(BuildContext context){
    return Stack(
      children: [
        _profileMainScreen(context),
        Container(
          width: Get.width,
          height: Get.height,
          color: Colors.black.withOpacity(0.8),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }

  Widget _profileMainScreen(BuildContext context){
    return Column(
      children: [
        _profileMainScreenHeader(),
        SizedBox(height: Get.height * 0.02,),
        _profileMainScreenBody(context)
      ],
    );
  }

  Widget _profileMainScreenHeader(){
    return Container(
      width: Get.width,
      height: Get.height * 0.09,
      padding: EdgeInsets.all(Get.height * 0.02),
      child: Row(
        children: [
          Lottie.asset("asset/lottie/splash.json"),
          SizedBox(width: Get.height * 0.01,),
          AutoSizeText(
            "Profile",
            style: GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.w700),
            maxLines: 1,
          )
        ],
      ),
    );
  }

  Widget _profileMainScreenBody(BuildContext context){
    return FutureBuilder(
        future: controller.getUser(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.height * 0.02),
                  child: ListView(
                    children: [
                      _profileMainScreenBodyPicture(),
                      SizedBox(height: Get.height * 0.02,),
                      _profileMainScreenBodyUsername(),
                      _profileMainScreenBodyEmail(),
                      SizedBox(height: Get.height * 0.02,),
                      _joinPremium(),
                      SizedBox(height: Get.height * 0.02,),
                      _goToEditProfile(),
                      _goToNotificationSetting(),
                      _goToDownloadSetting(),
                      _logout(context),
                    ],
                  ),
                )
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

  Widget _profileMainScreenBodyPicture(){
    return Align(
      alignment: Alignment.center,
      child: Obx(() {
        return controller.imageUrl.value != ""
            ? _picture()
            : _noPicture();
      }),
    );
  }

  Widget _picture(){
    return CircleAvatar(
      backgroundImage: NetworkImage("${Constant.baseUrl}/${controller.imageUrl.value}"),
      backgroundColor: Color(0xFF464648),
      radius: Get.height * 0.07582720588235295,
    );
  }

  Widget _noPicture(){
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

  Widget _profileMainScreenBodyUsername(){
    return Obx(() {
      return Container(
        width: Get.width,
        alignment: Alignment.center,
        child: Text(
          "${controller.username.value}",
          style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
      );
    });
  }

  Widget _profileMainScreenBodyEmail(){
    return Obx(() {
      return Container(
        width: Get.width,
        alignment: Alignment.center,
        child: Text(
          "${controller.email.value}",
          style: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w400),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
      );
    });
  }

  Widget _joinPremium(){
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.SUBSCRIBE);
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Color(0xFFea202f), width: 3),
            color: Color(0xFF1f222a)
        ),
        height: Get.height * 0.13,
        padding: EdgeInsets.only(left: Get.height * 0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: Get.height * 0.1,
              height: Get.height * 0.09,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF2f202a)),
              child: Center(
                child: Icon(
                  LineIcons.crown,
                  color: Color(0xFFec2432),
                  size: Get.height * 0.06318933823529412,
                ),
              ),
            ),
            SizedBox(width: Get.height * 0.015,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.01,),
                AutoSizeText(
                  "Join Premium!",
                  style: GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFFe21221)),
                  maxLines: 1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Enjoy watching Full-HD movies",
                      style: GoogleFonts.urbanist(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                    AutoSizeText(
                      "without restrictions and without ads",
                      style: GoogleFonts.urbanist(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
                SizedBox(height: Get.height * 0.01,),
              ],
            ),
            SizedBox(width: Get.height * 0.015,),
            Icon(
              LineIcons.angleRight,
              color: Color(0xFFec2432),
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _goToEditProfile(){
    return ProfileItem(
        onPressed: () {
          Get.toNamed(Routes.EDIT_PROFILE);
        },
        icon: LineIcons.user,
        label: "Edit Profile"
    );
  }

  Widget _goToNotificationSetting(){
    return ProfileItem(
        onPressed: () {
          Get.toNamed(Routes.NOTIFICATION_SETTING);
        },
        icon: LineIcons.bell,
        label: "Notification"
    );
  }

  Widget _goToDownloadSetting(){
    return ProfileItem(
        onPressed: () {
          Get.toNamed(Routes.DOWNLOAD_SETTING);
        },
        icon: LineIcons.download,
        label: "Download"
    );
  }

  Widget _logout(BuildContext context){
    return ProfileItem(
        color: Color(0xFFf4313f),
        onPressed: () {
          _logoutBottomSheet(context);
        },
        icon: LineIcons.alternateSignOut,
        label: "Logout"
    );
  }

  Future<dynamic> _logoutBottomSheet(BuildContext context){
    return Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(Get.height * 0.02),
        height: Get.height * 0.225,
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
            Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: AutoSizeText(
                      "Logout",
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 20, color: Color(0xFFef5252)),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01,),
                  Divider(color: Color(0xFF30333b), thickness: 2,),
                  AutoSizeText(
                    "Are you sure you want to logout ?",
                    style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
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
                              controller.logout(context);
                            },
                            child: AutoSizeText(
                              "Yes, Logout",
                              style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
                              maxLines: 1,
                            )
                        ),
                      )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}