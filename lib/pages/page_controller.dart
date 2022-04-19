import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinterest/controller/pagecontroller.dart';
import 'package:pinterest/pages/comment_page.dart';
import 'package:pinterest/pages/home_page.dart';
import 'package:pinterest/pages/profile_page.dart';
import 'search_page.dart';



class PageControllerPage extends StatefulWidget {
  const PageControllerPage({Key? key}) : super(key: key);

  @override
  _PageControllerPageState createState() => _PageControllerPageState();
}

class _PageControllerPageState extends State<PageControllerPage> {
  final getFind = Get.find<PageControll>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: PageControll(),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: (getFind.connectionStatus == ConnectivityResult.none)
                ? Center(
              child: Lottie.asset('assets/nointernet.json',
                width: 180,),
            )
                : PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: getFind.controller,
              onPageChanged: (index) {
                setState(() {
                  getFind.changeIndex = index;
                });
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
                currentIndex: getFind.changeIndex,
                backgroundColor: Colors.transparent,
                elevation: 0,
                onTap: (int index) {
                  getFind.changeIndex = index;
                  getFind.controller.jumpToPage(index);
                  getFind.update();
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