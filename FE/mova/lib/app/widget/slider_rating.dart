import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mova/app/widget/custom_track_shape.dart';

class SliderRating extends StatelessWidget {
  const SliderRating({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  final double? value;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.02,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            label!,
            style: GoogleFonts.urbanist(),
          ),
          SizedBox(width: Get.height * 0.01,),
          Container(
            child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                    trackShape: CustomTrackShape()
                ),
                child: Slider(
                  min: 0,
                  max: 100,
                  value: value!,
                  onChanged: (val){},
                )
            ),
          )
        ],
      ),
    );
  }
}