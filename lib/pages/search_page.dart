import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinterest/controller/search_controller.dart';
import 'package:pinterest/views/search_view.dart';
import 'package:pinterest/widgets/search_widget.dart';



class SearchPage extends StatelessWidget {
  static String id = "SearchPage";
  const SearchPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SearchController(),
        builder: (SearchController controller) => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: buildAppBar(controller),
          body: (controller.pinterestList.isNotEmpty) ?
          Stack(
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo){
                  if(!controller.isLoadMore && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent){
                    controller.searchCategory(controller.textEditingController.text);
                  }
                  return true;
                },


                child:SearchWidget(searchController: controller,),
              ),
            ],
          ) : Center(
            child:Lottie.asset("assets/animation/searching.json",height: 200.0,width: 200.0),
          ),
        )
    );
  }


}

