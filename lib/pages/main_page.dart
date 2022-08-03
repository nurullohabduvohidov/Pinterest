import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinterest/controller/main_page_controller.dart';
import 'package:pinterest/pages/comment_page.dart';
import 'package:pinterest/pages/home_page.dart';
import 'package:pinterest/pages/profile_page.dart';
import 'search_page.dart';



class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MainPageController(),
        builder: (MainPageController controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: (controller.connectionStatus == ConnectivityResult.none)
                ? Center(
              child: Lottie.asset('assets/animation/no_internet.json',
                width: 180,),
            )
                : PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.controller,
              onPageChanged: (index) {
                 controller.functionChangeIndex(index);
              },
              children: const [
                HomePage(),
                SearchPage(),
                CommentPage(collection: null,),
                ProfilePage(),
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation
                .centerFloat,
            floatingActionButton: Container(
              padding: EdgeInsets.only(left: 15),
              margin: EdgeInsets.only(left: 40, right: 40, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: BottomNavigationBar(
                selectedItemColor: Colors.black,
                currentIndex: controller.changeIndex,
                backgroundColor: Colors.transparent,
                elevation: 0,
                onTap: (int index) {
                controller.changePageControllerIndex(index);
                },
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,

                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: ""
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: ""
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.solidCommentDots),
                      label: ""
                  ),
                  BottomNavigationBarItem(
                      icon: CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage("assets/images/uns.jpg"),
                      ),
                      label: ""
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}