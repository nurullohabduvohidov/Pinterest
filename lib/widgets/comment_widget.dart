import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinterest/controller/comment_controller.dart';

class CommentWidget extends StatelessWidget {
  final CommentController controller;
  const CommentWidget({Key? key,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [

                  Expanded(
                      child: ListView.builder(
                        itemCount: controller.note.length,
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
                                              child:  controller.note[index].user?.profileImage?.large != null ? CachedNetworkImage(
                                                imageUrl: controller.note[index].user!.profileImage!.large!,
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
                                          child: controller.note[index].user?.bio != null ? Text(controller.note[index].user!.bio!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),)
                                              : Text(controller.note[index].user!.name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),)
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                                    child: controller.note.isNotEmpty ? CircleAvatar(
                                      radius: 25,
                                      foregroundImage: NetworkImage(controller.note[0].user!.profileImage!.large!),
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
                                  child: Text(controller.note.isNotEmpty ? controller.note[1].user!.name! : "User", style:const TextStyle(fontSize: 18, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis,),
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
                    child: Container()
                )
              ],
            )
          ],
        ),
        controller.isLoading ? Center(
          child: CircularProgressIndicator(),
        ) : SizedBox.shrink()
      ],
    );
  }
}
