import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mova/app/modules/home/controllers/home_controller.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/widget/loading.dart';
import 'package:mova/app/widget/movies_item.dart';

class Top10Movies extends GetView<HomeController> {
  const Top10Movies({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.3,
      child: Column(
        children: [
          _top10Header(),
          SizedBox(height: Get.height * 0.02,),
          _top10Body(context)
        ],
      ),
    );
  }

  Widget _top10Header(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AutoSizeText(
          "Top 10 Movies This Week",
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 24),
          maxLines: 1,
        ),
        InkWell(
          onTap: (){
            Get.toNamed(Routes.TOP_10);
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

  Widget _top10Body(BuildContext context){
    return Expanded(
        child: FutureBuilder(
          future: controller.getTop10Movie(context),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              return _top10List();
            }
            return Loading();
          },
        )
    );
  }

  Widget _top10List(){
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.lengthTop10Movie.value,
        itemBuilder: (context, index){
          var data = controller.modelC.movies.value.data![index];
          return MoviesItem(
            index: index,
            total: controller.lengthTop10Movie.value,
            onPressed: (){
              Get.toNamed(Routes.MOVIE_DETAIL, arguments: controller.modelC.movies.value.data![index].id);
            },
            width: Get.width * 0.35,
            height: Get.height,
            isList: true,
            rating: data.rating == 0 ? "-" : "${(data.rating! * 2).toDouble()}",
            thumbnail: "${Constant.baseUrl}/" + controller.modelC.movies.value.data![index].thumbnail!,
          );
        }
    );
  }
}