import 'package:flutter/material.dart';
import 'package:pinterest/pages/comment_page.dart';
import 'package:pinterest/pages/home_page.dart';
import 'package:pinterest/pages/intro_page.dart';
import 'package:pinterest/pages/page_controller.dart';
import 'package:pinterest/pages/profile_page.dart';
import 'package:pinterest/pages/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageControllerPage(),
      routes: {
        HomePage.id : (context) => HomePage(),
        CommentPage.id : (context) => CommentPage(),
        SearchPage.id : (context) => SearchPage(),
        ProfilePage.id : (context) => ProfilePage(),
      },
    );
  }
}


