import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:mova/app/utils/constant.dart';

import '../controllers/interest_controller.dart';

class InterestView extends GetView<InterestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(Get.height * 0.02),
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * 0.04,
                  child: AutoSizeText(
                    "Choose Your Interest",
                    style: GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.w700),
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: Get.height * 0.04,),
                Expanded(
                    child: Container(
                      child: ListView(
                        children: [
                          AutoSizeText(
                              "Choose your interest and get the best movie recommendations. Don't worry, you can always change it later",
                              style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                              maxLines: 3,
                          ),
                          SizedBox(height: Get.height * 0.02,),
                          Wrap(
                            children: _buildChip(),
                          )
                        ],
                      ),
                    )
                ),
                SizedBox(height: Get.height * 0.02,),
                Container(
                  width: Get.width,
                  height: Get.height * 0.06,
                  child: AppButton(
                      onPressed: () {
                        if(controller.selected.isEmpty){
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.SCALE,
                            dialogType: DialogType.ERROR,
                            dialogBackgroundColor: Color(0xFF1f222a),
                            dialogBorderRadius: BorderRadius.circular(16),
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  "Choose at least one",
                                  style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                                  maxLines: 1,
                                ),
                                SizedBox(height: Get.height * 0.03,),
                              ],
                            ),
                          )..show();
                        }else{
                          box.write(Constant.interest, controller.selected.value);
                          Get.toNamed(Routes.FILL_PROFILE,);
                        }
                      },
                      child: AutoSizeText(
                        "Continue",
                        style: GoogleFonts.urbanist(fontSize: 16,
                            fontWeight: FontWeight.w700),
                        maxLines: 1,
                      )
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  _buildChip() {
    List<Widget> choices = [];

    controller.genreList.forEach((item) {
      choices.add(
          Obx(() {
            return Container(
              margin: EdgeInsets.only(left: Get.height * 0.007),
              child: ChoiceChip(
                label: AutoSizeText(item, maxLines: 1,),
                labelStyle: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700, color: controller.selected.contains(item) ? Colors.white : Color(0xFFE21221)),
                selected: controller.selected.contains(item),
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.037913602941176475),
                labelPadding: EdgeInsets.symmetric(vertical: Get.height * 0.002527573529411765),
                selectedColor: Color(0xFFE21221),
                backgroundColor: Colors.black,
                side: BorderSide(color: Color(0xFFE21221)),
                onSelected: (selected) {
                  if(selected){
                    controller.selected.add(item);
                  }else{
                    controller.selected.remove(item);
                  }
                },
              ),
            );
          })
      );
    });

    return choices;
  }
}
