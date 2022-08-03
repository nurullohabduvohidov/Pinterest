import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchWidget extends StatelessWidget {
  final searchController;
  const SearchWidget({Key? key,required this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: MasonryGridView.builder(
        shrinkWrap: true,
        controller: searchController.scrollController,
        gridDelegate:const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: searchController.pinterestList.length,
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
                    imageUrl: searchController.pinterestList[index].urls!.regular!,
                    errorWidget: (context,url,error)=>Image.asset("assets/images/notFound.jpg"),

                  )
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      searchController.pinterestList[index].description != null ? SizedBox(
                          width: 140,
                          child: Text(searchController.pinterestList[index].description!,maxLines: 2,overflow: TextOverflow.ellipsis,)):
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(searchController.pinterestList[index].urls!.regular!)
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
}
