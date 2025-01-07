import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'Utills3/utills.dart';

// import 'Utills/utills.dart';



class GetXNetworkManager extends GetxController
{

  var currentIndex=0.obs;
  final util=Utills();
  //this variable 0 = No Internet, 1 = connected to WIFI ,2 = connected to Mobile Data.
  int connectionType = 0;

  //Instance of Flutter Connectivity
  final Connectivity _connectivity = Connectivity();

  //Stream to keep listening to network change state
  late StreamSubscription _streamSubscription ;

  @override
  void onInit() {

    _connectivity.checkConnectivity().then((value) => {
      _updateState(value),
      _connectivity.onConnectivityChanged.listen(_updateState),
      //  _connectivity.onConnectivityChanged.listen(upsateSate(value))
    });
    // GetConnectionType();
    //  _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }



  // a method to get which connection result, if you we connected to internet or no if yes then which network
  Future<void>GetConnectionType() async{
    var connectivityResult;
    try{
      connectivityResult = await (_connectivity.checkConnectivity());
    }on PlatformException catch(e){
      print(e);
    }
    return _updateState(connectivityResult);
  }

  // state update, of network, if you are connected to WIFI connectionType will get set to 1,
  // and update the state to the consumer of that variable.
  void _updateState(List<ConnectivityResult> result)
  {
    switch(result.first)
    {
      case ConnectivityResult.wifi:
        connectionType=1;
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType=2;
        update();
        break;
      case ConnectivityResult.none:
        connectionType=0;
        update();
        break;
      default: Get.snackbar('Network Error', 'Failed to get Network Status');
      break;

    }
  }

  @override
  void onClose() {
    //stop listening to network state when app is closed
    _streamSubscription.cancel();
  }
}