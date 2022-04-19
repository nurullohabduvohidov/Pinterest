import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/comment_page.dart';
import 'pages/home_page.dart';
import 'pages/page_controller.dart';
import 'pages/profile_page.dart';
import 'pages/search_page.dart';
import 'services/di_service.dart';

Future<void> main()async {
  await DIService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageControllerPage(),
      getPages: [
        GetPage(name: "/HomePage", page: () => const HomePage()),
        GetPage(name: "/CommentPage", page: () => const CommentPage()),
        GetPage(name: "/SearchPage", page: () => const SearchPage()),
        GetPage(name: "/ProfilePage", page: () => const ProfilePage()),
      ],
    );
  }
}


