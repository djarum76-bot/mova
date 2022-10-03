import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MoviesItem extends StatelessWidget {
  const MoviesItem({
    Key? key,
    required this.index,
    required this.total,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.isList,
    required this.thumbnail,
    required this.rating,
  }) : super(key: key);

  final int? index;
  final int total;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  final bool? isList;
  final String? thumbnail;
  final String? rating;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: height,
        width: width,
        margin: EdgeInsets.only(right: isList! ? index != total-1 ? Get.height * 0.015 : 0 : 0),
        child: Stack(
          children: [
            _movieItemThumbnail(),
            _movieItemRating()
          ],
        ),
      ),
    );
  }

  Widget _movieItemThumbnail(){
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(thumbnail!),
              fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(20)
      ),
    );
  }

  Widget _movieItemRating(){
    return Positioned(
      child: Container(
        width: Get.height * 0.04,
        height: Get.height * 0.03,
        decoration: BoxDecoration(
            color: Color(0xFFe21221),
            borderRadius: BorderRadius.circular(6)
        ),
        child: Center(
          child: Text(
            rating!,
            style: GoogleFonts.urbanist(fontSize: 12),
          ),
        ),
      ),
      top: Get.height * 0.015,
      left: Get.height * 0.015,
    );
  }
}