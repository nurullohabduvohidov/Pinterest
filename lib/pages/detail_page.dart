import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinterest/controller/detail_controller.dart';
import 'package:pinterest/models/pinterest.dart';
import 'package:pinterest/views/search_view.dart';

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
  final getFind = Get.find<DetailController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DetailController(),
        builder: (DetailController controller) => Scaffold(
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
                                child: CachedNetworkImage(
                                  placeholder: (context, url) =>
                                      Image.asset("assets/images/notFound.jpg"),
                                  imageUrl: widget.pinterestPhoto,
                                  errorWidget: (context, url, error) =>
                                      Image.asset("assets/images/notFound.jpg"),
                                )
                                //Image(image: NetworkImage(widget.pinterestPhoto),),
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
                                    Icon(FontAwesomeIcons.solidComment),
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
                                    SizedBox(
                                        width: 100,
                                        child: Text(widget.pinterest.user!.location ?? "Spain",overflow: TextOverflow.ellipsis,maxLines: 1,))
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
                                    onTap: () {},
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
                              buildPaddingMasonry(getFind),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )))
    );
  }
}
