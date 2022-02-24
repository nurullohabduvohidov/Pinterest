import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinterest/models/pinterest.dart';
import 'package:pinterest/pages/detail_page.dart';
import 'package:pinterest/services/dio_httpservice.dart';
import 'package:pinterest/services/pinterest_service.dart';
import 'package:pinterest/utils/classess.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  static String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoadMore = false;
  bool _show = false;
  bool isLoading = true;
  int selected = 0;
  String imagesPinterest= "";
  static List links = ['https://telegram.me/share/url?url=',"sms:?body=","mailto:?subject=Flutter&body="];
  List<Pinterest> pinterestList = [];
  List<Pinterest> list = [];
  final ScrollController _scrollController = ScrollController();
  int pinterestListLength = 0;
  String searchText = "For You";


  void dioGet(){
    DioNetwork.GET(DioNetwork.API_PHOTO_LIST, DioNetwork.paramEmpty()).then((response) => {
      print("DIO $response"),
    });
  }

  //
  // void showDio(String response){
  //
  // }

  _save(int index) async {
    var status = await Permission.storage.request();
    if(status.isGranted) {
      var response = await Dio().get(
          pinterestList[index].urls!.regular!,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 100,
          name: DateTime.now().toString());
     // print("Hello success => $result");
      setState(() {

        _show = true;
      });
    }
  }
  dynamic snackBar;


  void _showSnackBar(){
    snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
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
  void initState() {
    super.initState();
    _apiGetPinterest();
    dioGet();
  }

  void _apiGetPinterest() {
    PinterestHttp.GET(PinterestHttp.API_PHOTO_LIST, PinterestHttp.paramEmpty())
        .then((value) => {
          pinterestList =
                  List.from(PinterestHttp.parseUnsplashList(value!)),
              isLoading = false,
              setState(() {}),
            });
  }


  // void isLoadingFunction() async{
  //   int pageNumber = (pinterestList.length~/pinterestListLength + 1);
  //   String? response = await PinterestHttp.GET(PinterestHttp.API_PHOTO_LIST, PinterestHttp.paramsPage(pageNumber));
  //   List<Pinterest> newPinterest = PinterestHttp.parseResponse(response!);
  //   pinterestList.addAll(newPinterest);
  //   setState(() {
  //     isLoadMore = false;
  //   });

  // }

  void searchCategory(String category) {
    setState(() {
      isLoadMore = true;
    });
    PinterestHttp.GET(
            PinterestHttp.API_SEARCH_PHOTO,
            PinterestHttp.paramsSearch(category, (pinterestList.length ~/ 10) + 1))
        .then((value) => {
              pinterestList
                  .addAll(List.from(PinterestHttp.parseSelectPage(value!))),
              setState(() {
                isLoadMore = false;
              }),
            });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
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
                      setState(() {
                        pinterestList.clear();
                        searchText = UtilClass.text[index];
                        searchCategory(UtilClass.text[index]);
                        selected = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected == index ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          UtilClass.text[index],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: selected == index
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            )
          : Stack(
              children: [
                NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!isLoadMore &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      searchCategory(searchText);
                      setState(() {});
                    }
                    return true;
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: MasonryGridView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: pinterestList.length,
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
                                    imageUrl: pinterestList[index].urls!.regular!,
                                    errorWidget: (context, url, error) =>
                                        Image.asset("assets/images/notFound.jpg"),
                                  )),
                              onTap: (){
                                imagesPinterest = pinterestList[index].urls!.regular!;
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DetailPage(pinterestPhoto: imagesPinterest, pinterest: pinterestList[index],)));
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
                                    pinterestList[index].description != null
                                        ? Container(
                                            width: 140,
                                            child: Text(
                                              pinterestList[index].description!,
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
                                                        pinterestList[index]
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
                                            buildPadding(context,index),
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
                isLoadMore ? Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Lottie.asset("assets/lotti.json",width: 30,height: 30),
                  ),
                ) : SizedBox.shrink()
              ],
            ),
    );
  }

  Padding buildPadding(BuildContext context,int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 20.0, bottom: 10.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: double.infinity,
        color: Colors.transparent,
        child: Column(
          children: [

            ///Icon/Text
            Row(
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.clear,
                    color: Colors.black87,
                    size: 35,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                    child: Text("Share to"),
                  onPressed: ()=> launch("tel:+998993169326"),
                )
              ],
            ),
            SizedBox(height: 15,),

            ///SEND
            Container(
              height: 119,
              // padding: EdgeInsets.only(left: 10, right: 20, top: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return bottomSheetFunction(index);
                },
                itemCount: UtilClass.bottomSheetPhoto.length,
              ),
            ),

            Divider(
              thickness: 0.5,
            ),

            ///DownLoad Image
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 10,top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      child: Text("Download Images",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                    onTap: (){
                        Navigator.of(context).pop();
                        _save(index);
                        showTopSnackBar(
                          context,
                          CustomSnackBar.info(
                            backgroundColor: Colors.grey.shade800,
                            message:
                            "Image downloaded!",
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          additionalTopPadding: 30,
                          displayDuration: const Duration(milliseconds: 800),
                          hideOutAnimationDuration: const Duration(milliseconds: 400),
                        );
                    },
                  ),
                  SizedBox(height: 17,),
                  GestureDetector(child: Text("Hide Pin",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                  SizedBox(height: 17,),
                  GestureDetector(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2,),
                      Text("Report Pin",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                      Text("This goes against Pinterest`s Community\nGuidelines"),

                    ],
                  )),
                ],
              ),
            ),

            SizedBox(height: 15,),
            ///This
           Divider(
             thickness: 0.5,
           ),
            Container(
              padding: EdgeInsets.only(top: 20,left: 10),
             alignment: Alignment.topLeft,
              child: Text("This Pin is inspired by your recent activity"),
            )
          ],
        ),
      ),
    );
  }

  Container bottomSheetFunction(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ///images
          Container(
            height: 65,
            width: 65,
            child: GestureDetector(
              onTap: ()=> launch("${links[index]}${Uri.encodeComponent(pinterestList[index].urls!.regular!)}"),
              child: Container(
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(UtilClass.bottomSheetPhoto[index]),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          ///text
          Text(
            UtilClass.bottomSheetText[index],
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
