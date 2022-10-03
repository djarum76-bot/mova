import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/widget/error_message.dart';
import 'package:mova/app/widget/subscribe_item.dart';

import '../controllers/subscribe_controller.dart';

class SubscribeView extends GetView<SubscribeController> {
  const SubscribeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _subscribeBody(context),
    );
  }

  Widget _subscribeBody(BuildContext context){
    return SafeArea(
        child: Container(
          padding: EdgeInsets.all(Get.height * 0.02),
          child: Column(
            children: [
              _subscribeBackButton(),
              SizedBox(height: Get.height * 0.04,),
              _subscribeOffer(context)
            ],
          ),
        )
    );
  }

  Widget _subscribeBackButton(){
    return Container(
      width: Get.width,
      height: Get.height * 0.04,
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          Get.back();
        },
        borderRadius: BorderRadius.circular(100),
        child: Icon(
          LineIcons.arrowLeft,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _subscribeOffer(BuildContext context){
    return Expanded(
      child: ListView(
        children: [
          Align(
            alignment: Alignment.center,
            child: AutoSizeText(
              "Subscribe to Premium",
              style: GoogleFonts.urbanist(fontSize: 30, fontWeight: FontWeight.w700, color: Color(0xFFe21221)),
              maxLines: 1,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AutoSizeText(
              "Enjoy watching Full-HD movies, without restrictions and without ads",
              style: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: Get.height * 0.02,),
          SubscribeItem(
              onPressed: (){
                controller.subscribe(context, "001", "130000", "Paket 1 Bulan");
              },
              price: "\$9.9 ",
              time: "/month"
          ),
          SizedBox(height: Get.height * 0.02,),
          SubscribeItem(
              onPressed: (){
                controller.subscribe(context, "001", "1300000", "Paket 1 Tahun");
              },
              price: "\$99.9 ",
              time: "/year"
          ),
        ],
      ),
    );
  }
}


