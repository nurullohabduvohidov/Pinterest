
import 'package:get/get.dart';
import 'package:pinterest/controller/comment_controller.dart';
import 'package:pinterest/controller/detail_controller.dart';
import 'package:pinterest/controller/home_controller.dart';
import 'package:pinterest/controller/pagecontroller.dart';
import 'package:pinterest/controller/profile_controller.dart';
import 'package:pinterest/controller/search_controller.dart';

class DIService {
  static Future<void> init() async {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<PageControll>(() => PageControll(), fenix: true);
    Get.lazyPut<CommentController>(() => CommentController(), fenix: true);
    Get.lazyPut<DetailController>(() => DetailController(), fenix: true);
    Get.lazyPut<SearchController>(() => SearchController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);

  }
}