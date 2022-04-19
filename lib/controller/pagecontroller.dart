import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PageControll extends GetxController{
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
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initConnectivity();
    controller =PageController();
    _connectivitySubscription =  _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }
 @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    controller.dispose();
    _connectivitySubscription.cancel();
  }
}