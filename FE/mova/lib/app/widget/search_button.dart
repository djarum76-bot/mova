import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: Get.height * 0.04,
        height: Get.height * 0.04,
        decoration: BoxDecoration(
            shape: BoxShape.circle
        ),
        child: Icon(LineIcons.search, color: Colors.white, size: Get.height * 0.04,),
      ),
      onTap: onPressed,
      borderRadius: BorderRadius.circular(200),
    );
  }
}