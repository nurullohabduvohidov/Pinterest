import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinterest/models/pinterest.dart';
import 'package:pinterest/services/pinterest_service.dart';
import 'package:pinterest/utils/classess.dart';

class HomeController extends GetxController{
  bool isLoadMore = false;
  bool isLoading = true;
  int selected = 0;
  String imagesPinterest= "";
  List links = ['https://telegram.me/share/url?url=',"sms:?body=","mailto:?subject=Flutter&body="];
  List<Pinterest> pinterestList = [];
  List<Pinterest> list = [];
  final ScrollController scrollController = ScrollController();
  int pinterestListLength = 0;
  String searchText = "For You";
  dynamic snackBar;


  void dioGet(){
    PinterestHttp.GET(PinterestHttp.API_PHOTO_LIST, PinterestHttp.paramEmpty()).then((response) => {});
  }


  void save(int index) async {
    var status = await Permission.storage.request();
    if(status.isGranted) {
      var response = await Dio().get(
          pinterestList[index].urls!.regular!,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 100,
          name: DateTime.now().toString());
      update();
    }
  }


  void showSnackBar(){
    snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 50,
          width: MediaQuery.of(Get.context!).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.grey.shade800
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Image downloaded!", style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.3)),),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                    onTap: (){
                      if (kDebugMode) {
                        print("Image download");
                      }
                    },
                    child: const Text("Show", style: TextStyle(fontSize: 15, color: Colors.blue),)),
              ),
            ],
          ),
        ),
      ),
    );
  }

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    apiGetPinterest();
    dioGet();
  }

  void apiGetPinterest() {
    PinterestHttp.GET(PinterestHttp.API_PHOTO_LIST, PinterestHttp.paramEmpty())
        .then((value) => {
      pinterestList =
          List.from(PinterestHttp.parseUnsplashList(value!)),
      isLoading = false,
      update(),
    });
  }

  void searchCategory(String category) {
    isLoadMore = true;
    update();
    PinterestHttp.GET(
        PinterestHttp.API_SEARCH_PHOTO,
        PinterestHttp.paramsSearch(category, (pinterestList.length ~/ 10) + 1))
        .then((value) => {
      pinterestList
          .addAll(List.from(PinterestHttp.parseSelectPage(value!))),
    isLoadMore = false,
      update(),
    });
  }

  void searchFunction(int index){
    pinterestList.clear();
    searchText = UtilClass.text[index];
    searchCategory(UtilClass.text[index]);
    selected = index;
    update();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }
}