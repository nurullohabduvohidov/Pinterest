import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pinterest/models/pinterest.dart';
import 'package:pinterest/services/pinterest_service.dart';

class CommentController extends GetxController{
  List<Pinterest> note = [];
  List<Pinterest> imageList = [];
  bool isLoadMore = false;
  bool isLoading = false;
  int count = 10;
  
  late int pageIndex = 0;

  Future<void> random() async {
    isLoading = true;
    update();
    String? response = await PinterestHttp.GET(PinterestHttp.API_TODO_LIST_RANDOM, PinterestHttp.randomPage(count));
    List<Pinterest> list = PinterestHttp.parseResponse(response!);
    note.addAll(list);
    isLoading = false;
    if (kDebugMode) {
      print("Length => ${list.length}");
    }
    update();
  }

  Future<void> randomBasicImage(int countImage) async {
    String? response = await PinterestHttp.GET(PinterestHttp.API_TODO_LIST_RANDOM, PinterestHttp.randomPage(countImage));
    List<Pinterest> list = PinterestHttp.parseResponse(response!);
    imageList.clear();
    imageList.addAll(list);
    update();
  }

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    random();
  }
}