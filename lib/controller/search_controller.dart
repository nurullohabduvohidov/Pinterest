import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/pinterest_service.dart';

class SearchController extends GetxController{
  final ScrollController scrollController = ScrollController();
  List pinterestList = [];
  bool isLoadMore = false;
  TextEditingController textEditingController = TextEditingController();


  void searchCategory(String category){
    isLoadMore = true;
    update();
    PinterestHttp.GET(PinterestHttp.API_SEARCH_PHOTO, PinterestHttp.paramsSearch(category, (pinterestList.length~/10)+1)).then((value) => {
      pinterestList.addAll(List.from(PinterestHttp.parseSelectPage(value!))),
    isLoadMore = false,
    update(),
    });
  }
}