import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Info extends StatelessWidget {
  const Info({
    Key? key,
    required this.info
  }) : super(key: key);

  final String? info;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Color(0xFFe21221))
      ),
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.00505514705882353,horizontal: Get.height * 0.012637867647058824),
      child: Center(
        child: Text(
            info!,
            style: GoogleFonts.urbanist(color: Color(0xFFe21221), fontSize: 14)
        ),
      ),
    );
  }
}