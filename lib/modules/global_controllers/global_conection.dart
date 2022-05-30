import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../constant/common/conectivityStatus.dart';


class GlobalConection extends GetxController {
  StreamController<ConnectivityStatus> connectionStatusController = StreamController<ConnectivityStatus>();

  GlobalConection(){
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Use Connectivity() here to gather more info if you need t

      connectionStatusController.add(_getStatusFromResult(result));
    });

  }
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Online;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Online;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
  @override
  voidonInit(){

  }

  void onCloser(){

  }

}