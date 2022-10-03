import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

NoDataFound(BuildContext context){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Lottie.asset("asset/lottie/404.json"),
      AutoSizeText(
        "Sorry, the keyword you entered could not be found. Try to check again or search with other keywords.",
        style: GoogleFonts.urbanist(fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
        maxLines: 3,
      )
    ],
  );
}