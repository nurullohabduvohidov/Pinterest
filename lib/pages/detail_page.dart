import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pinterest/models/pinterest.dart';
import 'package:pinterest/services/pinterest_service.dart';

class DetailPage extends StatefulWidget {
  static String id = "DetailPage";
  String pinterestPhoto;
  Pinterest pinterest;

  DetailPage({Key? key, required this.pinterestPhoto, required this.pinterest})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoadMore = false;
  bool isLoading = true;
  int selected = 0;
  String imagesPinterest = "";
  List<Pinterest> pinterestList = [];
  final ScrollController _scrollController = ScrollController();
  int pinterestListLength = 0;
  String searchText = "For You";

  @override
  void initState() {
    super.initState();
    _apiGetPinterest();
  }

  void _apiGetPinterest() {
    PinterestHttp.GET(PinterestHttp.API_PHOTO_LIST, PinterestHttp.paramEmpty())
        .then((value) => {
              print(value),
              pinterestList =
                  List.from(PinterestHttp.parseUnsplashList(value!)),
              isLoading = false,
              setState(() {}),
            });
  }

  void searchCategory(String category) {
    setState(() {
      isLoadMore = true;
    });
    PinterestHttp.GET(
            PinterestHttp.API_SEARCH_PHOTO,
            PinterestHttp.paramsSearch(
                category, (pinterestList.length ~/ 10) + 1))
        .then((value) => {
              pinterestList
                  .addAll(List.from(PinterestHttp.parseSelectPage(value!))),
              setState(() {
                isLoadMore = false;
              }),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            child: Stack(
          children: [
            Icon(
              Icons.camera,
              color: Colors.black,
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: [
                      ///Image
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        child: Image(
                          image: NetworkImage(widget.pinterestPhoto),
                        ),
                      ),

                      ///Followers
                      ListTile(
                        horizontalTitleGap: 8,
                        contentPadding:
                            EdgeInsets.only(top: 8, left: 10, right: 10),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              widget.pinterest.user!.profileImage!.large!),
                        ),
                        title: Text(widget.pinterest.user!.name!),
                        subtitle: Text(
                            widget.pinterest.likes.hashCode.toString() +
                                " followers"),
                        trailing: MaterialButton(
                          color: Colors.grey.shade400,
                          shape: StadiumBorder(),
                          onPressed: () {},
                          child: Text(
                            "Follow",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      ///
                      Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: widget.pinterest.description != null
                              ? Text(widget.pinterest.description!)
                              : null),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        margin: EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Icon(FontAwesomeIcons.solidComment),
                            ),
                            Container(
                              height: 60,
                              child: MaterialButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Read it",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            Container(
                              height: 60,
                              width: 70,
                              child: MaterialButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                              decoration: BoxDecoration(
                                  color: Colors.red.shade600,
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            Icon(
                              Icons.share,
                              color: Colors.black,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                ),
                SizedBox(
                  height: 5,
                ),

                ///Share your feedback
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Share your feedback",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),

                      ///Ответить
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              widget.pinterest.user!.profileImage!.large!),
                        ),
                        title: Row(
                          children: [
                            Text(widget.pinterest.user!.username!),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 100,
                                child: Text(widget.pinterest.user!.location!,overflow: TextOverflow.ellipsis,maxLines: 1,))
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.solidHeart,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(widget.pinterest.user!.username!.length
                                .toString()),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Reply")
                          ],
                        ),
                      ),

                      ///Comment
                      ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/uns.jpg"),
                          ),
                          title: GestureDetector(
                            child: Text(
                              "Add a comment",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30)),
                                  ),
                                  builder: (
                                    BuildContext context,
                                  ) {
                                    return Container(
                                      padding: EdgeInsets.only(
                                          top: 20, left: 15, right: 15),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Add a comment",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextField(
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    "Share what you like about this Pin,how it inspired you,or simply give a compliment",
                                                hintMaxLines: 3),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  context: context);
                            },
                          )),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "More like this",
                        style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
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
                                GestureDetector(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18.0),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Image.asset(
                                                "assets/images/notFound.jpg"),
                                        imageUrl:
                                            pinterestList[index].urls!.regular!,
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                "assets/images/notFound.jpg"),
                                      )),
                                  onTap: () {},
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        pinterestList[index].description != null
                                            ? Container(
                                                width: 140,
                                                child: Text(
                                                  pinterestList[index]
                                                      .description!,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ))
                                            : Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            pinterestList[index]
                                                                .user!
                                                                .profileImage!
                                                                .large!))),
                                              )
                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          showMaterialModalBottomSheet(
                                            context: context,
                                            builder: (context) => Container(),
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
                    ],
                  ),
                )
              ],
            ),
          ],
        )));
  }
}
