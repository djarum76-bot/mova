import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:mova/app/models/movie_model.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/widget/app_button.dart';
import 'package:mova/app/widget/comment_item.dart';
import 'package:mova/app/widget/error_message.dart';
import 'package:mova/app/widget/info.dart';
import 'package:mova/app/widget/more_like_this_item.dart';
import 'package:mova/app/widget/movies_item.dart';
import 'package:mova/app/widget/no_data_found.dart';
import 'package:mova/app/widget/search_button.dart';
import 'package:mova/app/widget/share_social_button.dart';
import 'package:mova/app/widget/slider_rating.dart';
import 'package:mova/app/widget/trailer_item.dart';
import 'package:readmore/readmore.dart';

import '../controllers/movie_detail_controller.dart';

class MovieDetailView extends GetView<MovieDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              _body(context),
              _header()
            ],
          )
      ),
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
        decoration: const BoxDecoration(
            shape: BoxShape.circle
        ),
        child: const Icon(
          LineIcons.arrowLeft,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _body(BuildContext context){
    return FutureBuilder(
      future: controller.getMovieDetail(context, Get.arguments),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          var data = controller.modelC.movie.value.data!;
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
              image: NetworkImage("${Constant.baseUrl}/"+data.thumbnail!),
              fit: BoxFit.cover
          )
      ),
    );
  }

  Widget _bodyContent(BuildContext context, Data data){
    return Container(
      padding: EdgeInsets.fromLTRB(Get.height * 0.02, Get.height * 0.02, Get.height * 0.02, Get.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bodyContentTitleFavoriteShare(context, data),
          SizedBox(height: Get.height * 0.02,),
          _bodyContentRatingInfo(context, data),
          _playAndDownloadButton(context, data),
          _bodyContentGenre(data),
          SizedBox(height: Get.height * 0.0125,),
          _bodyContentDescription(data),
          SizedBox(height: Get.height * 0.02,),
          _bodyContentTabBar(context, data)
        ],
      ),
    );
  }

  Widget _bodyContentTitleFavoriteShare(BuildContext context, Data data){
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
                _bodyContentFavorite(data, context),
                SizedBox(width: Get.height * 0.015,),
                _bodyContentShareButton(context),
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
          "${data.title}",
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 22),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
      ),
    );
  }

  Widget _bodyContentFavorite(Data data, BuildContext context){
    return Obx((){
      return controller.loadingFavorite.value
          ? CircularProgressIndicator()
          : _bodyContentFavoriteButton(data, context);
    });
  }

  Widget _bodyContentFavoriteButton(Data data, BuildContext context){
    return InkWell(
      child: Container(
        width: Get.height * 0.03,
        height: Get.height * 0.03,
        decoration: const BoxDecoration(
            shape: BoxShape.circle
        ),
        child: Obx((){
          return Icon(
            controller.isFavorite.value ? Icons.favorite : Icons.favorite_border,
            color: Colors.white,
            size: Get.height * 0.03,
          );
        }),
      ),
      onTap: (){
        if(controller.isFavorite.value){
          controller.deleteFavorite(context, controller.favoriteId.value);
        }else{
          controller.addFavorite(context, data.filmId!, data.thumbnail!, data.title!, data.rating!, data.category!, Constant.movie);
        }
      },
      borderRadius: BorderRadius.circular(200),
    );
  }

  Widget _bodyContentShareButton(BuildContext context){
    return InkWell(
      child: Container(
        width: Get.height * 0.03,
        height: Get.height * 0.03,
        decoration: const BoxDecoration(
            shape: BoxShape.circle
        ),
        child: Icon(
          LineIcons.share,
          color: Colors.white,
          size: Get.height * 0.03,
        ),
      ),
      onTap: (){
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
          Text(
              "${data.release}",
              style: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w500)
          ),
          SizedBox(width: Get.height * 0.01,),
          Info(info: "${data.region}"),
          SizedBox(width: Get.height * 0.01,),
          Info(info: "${data.category}"),
        ],
      ),
    );
  }

  Widget _ratingButton(BuildContext context, Data data){
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: (){
        _ratingDialog(context);
      },
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: const Color(0xFFe21221),
            size: Get.height * 0.025275735294117647,
          ),
          SizedBox(width: Get.height * 0.01,),
          Text(
              "${data.rating! * 2}",
              style: GoogleFonts.urbanist(color: const Color(0xFFe21221), fontSize: 15)
          ),
          SizedBox(width: Get.height * 0.01,),
          Icon(
            LineIcons.angleRight,
            color: const Color(0xFFe21221),
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
          _downloadButton(context, data),
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
                Get.toNamed(Routes.VIDEO_PLAY, arguments: "${Constant.baseUrl}/"+data.url!);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(LineIcons.playCircleAlt),
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

  Widget _downloadButton(BuildContext context, Data data){
    return Expanded(
        flex: 1,
        child: SizedBox(
          height: Get.height * 0.05,
          child: AppButton(
              color: const Color(0xFF181a20),
              onPressed: () {
                ErrorMessage(context, "Not Available Yet");
              },
              side: const BorderSide(color: const Color(0xFFE21221), width: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(LineIcons.download, color: const Color(0xFFE21221),),
                  SizedBox(width: Get.height * 0.006,),
                  AutoSizeText(
                    "Download",
                    style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFFE21221)),
                    maxLines: 1,
                  )
                ],
              )
          ),
        )
    );
  }

  Widget _bodyContentGenre(Data data){
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
      '${data.description}',
      trimLines: 2,
      colorClickableText: Colors.pink,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Show more',
      trimExpandedText: 'Show less',
      moreStyle: GoogleFonts.urbanist(color: const Color(0xFFb21421), fontSize: 14),
      lessStyle: GoogleFonts.urbanist(color: const Color(0xFFb21421), fontSize: 14),
      textAlign: TextAlign.justify,
      style: GoogleFonts.urbanist(color: const Color(0xFFb6b6b7), fontSize: 14),
    );
  }

  Widget _bodyContentTabBar(BuildContext context, Data data){
    return Container(
      width: Get.width,
      height: Get.height * 0.2832,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            _bodyContentTabBarTitle(),
            _bodyContentTabBarContent(context, data),
          ],
        ),
      ),
    );
  }

  Widget _bodyContentTabBarTitle(){
    return Container(
      child: TabBar(
        indicatorColor: const Color(0xFFc81221),
        labelStyle: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFFc81221)),
        unselectedLabelStyle: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF5a5a5b)),
        unselectedLabelColor: const Color(0xFF5a5a5b),
        labelColor: const Color(0xFFc81221),
        tabs: [
          const Tab(text: 'More Like This'),
          const Tab(text: 'Comments'),
        ],
      ),
    );
  }

  Widget _bodyContentTabBarContent(BuildContext context, Data data){
    return Expanded(
      child: TabBarView(
        children: [
          _moreLikeThis(),
          Obx((){
            return _comments(context, data, controller.totalComment);
          }),
        ],
      ),
    );
  }

  Widget _moreLikeThis(){
    return GridView.builder(
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.65,
            crossAxisSpacing: Get.height * 0.012637867647058824,
            mainAxisSpacing: Get.height * 0.012637867647058824
        ),
        itemBuilder: (context, index){
          return MoreLikeThisItem(
              onPressed: (){
                if(index % 2 == 0){
                  Get.toNamed(Routes.MOVIE_DETAIL);
                }else{
                  Get.toNamed(Routes.SERIES_DETAIL);
                }
              },
              index: index
          );
        }
    );
  }

  Widget _comments(BuildContext context, Data data, Rx<int> totalComment){
    if(totalComment.value == 0){
      return NoDataFound(context);
    }else{
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index){
          var dataComment = controller.modelC.movie.value.data!.userComments![index];
          return CommentItem(
            index: index,
            onPressed: (){},
            filmId: data.filmId,
            total: totalComment.value,
            picture: dataComment.picture,
            username: dataComment.username,
            comment: dataComment.comment,
            createdAt: dataComment.createdAt,
          );
        },
      );
    }
  }
}