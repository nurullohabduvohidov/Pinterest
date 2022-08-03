import 'package:flutter/material.dart';
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