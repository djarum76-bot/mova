import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/models/top_1_model.dart';
import 'package:mova/app/modules/home/controllers/home_controller.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/widget/app_button.dart';

class Top1 extends GetView<HomeController> {
  const Top1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getTop1(context),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          var data = controller.modelC.top1.value.data;
          return _top1(context, data!);
        }
        return _loading();
      },
    );
  }

  Widget _top1(BuildContext context, Data data){
    return Container(
      width: Get.width,
      height: Get.height * 0.4,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage("${Constant.baseUrl}/"+data.thumbnail!),
              fit: BoxFit.cover
          )
      ),
      padding: EdgeInsets.all(Get.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _title(data),
          SizedBox(height: Get.height * 0.004,),
          _genre(data),
          _playMyListButton(context, data)
        ],
      ),
    );
  }

  Widget _title(Data data){
    return Text(
      "${data.title}",
      style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 28),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );
  }

  Widget _genre(Data data){
    return Text(
      controller.genre.value,
      style: GoogleFonts.urbanist(fontWeight: FontWeight.w400, fontSize: 14),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );
  }

  Widget _playMyListButton(BuildContext context, Data data){
    return Row(
      children: [
        _playButton(data),
        SizedBox(width: Get.height * 0.01,),
        Obx((){
          return controller.loadingFavorite.value
              ? CircularProgressIndicator()
              : _myListButton(context, data);
        })
      ],
    );
  }

  Widget _playButton(Data data){
    return AppButton(
        onPressed: (){
          Get.toNamed(Routes.VIDEO_PLAY, arguments: "${Constant.baseUrl}/"+data.url!);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(LineIcons.play),
            AutoSizeText(
              "Play",
              style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
              maxLines: 1,
            )
          ],
        )
    );
  }

  Widget _myListButton(BuildContext context, Data data){
    return AppButton(
        onPressed: (){
          if(controller.liked.value){
            controller.deleteFavorite(context, controller.favoriteId.value);
          }else{
            controller.addFavorite(context, data.id!, data.thumbnail!, data.title!, data.rating!, data.category!, data.tipe!);
          }
        },
        color: Colors.transparent,
        side: BorderSide(color: Colors.white, width: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx((){
              return Icon(controller.liked.value ? LineIcons.check : LineIcons.plus);
            }),
            AutoSizeText(
              "My List",
              style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
              maxLines: 1,
            )
          ],
        )
    );
  }

  Widget _loading(){
    return Container(
      width: Get.width,
      height: Get.height * 0.4,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}