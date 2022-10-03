import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mova/app/modules/home/controllers/home_controller.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/widget/loading.dart';
import 'package:mova/app/widget/movies_item.dart';

class NewReleases extends GetView<HomeController> {
  const NewReleases({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.3,
      child: Column(
        children: [
          _newReleasesHeader(),
          SizedBox(height: Get.height * 0.02,),
          _newReleasesBody(context)
        ],
      ),
    );
  }

  Widget _newReleasesHeader(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AutoSizeText(
          "New Releases",
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 24),
          maxLines: 1,
        ),
        InkWell(
          onTap: (){
            Get.toNamed(Routes.NEW_RELEASE);
          },
          borderRadius: BorderRadius.circular(20),
          child: AutoSizeText(
            "See all",
            style: GoogleFonts.urbanist(fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xFFdf1221)),
            maxLines: 1,
          ),
        )
      ],
    );
  }

  Widget _newReleasesBody(BuildContext context){
    return Expanded(
        child: FutureBuilder(
          future: controller.getNewReleases(context),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              return _newReleasesList();
            }
            return Loading();
          },
        )
    );
  }

  Widget _newReleasesList(){
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.lengthNewReleases.value,
        itemBuilder: (context, index){
          var data = controller.modelC.newReleases.value.data![index];
          return MoviesItem(
            index: index,
            total: controller.lengthNewReleases.value,
            onPressed: (){
              if(data.tipe == Constant.movie){
                Get.toNamed(Routes.MOVIE_DETAIL, arguments: data.id);
              }else{
                Get.toNamed(Routes.SERIES_DETAIL, arguments: data.id);
              }
            },
            width: Get.width * 0.35,
            height: Get.height,
            isList: true,
            thumbnail: "${Constant.baseUrl}/${data.thumbnail}",
            rating: data.rating == 0 ? "-" : "${(data.rating! * 2).toDouble()}",
          );
        }
    );
  }
}