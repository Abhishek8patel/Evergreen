import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:testingevergreen/image_names.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:testingevergreen/pages/login/login.dart';
import 'package:testingevergreen/pages/myhomepage/myhomepage.dart';
import 'package:testingevergreen/pages/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import '../../Utills/utills.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utills3/utills.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

go_to_home() async {
  await Future.delayed(Duration(seconds: 2), () {});
}

class _SplashState extends State<Splash> {
  String deviceId = "";
  AndroidBuildVersion? androidBuildVersion;
  final util = Utills();

  var mymsg = "Welcome";
  var user_data = [];
  var load_status = false;
  var userid = "";
  var fullname = "";
  var mobile = "";
  var userpic = "";
  final TAG = "splashDebug";
  var isUpdating = false;
  DashboardController _dashboardController = Get.find();
  UserModel? userModel;

  Future<String?> _initDeviceId() async {
    AppConstant().enable_full_screen();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id!; // Unique ID for Android
      AppConstant.save_data("deviceId", deviceId);
      debugPrint("DeviceID:${androidInfo.id!}");
      androidBuildVersion = androidInfo.version;
      return deviceId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return deviceId = iosInfo.identifierForVendor!; // Unique ID for iOS
    } else {
      return deviceId = 'Unsupported Platform';
    }
  }



  @override
  void initState() {
    _initDeviceId().then((value) {
      if (value != null) {
        debugPrint("deviceIDnj:${value}");
        _dashboardController.uid.value=value;
        Future.delayed(Duration(seconds: 3), () {
       AppConstant().disable_full_screen();
          AppConstant.getUserData("user_data").then((value) =>
          {
            if (value != null)
              {
                debugPrint("deviceIDnj:notnull"),
                debugPrint(TAG + value.toString()),
                userModel = UserModel(
                    user_id: value.user_id,
                    user_token: value.user_token,
                    user_name: value.user_name,
                    user_mobile: value.user_mobile,
                    user_pic: value.user_pic,
                    user_role: value.user_role,
                    user_deviceID: value.user_deviceID),
                if (userModel!.user_token.isNotEmpty)
                  {
                    debugPrint("userid" + "${userModel!.user_id.toString()}"),
                    debugPrint(
                        "usertoken" + "${userModel!.user_token.toString()}"),
                    Get.offAll(() => MyHomePage(0)),
                  }
                else
                  {
                    Get.offAll(() => Login()),
                  }
              } else
              {
                debugPrint("deviceIDnj:null"),
                Get.offAll(() => Login()),
              }
          });
        });
      }
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "${ImageNames.image_location}${ImageNames.splash_bg}",
                ),
                fit: BoxFit.cover)),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Image.asset(
            "${ImageNames.image_location}${ImageNames.splash_center_logo}",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
