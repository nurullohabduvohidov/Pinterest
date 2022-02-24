import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinterest/models/pinterest.dart';
import 'package:pinterest/services/pinterest_service.dart';


class CommentPage extends StatefulWidget {
  const CommentPage({Key? key, collection}) : super(key: key);

  static const String id = "comment_page";
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage>{
  List<Pinterest> note = [];
  List<Pinterest> imageList = [];
  bool isLoadMore = false;
  bool isLoading = true;
  int count = 10;

  // late TabController _tabsController;
  late int pageIndex = 0;

  Future<void> _random() async {
    String? response = await PinterestHttp.GET(PinterestHttp.API_TODO_LIST_RANDOM, PinterestHttp.randomPage(count));
    List<Pinterest> list = PinterestHttp.parseResponse(response!);
    setState(() {
      note.addAll(list);
      print("Length => ${list.length}");
    });
  }

  Future<void> _randomBasicImage(int countImage) async {
    String? response = await PinterestHttp.GET(PinterestHttp.API_TODO_LIST_RANDOM, PinterestHttp.randomPage(countImage));
    List<Pinterest> list = PinterestHttp.parseResponse(response!);
    setState(() {
      imageList.clear();
      imageList.addAll(list);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _random();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 58,
          bottom: PreferredSize(
              preferredSize: const Size(200, 0),
              child:Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: TabBar(
                        onTap: (int index){
                          setState(() {
                            pageIndex = index;
                          });
                        },
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        tabs: [
                          Container(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                'Updates',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            height: 40,
                            alignment: Alignment.center,
                          ),

                          Container(
                            alignment: Alignment.center,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                'Messages',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            height: 40,
                          ),
                        ],
                        // controller: _tabsController,
                      ),
                    ),
                  ),

                  Expanded(
                      flex: 1,
                      child: IconButton(onPressed: (){}, icon: const Icon(Icons.share, color: Colors.black,)))
                ],
              )
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [

                  Expanded(
                      child: ListView.builder(
                        itemCount: note.length,
                        itemBuilder: (context, index){
                          return Column(
                            children: [

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, ),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Expanded(
                                          flex: 1,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10.0),
                                              child:  note[index].user?.profileImage?.large != null ? CachedNetworkImage(
                                                imageUrl: note[index].user!.profileImage!.large!,
                                                placeholder: (context, url) => Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(10.0)
                                                  ),
                                                ),
                                              ) :  CachedNetworkImage(
                                                imageUrl: "https://www.pngitem.com/pimgs/m/35-350426_profile-icon-png-default-profile-picture-png-transparent.png",
                                                placeholder: (context, url) => Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(10.0)
                                                  ),
                                                ),
                                              )
                                          )
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          flex: 5,
                                          child: note[index].user?.bio != null ? Text(note[index].user!.bio!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),)
                                              : Text(note[index].user!.name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),)
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                              // Padding(
                              //   padding: const EdgeInsets.symmetric(vertical: 5),
                              //   child: gridCustom(),
                              // )
                            ],
                          );
                        },
                      )
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Expanded(
                    flex: 11,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        // #content
                        const Text("Share ideas with \nyour friends",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
                        const SizedBox(
                          height: 20,
                        ),

                        // #textField
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: GestureDetector(
                            onTap: (){
                              if (kDebugMode) {
                                print("Hello => TextField");
                              }
                            },
                            child: Container(
                                height: 38,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(19),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(Icons.search, color: Colors.black54,),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text("Search by name or email", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),),
                                  ],
                                )
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        // #contact message
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            height: 65,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 65,
                                  height: 65,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: note.isNotEmpty ? CircleAvatar(
                                      radius: 25,
                                      foregroundImage: NetworkImage(note[0].user!.profileImage!.large!),
                                    ) : const CircleAvatar(
                                      radius: 25,
                                      foregroundImage: NetworkImage("https://www.pngitem.com/pimgs/m/35-350426_profile-icon-png-default-profile-picture-png-transparent.png"),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 17,
                                  child: Text(note.isNotEmpty ? note[1].user!.name! : "User", style:const TextStyle(fontSize: 18, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis,),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: MaterialButton(
                                    elevation: 0,
                                    onPressed: (){},
                                    color: Colors.red.shade700,
                                    height: 45,
                                    shape: const StadiumBorder(),
                                    child: const Text('Message', style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        // #sync contact
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: (){
                              if (kDebugMode) {
                                print("Alert dialog");
                              }
                            },
                            child: SizedBox(
                              height: 65,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 65,
                                    height: 65,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red.shade700,
                                          radius: 25,
                                          child: const Icon(Icons.people_alt, color: Colors.white,),
                                        )
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text("Sync contacts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: IconButton(
                            onPressed: (){},
                            icon:const FaIcon(FontAwesomeIcons.penSquare, size: 35,),
                          ),
                        ),
                      ),
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }

// Widget imageContainer(){
//   return
// }
}