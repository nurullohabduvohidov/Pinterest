import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinterest/pages/profile_page.dart';
import 'package:pinterest/services/pinterest_service.dart';

import 'comment_page.dart';


class SearchPage extends StatefulWidget {
  static String id = "SearchPage";
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ScrollController _scrollController = ScrollController();
  List pinterestList = [];
  bool isLoadMore = false;
  TextEditingController textEditingController = TextEditingController();


  void searchCategory(String category){
    setState(() {
      isLoadMore = true;
    });
    PinterestHttp.GET(PinterestHttp.API_SEARCH_PHOTO, PinterestHttp.paramsSearch(category, (pinterestList.length~/10)+1)).then((value) => {
      pinterestList.addAll(List.from(PinterestHttp.parseSelectPage(value!))),
      setState(() {
        isLoadMore = false;
      }),
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom:PreferredSize(
          preferredSize: Size.fromHeight(-8),
          child: Padding(
            padding:  const EdgeInsets.only(left: 8,right: 8,bottom: 5),
            child: Container(
              height: 35,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade200,
              ),
              child: TextField(
                controller: textEditingController,
                onSubmitted: (text){
                  setState(() {
                    pinterestList.clear();
                    textEditingController.text = text.trim();
                    searchCategory(text.trim().toString());
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Search for ideas",
                  contentPadding: EdgeInsets.only(left: 20,bottom: 10),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search,color:Colors.black,),
                  suffixIcon: const Icon(FontAwesomeIcons.camera,color: Colors.black,)
                ),
              ),
            ),
          ),

        )
      ),
      body: (pinterestList.isNotEmpty) ?
      Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo){
              if(!isLoadMore && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent){
                searchCategory(textEditingController.text);
                setState(() {});
              }
              return true;
            },


              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: MasonryGridView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  gridDelegate:const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: pinterestList.length,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 8,),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(18.0),
                            child: CachedNetworkImage(
                              placeholder: (context,url) => Image.asset("assets/images/notFound.jpg"),
                              imageUrl: pinterestList[index].urls!.regular!,
                              errorWidget: (context,url,error)=>Image.asset("assets/images/notFound.jpg"),

                            )
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                pinterestList[index].description != null ? Container(
                                    width: 140,
                                    child: Text(pinterestList[index].description!,maxLines: 2,overflow: TextOverflow.ellipsis,)):
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(pinterestList[index].urls!.regular!)
                                      )
                                  ),
                                )
                              ],
                            ),
                            Icon(Icons.more_horiz,color: Colors.black,)

                          ],
                        ),
                      ],
                    );
                  },

                ),
              ),
          )
        ],
      ) : null,
    );
  }
}

