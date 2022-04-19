import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinterest/controller/search_controller.dart';
import 'package:pinterest/views/search_view.dart';



class SearchPage extends StatefulWidget {
  static String id = "SearchPage";
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
 final getFind = Get.find<SearchController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SearchController(),
        builder: (SearchController controller) => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: buildAppBar(getFind),
          body: (getFind.pinterestList.isNotEmpty) ?
          Stack(
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo){
                  if(!getFind.isLoadMore && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent){
                    getFind.searchCategory(getFind.textEditingController.text);
                    setState(() {});
                  }
                  return true;
                },


                child:buildPaddingMasonry(getFind)
              ),
            ],
          ) : Center(
            child:Lottie.asset("assets/animation/searching.json",height: 200,width: 200) //Icon(Icons.search,color: Colors.black,),
          ),
        )
    );
  }


}

