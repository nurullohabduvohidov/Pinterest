import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pinterest/pages/comment_page.dart';
import 'package:pinterest/pages/home_page.dart';
import 'package:pinterest/pages/profile_page.dart';
import 'package:pinterest/pages/search_page.dart';


class PageControllerPage extends StatefulWidget {
  const PageControllerPage({Key? key}) : super(key: key);

  @override
  _PageControllerPageState createState() => _PageControllerPageState();
}

class _PageControllerPageState extends State<PageControllerPage> {
  int changeIndex = 0;
  bool isOffline = false;
  PageController _controller = PageController();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;



  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(
        'Couldn\'t check connectivity status',
      );
      return;
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    if(_connectionStatus == ConnectivityResult.none){
      setState(() {
        isOffline = true;
      });
    }

    else {
      setState(() {
        isOffline = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _controller =PageController();
    _connectivitySubscription =  _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _connectivitySubscription.cancel();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: (_connectionStatus == ConnectivityResult.none ) ? Center(
        child: Lottie.asset('assets/nointernet.json',
          width: 180,),
      ) : PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        onPageChanged: (index){
         setState(() {
           changeIndex = index;
         });
        },
        children: [
          HomePage(),
          SearchPage(),
          CommentPage(collection: null,),
          ProfilePage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 15),
        margin: EdgeInsets.only(left: 40,right: 40,bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.black,
          currentIndex: changeIndex,
          backgroundColor: Colors.transparent,
          elevation: 0,
          onTap: (int index){
            setState(() {
              changeIndex = index;
              _controller.jumpToPage(index);
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,

           items: [
             BottomNavigationBarItem(
                 icon: Icon(Icons.home),
               label: ""
             ),
             BottomNavigationBarItem(
                 icon:Icon(Icons.search),
                 label: ""
             ),
             BottomNavigationBarItem(
                 icon:Icon(FontAwesomeIcons.solidCommentDots),
                 label: ""
             ),
             BottomNavigationBarItem(
                 icon:CircleAvatar(
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

 // static Container buildFLoating(BuildContext context) {
 //    return Container(
 //      width: MediaQuery.of(context).size.width*0.7,
 //      height: 50,
 //      decoration: BoxDecoration(
 //        borderRadius: BorderRadius.circular(50),
 //        color: Colors.white,
 //      ),
 //      child: Padding(
 //        padding: const EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
 //        child: Row(
 //          mainAxisAlignment: MainAxisAlignment.spaceBetween,
 //          children: [
 //            IconButton(
 //              padding: EdgeInsets.only(bottom: 5,top: 3),
 //              onPressed: () {
 //              },
 //              icon: Icon(Icons.home,color: Colors.grey,),
 //            ),
 //            IconButton(
 //              padding: EdgeInsets.only(bottom: 5,top: 3),
 //              onPressed: () {
 //                Navigator.pushNamed(context, SearchPage.id);
 //              },
 //              icon: Icon(Icons.search,color: Colors.grey,),
 //            ),
 //            Stack(
 //              children: [
 //                IconButton(
 //                    padding: EdgeInsets.only(bottom: 5),
 //                    onPressed: () {
 //                      Navigator.pushNamed(context, CommentPage.id);
 //                    },
 //                    icon: Icon(FontAwesomeIcons.solidCommentDots,color: Colors.grey)),
 //                Positioned(
 //                    left: 25,
 //                    child: Container(
 //                      alignment: Alignment.center,
 //                      child: Text("7",style: TextStyle(color: Colors.white),),
 //                      height: 17,
 //                      width: 17,
 //                      decoration: BoxDecoration(
 //                        borderRadius: BorderRadius.circular(8),
 //                        color: Colors.red.shade800,
 //                      ),
 //
 //                    )
 //                )
 //              ],
 //            ),
 //            CircleAvatar(
 //              radius: 10,
 //              backgroundImage: AssetImage("assets/images/uns.jpg"),
 //            )
 //          ],
 //        ),
 //      ),
 //
 //    );
 //  }
}
