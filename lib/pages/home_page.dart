import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pinterest/controller/home_controller.dart';
import 'package:pinterest/pages/detail_page.dart';
import 'package:pinterest/utils/classess.dart';
import 'package:pinterest/views/home_view.dart';

class HomePage extends StatelessWidget {
  static const String id = "HomePage";

  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        builder: (HomeController controller) => Scaffold(
          appBar: AppBar(
            elevation: 2,
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(5),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: ScrollPhysics(),
                    itemCount: UtilClass.text.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.searchFunction(index);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: controller.selected == index ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              UtilClass.text[index],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: controller.selected == index
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          body: controller.isLoading
              ? Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          )
              : Stack(
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!controller.isLoadMore &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    controller.searchCategory(controller.searchText);
                  }
                  return true;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: MasonryGridView.builder(
                    shrinkWrap: true,
                    controller:controller.scrollController,
                    gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: controller.pinterestList.length,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(18.0),
                                child: CachedNetworkImage(
                                  placeholder: (context, url) =>
                                      Image.asset("assets/images/notFound.jpg"),
                                  imageUrl: controller.pinterestList[index].urls!.regular!,
                                  errorWidget: (context, url, error) =>
                                      Image.asset("assets/images/notFound.jpg"),
                                )),
                            onTap: (){
                              controller.imagesPinterest = controller.pinterestList[index].urls!.regular!;
                              Get.to(DetailPage(pinterestPhoto: controller.imagesPinterest, pinterest: controller.pinterestList[index],));
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  controller.pinterestList[index].description != null
                                      ? SizedBox(
                                      width: 140,
                                      child: Text(
                                        controller.pinterestList[index].description!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                      : Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                controller.pinterestList[index]
                                                    .urls!
                                                    .regular!))),
                                  )
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    showMaterialModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          buildPadding(context,index,controller),
                                    );
                                  },
                                  child: Icon(
                                    Icons.more_horiz,
                                    color: Colors.black,
                                  ))
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              controller.isLoadMore ? Center(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Lottie.asset("assets/animation/lotti.json",width: 30,height: 30),
                ),
              ) : SizedBox.shrink()
            ],
          ),
        )
    );
  }




}
