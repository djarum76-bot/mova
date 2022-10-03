import 'package:blur_bottom_bar/blur_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/modules/download/views/download_view.dart';
import 'package:mova/app/modules/explore/views/explore_view.dart';
import 'package:mova/app/modules/home/views/home_view.dart';
import 'package:mova/app/modules/my_list/views/my_list_view.dart';
import 'package:mova/app/modules/profile/views/profile_view.dart';

import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              _mainScreen(),
              _bottomNavBar()
            ],
          )
      ),
    );
  }

  Widget _mainScreen(){
    return Obx(() {
      return IndexedStack(
        index: controller.tabIndex.value,
        children: [
          HomeView(),
          ExploreView(),
          MyListView(),
          DownloadView(),
          ProfileView()
        ],
      );
    });
  }

  Widget _bottomNavBar(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Obx(() {
        return BlurBottomView(
          currentIndex: controller.tabIndex.value,
          onIndexChange: (val) {
            controller.pindahTab(val);
          },
          bottomNavigationBarItems: const [
            BottomNavigationBarItem(
                icon: Icon(LineIcons.home),
                label: "Home"
            ),
            BottomNavigationBarItem(
                icon: Icon(LineIcons.compass),
                label: "Explore"
            ),
            BottomNavigationBarItem(
                icon: Icon(LineIcons.bookOfTheDead),
                label: "My List"
            ),
            BottomNavigationBarItem(
              icon: Icon(LineIcons.download),
              label: "Download",
            ),
            BottomNavigationBarItem(
                icon: Icon(LineIcons.user),
                label: "Profile"
            ),
          ],
          selectedItemColor: const Color(0xFFe21221),
          unselectedItemColor: const Color(0xFF9e9e9e),
          showUnselectedLabels: true,
          showSelectedLabels: true,
        );
      }),
    );
  }
}
