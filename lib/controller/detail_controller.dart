import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinterest/models/pinterest.dart';
import 'package:pinterest/services/pinterest_service.dart';

class DetailController extends GetxController {
  bool isLoadMore = false;
  bool isLoading = true;
  int selected = 0;
  String imagesPinterest = "";
  List<Pinterest> pinterestList = [];
  final ScrollController scrollController = ScrollController();
  int pinterestListLength = 0;
  String searchText = "For You";

 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    apiGetPinterest();

 }

  void apiGetPinterest() {
    PinterestHttp.GET(PinterestHttp.API_PHOTO_LIST, PinterestHttp.paramEmpty())
        .then((value) => {
      pinterestList =
          List.from(PinterestHttp.parseUnsplashList(value!)),
      isLoading = false,
     update()
    });
  }

  void searchCategory(String category) {
    isLoadMore = true;
    update();
    PinterestHttp.GET(
        PinterestHttp.API_SEARCH_PHOTO,
        PinterestHttp.paramsSearch(
            category, (pinterestList.length ~/ 10) + 1))
        .then((value) => {
      pinterestList
          .addAll(List.from(PinterestHttp.parseSelectPage(value!))),
    isLoadMore = false,
      update(),
    });
  }

}