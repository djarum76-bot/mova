import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    Key? key,
    required this.onPressed,
    required this.index,
    required this.title,
    required this.url,
  }) : super(key: key);

  final void Function()? onPressed;
  final int? index;
  final String? title;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: Get.width,
        height: Get.height * 0.14,
        margin: EdgeInsets.only(bottom: index != 9 ? Get.height * 0.02 : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _searchItemImage(),
            SizedBox(width: Get.height * 0.02,),
            _searchItemTitle()
          ],
        ),
      ),
    );
  }

  Widget _searchItemImage(){
    return Container(
      width: Get.width * 0.4,
      height: Get.height,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url!),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: Icon(
          Icons.play_circle_fill_outlined,
          color: Colors.white,
          size: Get.height * 0.050551470588235295,
        ),
      ),
    );
  }

  Widget _searchItemTitle(){
    return Container(
      width: Get.width * 0.479,
      height: Get.height,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title!,
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 20),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
      ),
    );
  }
}