import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mova/app/modules/explore/controllers/explore_controller.dart';
import 'package:mova/app/routes/app_pages.dart';
import 'package:mova/app/widget/app_button.dart';

class ExploreHead extends GetView<ExploreController> {
  const ExploreHead({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Container(
        width: Get.width,
        height: controller.sortFilterList.value.isEmpty ? Get.height * 0.08 : Get.height * 0.13,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchFilterButton(),
            Obx((){
              return controller.sortFilterList.value.isEmpty
                  ? SizedBox()
                  : _filterChip();
            })
          ],
        ),
      );
    });
  }

  Widget _searchFilterButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _search(),
        SizedBox(width: Get.height * 0.01,),
        _filterButton()
      ],
    );
  }

  Widget _search(){
    return Expanded(
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFF1f222a),
            hintText: "Search",
            hintStyle: GoogleFonts.urbanist(color: Color(0xFF9d9d9d)),
            prefixIcon: Icon(
              LineIcons.search,
              color: Color(0xFF9d9d9d),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          controller: controller.search,
          keyboardAppearance: Brightness.dark,
          onTap: (){
            Get.toNamed(Routes.SEARCH);
          },
          readOnly: true,
        )
    );
  }

  Widget _filterButton(){
    return InkWell(
      onTap: (){
        _sortFilter();
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: Get.height * 0.0725,
        height: Get.height * 0.0725,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xFF281920)
        ),
        child: Center(
          child: Icon(
            LineIcons.filter,
            size: 30,
            color: Color(0xFFe21221),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _sortFilter(){
    return Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(Get.height * 0.02),
        height: Get.height,
        decoration: BoxDecoration(
            color: Color(0xFF1f222a),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )
        ),
        child: Column(
          children: [
            _bottomSheetFilterChip(),
            _bottomSheetButton()
          ],
        ),
      ),
    );
  }

  Widget _bottomSheetFilterChip(){
    return Expanded(
        child: Scrollbar(
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: AutoSizeText(
                  "Sort & Filter",
                  style: GoogleFonts.urbanist(color: Color(0xFFec5253), fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
              SizedBox(height: Get.height * 0.02,),
              Divider(
                color: Color(0xFF30333b),
                thickness: 2,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.02,),
                    AutoSizeText(
                      "Categories",
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    SizedBox(height: Get.height * 0.02,),
                    Container(
                      width: Get.width,
                      height: Get.height * 0.05,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _buildCategoriesChip(),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.02,),
                    AutoSizeText(
                      "Regions",
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    SizedBox(height: Get.height * 0.02,),
                    Container(
                      width: Get.width,
                      height: Get.height * 0.05,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _buildRegionsChip(),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.02,),
                    AutoSizeText(
                      "Genre",
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    SizedBox(height: Get.height * 0.02,),
                    Container(
                      width: Get.width,
                      height: Get.height * 0.05,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _buildGenreChip(),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.02,),
                    AutoSizeText(
                      "Time/Periods",
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    SizedBox(height: Get.height * 0.02,),
                    Container(
                      width: Get.width,
                      height: Get.height * 0.05,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _buildTimePeriodChip(),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: Get.height * 0.02)
              )
            ],
          ),
        )
    );
  }

  Widget _bottomSheetButton(){
    return Container(
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
                    color: Color(0xFF35383f),
                    onPressed: () {
                      controller.selectedCategory.value = "";
                      controller.selectedRegion.value = "";
                      controller.selectedGenre.value = "";
                      controller.selectedTimePeriod.value = "";
                      controller.selectedSort.value = "";
                      controller.sortFilterList.clear();
                      controller.sortFilterList.refresh();
                      Get.back();
                    },
                    child: AutoSizeText(
                      "Reset",
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
                      if(controller.sortFilterList.value.isNotEmpty){
                        controller.sortFilterList.clear();
                        controller.sortFilterList.refresh();
                      }
                      controller.sortFilterList.value.add(controller.selectedCategory.value);
                      controller.sortFilterList.value.add(controller.selectedRegion.value);
                      controller.sortFilterList.value.add(controller.selectedGenre.value);
                      controller.sortFilterList.value.add(controller.selectedTimePeriod.value);
                      controller.sortFilterList.value.add(controller.selectedSort.value);
                      controller.sortFilterList.value.removeWhere((element) => element == "");
                      controller.sortFilterList.refresh();
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
    );
  }

  _buildCategoriesChip() {
    List<Widget> choices = [];

    controller.categoryList.forEach((item) {
      choices.add(
          Obx(() {
            return Container(
              margin: EdgeInsets.only(left: Get.height * 0.01),
              child: ChoiceChip(
                label: AutoSizeText(item, maxLines: 1,),
                labelStyle: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700, color: controller.selectedCategory.value == item ? Colors.white : Color(0xFFE21221)),
                selected: controller.selectedCategory.value == item,
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.017913602941176475),
                labelPadding: EdgeInsets.symmetric(vertical: Get.height * 0.000527573529411765),
                selectedColor: Color(0xFFE21221),
                backgroundColor: Colors.black,
                side: BorderSide(color: Color(0xFFE21221)),
                onSelected: (selected) {
                  controller.selectedCategory.value = item;
                },
              ),
            );
          })
      );
    });

    return choices;
  }

  _buildRegionsChip() {
    List<Widget> choices = [];

    controller.regionList.forEach((item) {
      choices.add(
          Obx(() {
            return Container(
              margin: EdgeInsets.only(left: Get.height * 0.01),
              child: ChoiceChip(
                label: AutoSizeText(item, maxLines: 1,),
                labelStyle: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700, color: controller.selectedRegion.value == item ? Colors.white : Color(0xFFE21221)),
                selected: controller.selectedRegion.value == item,
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.017913602941176475),
                labelPadding: EdgeInsets.symmetric(vertical: Get.height * 0.000527573529411765),
                selectedColor: Color(0xFFE21221),
                backgroundColor: Colors.black,
                side: BorderSide(color: Color(0xFFE21221)),
                onSelected: (selected) {
                  controller.selectedRegion.value = item;
                },
              ),
            );
          })
      );
    });

    return choices;
  }

  _buildGenreChip() {
    List<Widget> choices = [];

    controller.genreList.forEach((item) {
      choices.add(
          Obx(() {
            return Container(
              margin: EdgeInsets.only(left: Get.height * 0.01),
              child: ChoiceChip(
                label: AutoSizeText(item, maxLines: 1,),
                labelStyle: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700, color: controller.selectedGenre.value == item ? Colors.white : Color(0xFFE21221)),
                selected: controller.selectedGenre.value == item,
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.017913602941176475),
                labelPadding: EdgeInsets.symmetric(vertical: Get.height * 0.000527573529411765),
                selectedColor: Color(0xFFE21221),
                backgroundColor: Colors.black,
                side: BorderSide(color: Color(0xFFE21221)),
                onSelected: (selected) {
                  controller.selectedGenre.value = item;
                },
              ),
            );
          })
      );
    });

    return choices;
  }

  _buildTimePeriodChip() {
    List<Widget> choices = [];

    controller.timePeriodList.forEach((item) {
      choices.add(
          Obx(() {
            return Container(
              margin: EdgeInsets.only(left: Get.height * 0.01),
              child: ChoiceChip(
                label: AutoSizeText(item, maxLines: 1,),
                labelStyle: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700, color: controller.selectedTimePeriod.value == item ? Colors.white : Color(0xFFE21221)),
                selected: controller.selectedTimePeriod.value == item,
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.017913602941176475),
                labelPadding: EdgeInsets.symmetric(vertical: Get.height * 0.000527573529411765),
                selectedColor: Color(0xFFE21221),
                backgroundColor: Colors.black,
                side: BorderSide(color: Color(0xFFE21221)),
                onSelected: (selected) {
                  controller.selectedTimePeriod.value = item;
                },
              ),
            );
          })
      );
    });

    return choices;
  }

  Widget _filterChip(){
    return Container(
      width: Get.width,
      height: Get.height * 0.045,
      child: ListView.builder(
          itemCount: controller.sortFilterList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            return Container(
              margin: EdgeInsets.only(left: Get.height * 0.01),
              child: ChoiceChip(
                label: AutoSizeText(controller.sortFilterList.value[index], maxLines: 1,),
                labelStyle: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                selected: controller.sortFilterList.value.contains(controller.sortFilterList.value[index]),
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.017913602941176475),
                labelPadding: EdgeInsets.symmetric(vertical: Get.height * 0.000527573529411765),
                selectedColor: Color(0xFFE21221),
                backgroundColor: Colors.black,
                side: BorderSide(color: Color(0xFFE21221)),
                onSelected: (selected) {
                },
              ),
            );
          }
      ),
    );
  }
}