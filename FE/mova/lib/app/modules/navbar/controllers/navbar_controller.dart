import 'package:get/get.dart';

class NavbarController extends GetxController {
  final tabIndex = 0.obs;

  void pindahTab(int index){
    tabIndex.value = index;
  }
}
