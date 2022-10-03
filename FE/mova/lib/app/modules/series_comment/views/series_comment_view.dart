import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/modules/series_comment/controllers/series_comment_controller.dart';
import 'package:mova/app/utils/constant.dart';
import 'package:mova/app/widget/loading.dart';

import '../../../models/comment_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class SeriesCommentView extends GetView<SeriesCommentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
            future: controller.getAllComment(context, Get.arguments),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                return Obx((){
                  return controller.loading.value
                      ? _onLoading(context)
                      : _commentView(context);
                });
              }
              return Loading();
            },
          )
      ),
    );
  }

  Widget _onLoading(BuildContext context){
    return Stack(
      children: [
        _commentView(context),
        Container(
          width: Get.width,
          height: Get.height,
          color: Colors.black.withOpacity(0.8),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }

  Widget _commentView(BuildContext context){
    return Container(
      padding: EdgeInsets.all(Get.height * 0.02),
      child: Column(
        children: [
          _commentHeader(),
          SizedBox(height: Get.height * 0.02,),
          _commentBody(),
          SizedBox(height: Get.height * 0.02,),
          _commentForm(context)
        ],
      ),
    );
  }

  Widget _commentHeader(){
    return Container(
      width: Get.width,
      height: Get.height * 0.04,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _commentHeaderBack(),
          SizedBox(width: Get.height * 0.02,),
          _commentHeaderText()
        ],
      ),
    );
  }

  Widget _commentHeaderBack(){
    return InkWell(
      onTap: () {
        Get.back();
      },
      borderRadius: BorderRadius.circular(100),
      child: Icon(
        LineIcons.arrowLeft,
        color: Colors.white,
      ),
    );
  }

  Widget _commentHeaderText(){
    return AutoSizeText(
      "${controller.total.value} Comments",
      style: GoogleFonts.urbanist(
          fontSize: 22, fontWeight: FontWeight.w700),
      maxLines: 1,
    );
  }

  Widget _commentBody(){
    return Expanded(
        child: ListView.builder(
            itemCount: controller.total.value,
            itemBuilder: (context, index){
              var data = controller.modelC.comments.value.data![index];
              return _commentItem(index, data);
            }
        )
    );
  }

  Widget _commentItem(int index, Datum data){
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(bottom: index == 9 ? Get.height * 0.01 : Get.height * 0.025, top: index == 0 ? Get.height * 0.01 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _commentItemHeader(data),
          SizedBox(height: Get.height * 0.01,),
          _commentItemBody(data),
          SizedBox(height: Get.height * 0.01,),
          _commentItemFooter(index, data)
        ],
      ),
    );
  }

  Widget _commentItemHeader(Datum data){
    return Row(
      children: [
        _commentItemHeaderPhoto(data.picture!),
        SizedBox(width: Get.height * 0.01,),
        Container(
          child: Text(
            data.username!,
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

  Widget _commentItemHeaderPhoto(Picture picture){
    if(picture.valid!){
      return CircleAvatar(
        backgroundImage: NetworkImage("${Constant.baseUrl}/${picture.string!}"),
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

  Widget _commentItemBody(Datum data){
    return Text(
      data.comment!,
      style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 14),
      textAlign: TextAlign.justify,
    );
  }

  Widget _commentItemFooter(int index, Datum data){
    return Row(
      children: [
        InkWell(
          onTap: (){},
          borderRadius: BorderRadius.circular(200),
          child: Icon(
            index % 2 == 0 ? LineIcons.heartAlt : LineIcons.heart,
            color: index % 2 == 0 ? Color(0xFFed2533) : Colors.white,
          ),
        ),
        SizedBox(width: Get.height * 0.01,),
        Text(
          "999",
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        SizedBox(width: Get.height * 0.025,),
        Text(
          timeago.format(data.createdAt!,locale: 'id'),
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFFb9babb)),
        ),
      ],
    );
  }

  Widget _commentForm(BuildContext context){
    return Container(
      width: Get.width,
      height: Get.height * 0.06,
      child: Row(
        children: [
          _commentFormText(),
          SizedBox(width: Get.height * 0.01,),
          _commentFormButton(context)
        ],
      ),
    );
  }

  Widget _commentFormText(){
    return Expanded(
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFF1f222a),
            hintText: "Add comment",
            hintStyle: GoogleFonts.urbanist(color: Color(0xFF9d9d9d)),
            prefixIcon: Icon(
              Icons.emoji_emotions,
              color: Color(0xFF9d9d9d),
            ),
            contentPadding: EdgeInsets.only(top: Get.height * 0.012637867647058824),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          controller: controller.comment,
          keyboardAppearance: Brightness.dark,
        )
    );
  }

  Widget _commentFormButton(BuildContext context){
    return GestureDetector(
      onTap: (){
        if(controller.comment.text != ""){
          controller.addComment(context, Get.arguments);
        }
      },
      child: CircleAvatar(
        backgroundColor: Color(0xFFf4313f),
        child: Icon(
          Icons.send,
          color: Colors.white,
        ),
        radius: Get.height * 0.030330882352941176,
      ),
    );
  }
}
