import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/models/series_model.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:mova/app/widget/error_message.dart';
import 'package:mova/app/widget/info.dart';
import 'package:mova/app/widget/share_social_button.dart';
import 'package:mova/app/widget/slider_rating.dart';
import 'package:readmore/readmore.dart';

import '../controllers/series_detail_controller.dart';

class SeriesDetailView extends GetView<SeriesDetailController> {
  const SeriesDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _seriesDetail(context)
      ),
    );
  }

  Widget _seriesDetail(BuildContext context){
    return Stack(
      children: [
        _body(context),
        _header()
      ],
    );
  }

  Widget _header(){
    return Container(
      child: _headerBack(),
      padding: EdgeInsets.all(Get.height * 0.01),
    );
  }

  Widget _headerBack(){
    return InkWell(
      onTap: () {
        Get.back();
      },
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: Get.height * 0.05,
        height: Get.height * 0.05,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Icon(
          LineIcons.arrowLeft,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _body(BuildContext context){
    return FutureBuilder(
      future: controller.getSeriesDetail(context, Get.arguments),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          var data = controller.modelC.series.value.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                _bodyImage(data),
                _bodyContent(context, data)
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _bodyImage(Data data){
    return Container(
      width: Get.width,
      height: Get.height * 0.36,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage("${Constant.baseUrl}/${data.thumbnail}"),
              fit: BoxFit.cover
          )
      ),
    );
  }

  Widget _bodyContent(BuildContext context, Data data){
    return Container(
      padding: EdgeInsets.fromLTRB(Get.height * 0.02, Get.height * 0.02, Get.height * 0.02, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bodyContentTitleCommentFavoriteShare(context, data),
          SizedBox(height: Get.height * 0.02,),
          _bodyContentRatingInfo(context, data),
          _playAndDownloadButton(context, data),
          _bodyContentGenre(),
          SizedBox(height: Get.height * 0.0125,),
          _bodyContentDescription(data),
          SizedBox(height: Get.height * 0.02,),
          AutoSizeText(
            "Episodes",
            style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          SizedBox(height: Get.height * 0.01,),
          _bodyContentEpisode(context, data)
        ],
      ),
    );
  }

  Widget _bodyContentTitleCommentFavoriteShare(BuildContext context, Data data){
    return Container(
      width: Get.width,
      height: Get.height * 0.0325,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _bodyContentTitle(data),
          SizedBox(width: Get.height * 0.02,),
          Container(
            child: Row(
              children: [
                _bodyContentComment(data),
                SizedBox(width: Get.height * 0.015,),
                _bodyContentFavorite(context, data),
                SizedBox(width: Get.height * 0.015,),
                _bodyContentShare(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bodyContentTitle(Data data){
    return Expanded(
      child: Container(
        child: Text(
          data.title!,
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 22),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
      ),
    );
  }

  Widget _bodyContentComment(Data data){
    return InkWell(
      child: Container(
        width: Get.height * 0.03,
        height: Get.height * 0.03,
        decoration: BoxDecoration(
            shape: BoxShape.circle
        ),
        child: Icon(
          LineIcons.comment,
          color: Colors.white,
          size: Get.height * 0.03,
        ),
      ),
      onTap: () {
        Get.toNamed(Routes.SERIES_COMMENT, arguments: data.filmId);
      },
      borderRadius: BorderRadius.circular(200),
    );
  }

  Widget _bodyContentFavorite(BuildContext context, Data data){
    return Obx((){
      return controller.loadingFavorite.value
          ? CircularProgressIndicator()
          : _bodyContentFavoriteButton(context, data);
    });
  }

  Widget _bodyContentFavoriteButton(BuildContext context, Data data){
    return InkWell(
      child: Container(
        width: Get.height * 0.03,
        height: Get.height * 0.03,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Obx((){
          return Icon(
            controller.isFavorite.value ? Icons.favorite : Icons.favorite_border,
            color: Colors.white,
            size: Get.height * 0.03,
          );
        }),
      ),
      onTap: () {
        if(controller.isFavorite.value){
          controller.deleteFavorite(context, controller.favoriteId.value);
        }else{
          controller.addFavorite(context, data.filmId!, data.thumbnail!, data.title!, data.rating!, data.category!, Constant.series);
        }
      },
      borderRadius: BorderRadius.circular(200),
    );
  }

  Widget _bodyContentShare(BuildContext context){
    return InkWell(
      child: Container(
        width: Get.height * 0.03,
        height: Get.height * 0.03,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Icon(
          LineIcons.share,
          color: Colors.white,
          size: Get.height * 0.03,
        ),
      ),
      onTap: () {
        _shareDialog(context);
      },
      borderRadius: BorderRadius.circular(200),
    );
  }

  Future<dynamic> _shareDialog(BuildContext context){
    return Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(Get.height * 0.02),
        height: Get.height * 0.25,
        decoration: const BoxDecoration(
            color: const Color(0xFF1f222a),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: AutoSizeText(
                "Send to",
                style: GoogleFonts.urbanist(color: const Color(0xFFec5253), fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
            SizedBox(height: Get.height * 0.02,),
            const Divider(
              color: Color(0xFF30333b),
              thickness: 2,
            ),
            SizedBox(height: Get.height * 0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShareSocialButton(
                  label: "Twitter",
                  icon: LineIcons.twitter,
                  onPressed: (){
                    ErrorMessage(context, "Not Available Yet");
                  },
                  color: const Color(0xFF1da1f2),
                ),
                ShareSocialButton(
                  label: "Facebook",
                  icon: LineIcons.facebookF,
                  onPressed: (){
                    ErrorMessage(context, "Not Available Yet");
                  },
                  color: const Color(0xFF15a4fb),
                ),
                ShareSocialButton(
                  label: "WhatsApp",
                  icon: LineIcons.whatSApp,
                  onPressed: (){
                    ErrorMessage(context, "Not Available Yet");
                  },
                  color: const Color(0xFF41ea60),
                ),
                ShareSocialButton(
                  label: "Instagram",
                  icon: LineIcons.instagram,
                  onPressed: (){
                    ErrorMessage(context, "Not Available Yet");
                  },
                  color: Colors.pinkAccent,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _bodyContentRatingInfo(BuildContext context, Data data){
    return Container(
      width: Get.width,
      height: Get.height * 0.034,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ratingButton(context, data),
          SizedBox(width: Get.height * 0.01,),
          Text(data.release!, style: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w500)),
          SizedBox(width: Get.height * 0.01,),
          Info(info: data.region!),
          SizedBox(width: Get.height * 0.01,),
          Info(info: data.category!),
        ],
      ),
    );
  }

  Widget _ratingButton(BuildContext context, Data data){
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        _ratingDialog(context);
      },
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: Color(0xFFe21221),
            size: Get.height * 0.025275735294117647,
          ),
          SizedBox(width: Get.height * 0.01,),
          Text(
              "${data.rating!.toDouble() * 2}",
              style: GoogleFonts.urbanist(color: Color(0xFFe21221), fontSize: 15)
          ),
          SizedBox(width: Get.height * 0.01,),
          Icon(
            LineIcons.angleRight,
            color: Color(0xFFe21221),
            size: Get.height * 0.02022058823529412,
          ),
        ],
      ),
    );
  }

  Future<dynamic> _ratingDialog(BuildContext context){
    return Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(Get.height * 0.02),
        height: Get.height * 0.5,
        decoration: const BoxDecoration(
            color: Color(0xFF1f222a),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: AutoSizeText(
                      "Give Rating",
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02,),
                  const Divider(
                    color: Color(0xFF30333b),
                    thickness: 2,
                  ),
                  SizedBox(height: Get.height * 0.02,),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "9.8",
                                          style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 60)
                                      ),
                                      TextSpan(
                                          text: " /10",
                                          style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 20)
                                      )
                                    ]
                                )
                            ),
                            SizedBox(height: Get.height * 0.01,),
                            RatingBar.builder(
                              initialRating: 4.5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              tapOnlyMode: true,
                              itemSize: Get.height * 0.025275735294117647,
                              itemBuilder: (context, _) => const Icon(
                                LineIcons.starAlt,
                                color: Color(0xFFe21221),
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(height: Get.height * 0.01,),
                            Text(
                              "(24.534 users)",
                              style: GoogleFonts.urbanist(fontSize: 14, color: const Color(0xFFa0a1a4)),
                            )
                          ],
                        ),
                        SizedBox(width: Get.height * 0.01,),
                        const VerticalDivider(
                          color: const Color(0xFF30333b),
                          thickness: 2,
                        ),
                        SizedBox(width: Get.height * 0.01,),
                        Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SliderRating(value: 80, label: "5"),
                                  const SliderRating(value: 60, label: "4"),
                                  const SliderRating(value: 15, label: "3"),
                                  const SliderRating(value: 10, label: "2"),
                                  const SliderRating(value: 5, label: "1"),
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02,),
                  const Divider(
                    color: Color(0xFF30333b),
                    thickness: 2,
                  ),
                  SizedBox(height: Get.height * 0.02,),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: Get.height * 0.06318933823529412,
                    itemPadding: EdgeInsets.symmetric(horizontal: Get.height * 0.01),
                    itemBuilder: (context, _) => const Icon(
                      LineIcons.starAlt,
                      color: Color(0xFFe21221),
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  )
                ],
              ),
            ),
            Container(
              width: Get.width,
              height: Get.height * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: Get.height * 0.06,
                        child: AppButton(
                            color: const Color(0xFF35383f),
                            onPressed: () {
                              Get.back();
                            },
                            child: AutoSizeText(
                              "Cancel",
                              style: GoogleFonts.urbanist(fontSize: 16,
                                  fontWeight: FontWeight.w700),
                              maxLines: 1,
                            )
                        ),
                      )
                  ),
                  SizedBox(width: Get.height * 0.02,),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: Get.height * 0.06,
                        child: AppButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: AutoSizeText(
                              "Apply",
                              style: GoogleFonts.urbanist(fontSize: 16,
                                  fontWeight: FontWeight.w700),
                              maxLines: 1,
                            )
                        ),
                      )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _playAndDownloadButton(BuildContext context, Data data){
    return Container(
      width: Get.width,
      height: Get.height * 0.05,
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.025),
      child: Row(
        children: [
          _playButton(data),
          SizedBox(width: Get.height * 0.015,),
          _downloadButton(context),
        ],
      ),
    );
  }

  Widget _playButton(Data data){
    return Expanded(
        flex: 1,
        child: SizedBox(
          height: Get.height * 0.05,
          child: AppButton(
              onPressed: () {
                Get.toNamed(Routes.VIDEO_PLAY, arguments: "${Constant.baseUrl}/${data.episode![0]}");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LineIcons.playCircleAlt),
                  SizedBox(width: Get.height * 0.006,),
                  AutoSizeText(
                    "Play",
                    style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700),
                    maxLines: 1,
                  )
                ],
              )
          ),
        )
    );
  }

  Widget _downloadButton(BuildContext context){
    return Expanded(
        flex: 1,
        child: SizedBox(
          height: Get.height * 0.05,
          child: AppButton(
              color: Color(0xFF181a20),
              onPressed: () {
                ErrorMessage(context, "Not Available Yet");
              },
              side: BorderSide(color: Color(0xFFE21221), width: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    LineIcons.download,
                    color: Color(0xFFE21221),
                  ),
                  SizedBox(width: Get.height * 0.006,),
                  AutoSizeText(
                    "Download",
                    style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFFE21221)),
                    maxLines: 1,
                  )
                ],
              )
          ),
        )
    );
  }

  Widget _bodyContentGenre(){
    return Container(
      width: Get.width,
      height: Get.height * 0.023,
      child: Text(
        "Genre: ${controller.genre.value}",
        style: GoogleFonts.urbanist(fontSize: 15),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
    );
  }

  Widget _bodyContentDescription(Data data){
    return ReadMoreText(
      data.description!,
      trimLines: 3,
      colorClickableText: Colors.pink,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Show more',
      trimExpandedText: 'Show less',
      moreStyle: GoogleFonts.urbanist(color: Color(0xFFb21421), fontSize: 14),
      lessStyle: GoogleFonts.urbanist(color: Color(0xFFb21421), fontSize: 14),
      textAlign: TextAlign.justify,
      style: GoogleFonts.urbanist(color: Color(0xFFb6b6b7), fontSize: 14),
    );
  }

  Widget _bodyContentEpisode(BuildContext context, Data data){
    return Container(
      width: Get.width,
      height: Get.height * 0.14,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.episode!.length,
          itemBuilder: (context, index) {
            var dataEpisode = data.episode![index];
            return _bodyContentEpisodeItem(index, dataEpisode, data);
          }),
    );
  }

  Widget _bodyContentEpisodeItem(int index, String episode, Data data){
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.VIDEO_PLAY, arguments: "${Constant.baseUrl}/$episode");
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: Get.width * 0.4,
        height: Get.height,
        margin: EdgeInsets.only(right: index != data.episode!.length - 1 ? Get.height * 0.01 : 0),
        padding: EdgeInsets.all(Get.height * 0.015),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("${Constant.baseUrl}/${data.thumbnail}"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Center(
              child: Icon(
                Icons.play_circle_fill_outlined,
                color: Colors.white,
                size: Get.height * 0.050551470588235295,
              ),
            ),
            Positioned(
                bottom: 0,
                child: Text(
                  "Episode ${index + 1}",
                  style: GoogleFonts.urbanist(fontWeight: FontWeight.w600),
                )
            )
          ],
        ),
      ),
    );
  }
}
