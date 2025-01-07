import 'dart:convert';

import 'package:testingevergreen/pages/notification/noti_res.dart' as myNotiDTO;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// import '../Utills/utills.dart';
import '../Utills3/utills.dart';
import '../appconstants/appconstants.dart';
import '../data/repository/user_repo.dart';


class NotificationController extends GetxController {
  final UserRepo userRepo;

  NotificationController({required this.userRepo});

  RxBool _nodata = true.obs;

  RxBool get noData => _nodata;


  RxBool setDot = false.obs;

  RxList<myNotiDTO.Notification?> _getNotificationlist = <myNotiDTO.Notification?>[].obs;

  RxList<myNotiDTO.Notification?> get getNotificationlist => _getNotificationlist;

  var util = Utills();



  Future<myNotiDTO.NotiResponse?> getNotificationsList(String token) async {
    debugPrint("getNotificationsList api called");
    var res =
    await userRepo.getNotificationsList(token);
    util.startLoading();

    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("getNotificationsList api called 200");
      util.stopLoading();
      debugPrint("getNotificationsList api" + res.bodyString!.toString());


      var temp = myNotiDTO.notiResponseFromJson(res.bodyString!);

      if (temp.notifications.toString() == "[]") {
        debugPrint("getNotificationsList api" + "no data found!");
        _nodata.value = true;
        _getNotificationlist.clear();
        _getNotificationlist.refresh();
        _nodata.refresh();
        update();
        debugPrint("getNotificationsList api" + "${_nodata.value}");
        return null;
      }
      if (temp.status == true) {
        _nodata.value = false;
        _nodata.refresh();
        _getNotificationlist.clear();
        _getNotificationlist.value = temp.notifications;
        _getNotificationlist.refresh();
        update();
        return temp;
      } else {
        return null;
      }
    } else {
      debugPrint("getNotificationsList api failed");
      util.stopLoading();
      //util.showSnackBar("Alert", "Something went wrong", false);
      debugPrint("getNotificationsList api failed");
      return null;
    }
  }
}
