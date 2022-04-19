import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinterest/controller/profile_controller.dart';



class ProfilePage extends StatelessWidget {
  static String id = "ProfilePage";
  const ProfilePage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileController(),
        builder: (ProfileController controller) => Scaffold(
          appBar: AppBar(
            actions: const [
              Icon(Icons.share,color: Colors.black,size: 25,),
              SizedBox(width: 10,),
              Icon(Icons.more_horiz,color: Colors.black,size: 25,),
              SizedBox(width: 10,),

            ],
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 15),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      child: Text("N",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.black),),
                      radius: 50,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text("Nurulloh",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text("@nurulloh_1",style: TextStyle(color: Colors.black,fontSize: 14,),),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("100"),
                      SizedBox(width: 2,),
                      Text("followers"),
                      SizedBox(width: 5,),
                      Text("•"),
                      SizedBox(width: 5,),
                      Text("3"),
                      SizedBox(width: 2,),
                      Text("following",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),

                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withOpacity(0.05)
                          ),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(right: 10,bottom: 10),
                                hintText: "Search your Pins",
                                hintStyle: TextStyle(color: Colors.grey.shade600),
                                prefixIcon: Icon(Icons.search,size: 20,)),
                          ),
                        ),

                      ),
                      SizedBox(width: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(Icons.add,color: Colors.black,size: 28,),
                        ],
                      )

                    ],
                  ),
                  SizedBox(height: 20,),

                  ///You haven`t saved any ideas yet

                  Padding(
                    padding:EdgeInsets.only(top: 25),
                    child: Column(
                      children: [
                        Text("You haven`t saved any ideas yet",style: TextStyle(color: Colors.grey,fontSize: 18),),
                        SizedBox(height: 15,),
                        MaterialButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                          ),
                          height: 50,
                          onPressed: (){
                          },
                          child: Text("Find ideas"),
                          color: Colors.grey.shade300,
                        )
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        )
    );
  }
}
