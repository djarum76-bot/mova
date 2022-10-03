import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/models/movie_model.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentItem extends StatelessWidget {
  const CommentItem({
    Key? key,
    required this.index,
    required this.filmId,
    required this.onPressed,
    required this.total,
    required this.picture,
    required this.username,
    required this.comment,
    required this.createdAt,
  }) : super(key: key);

  final int? index;
  final int? filmId;
  final void Function()? onPressed;
  final int? total;
  final Picture? picture;
  final String? username;
  final String? comment;
  final DateTime? createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(bottom: Get.height * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topComment(),
          _headerComment(),
          SizedBox(height: Get.height * 0.01,),
          _bodyComment(),
          SizedBox(height: Get.height * 0.01,),
          _footerComment()
        ],
      ),
    );
  }

  Widget _topComment(){
    if(index == 0){
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$total Comments",
              style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 22),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
            InkWell(
              onTap: (){
                Get.toNamed(Routes.MOVIE_COMMENT, arguments: filmId);
              },
              borderRadius: BorderRadius.circular(20),
              child: AutoSizeText(
                "See all",
                style: GoogleFonts.urbanist(fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xFFdf1221)),
                maxLines: 1,
              ),
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: Get.height * 0.02, top: Get.height * 0.01),
      );
    }else{
      return SizedBox();
    }
  }

  Widget _headerComment(){
    return Row(
      children: [
        CircleAvatar(
          child: _headerPhoto(),
          radius: Get.height * 0.025275735294117647,
        ),
        SizedBox(width: Get.height * 0.01,),
        Container(
          child: Text(
            username!,
            style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
          width: Get.height * 0.35,
        )
      ],
    );
  }

  Widget _headerPhoto(){
    if(picture!.valid!){
      return CircleAvatar(
        backgroundImage: NetworkImage("${Constant.baseUrl}/${picture!.string!}"),
        radius: Get.height * 0.025275735294117647,
      );
    }else{
      return CircleAvatar(
        child: Icon(
          LineIcons.user,
          size: Get.height * 0.03159466911764706,
        ),
        radius: Get.height * 0.025275735294117647,
      );
    }
  }

  Widget _bodyComment(){
    return Text(
      comment!,
      style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 14),
      textAlign: TextAlign.justify,
    );
  }

  Widget _footerComment(){
    return Row(
      children: [
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(200),
          child: Icon(
            index! % 2 == 0 ? LineIcons.heartAlt : LineIcons.heart,
            color: index! % 2 == 0 ? Color(0xFFed2533) : Colors.white,
          ),
        ),
        SizedBox(width: Get.height * 0.01,),
        Text(
          "999",
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        SizedBox(width: Get.height * 0.025,),
        Text(
          timeago.format(createdAt!,locale: 'id'),
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFFb9babb)),
        ),
      ],
    );
  }
}