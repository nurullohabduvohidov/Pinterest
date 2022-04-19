import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar buildAppBar(final getFind) {
  return AppBar(
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
              controller: getFind.textEditingController,
              onSubmitted: (text){
                getFind.pinterestList.clear();
                getFind.textEditingController.text = text.trim();
                getFind.searchCategory(text.trim().toString());
                getFind.update();
              },
              decoration: const InputDecoration(
                  hintText: "Search for ideas",
                  contentPadding: EdgeInsets.only(left: 20,bottom: 10),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search,color:Colors.black,),
                  suffixIcon: Icon(FontAwesomeIcons.camera,color: Colors.black,)
              ),
            ),
          ),
        ),

      )
  );
}
Widget buildPaddingMasonry(final getFind) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: MasonryGridView.builder(
      shrinkWrap: true,
      controller: getFind.scrollController,
      gridDelegate:const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: getFind.pinterestList.length,
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
                  imageUrl: getFind.pinterestList[index].urls!.regular!,
                  errorWidget: (context,url,error)=>Image.asset("assets/images/notFound.jpg"),

                )
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    getFind.pinterestList[index].description != null ? SizedBox(
                        width: 140,
                        child: Text(getFind.pinterestList[index].description!,maxLines: 2,overflow: TextOverflow.ellipsis,)):
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(getFind.pinterestList[index].urls!.regular!)
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
  );
}