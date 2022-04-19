import 'package:flutter/material.dart';
import 'package:pinterest/utils/classess.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

Padding buildPadding(BuildContext context,int index,final getFind) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, top: 20.0, bottom: 10.0),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        children: [

          ///Icon/Text
          Row(
            children: [
              GestureDetector(
                child: Icon(
                  Icons.clear,
                  color: Colors.black87,
                  size: 35,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                child: Text("Share to"),
                onPressed: ()=> launch("tel:+998993169326"),
              )
            ],
          ),
          SizedBox(height: 15,),

          ///SEND
          SizedBox(
            height: 119,
            // padding: EdgeInsets.only(left: 10, right: 20, top: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return bottomSheetFunction(index,getFind);
              },
              itemCount: UtilClass.bottomSheetPhoto.length,
            ),
          ),

          Divider(
            thickness: 0.5,
          ),

          ///DownLoad Image
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 10,top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Text("Download Images",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                  onTap: (){
                    Navigator.of(context).pop();
                    getFind.save(index);
                    showTopSnackBar(
                      context,
                      CustomSnackBar.info(
                        backgroundColor: Colors.grey.shade800,
                        message:
                        "Image downloaded!",
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      additionalTopPadding: 30,
                      displayDuration: const Duration(milliseconds: 800),
                      hideOutAnimationDuration: const Duration(milliseconds: 400),
                    );
                  },
                ),
                SizedBox(height: 17,),
                GestureDetector(child: Text("Hide Pin",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                SizedBox(height: 17,),
                GestureDetector(child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 2,),
                    Text("Report Pin",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                    Text("This goes against Pinterest`s Community\nGuidelines"),

                  ],
                )),
              ],
            ),
          ),

          SizedBox(height: 15,),
          ///This
          Divider(
            thickness: 0.5,
          ),
          Container(
            padding: EdgeInsets.only(top: 20,left: 10),
            alignment: Alignment.topLeft,
            child: Text("This Pin is inspired by your recent activity"),
          )
        ],
      ),
    ),
  );
}
Container bottomSheetFunction(int index,final getFind) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        ///images
        SizedBox(
          height: 65,
          width: 65,
          child: GestureDetector(
            onTap: ()=> launch("${getFind.links[index]}${Uri.encodeComponent(getFind.pinterestList[index].urls!.regular!)}"),
            child: Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(UtilClass.bottomSheetPhoto[index]),
                  )),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),

        ///text
        Text(
          UtilClass.bottomSheetText[index],
          style: TextStyle(color: Colors.grey),
        )
      ],
    ),
  );
}