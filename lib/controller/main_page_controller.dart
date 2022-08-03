import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController{
  int changeIndex = 0;
  bool isOffline = false;
  PageController controller = PageController();
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;



  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(
        'Couldn\'t check connectivity status',
      );
      }
      return;
    }

      return Future.value(null);


  }
  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus = result;
    update();
    if(connectionStatus == ConnectivityResult.none){
      isOffline = true;
      update();
    }

    else {
      isOffline = false;
      update();
    }
  }

  void functionChangeIndex(int index){
    changeIndex = index;
    update();
  }


  void changePageControllerIndex(int index) {
    changeIndex = index;
    controller.jumpToPage(index);
    update();
  }
@override
  void onInit() {
    super.onInit();
    initConnectivity();
    controller =PageController();
    _connectivitySubscription =  _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }
 @override
  void onClose() {
    super.onClose();
    controller.dispose();
    _connectivitySubscription.cancel();
  }
}