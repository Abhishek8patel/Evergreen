import 'dart:convert';

import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:testingevergreen/pages/contact_us/contatct_us.dart';
import 'package:testingevergreen/pages/login/models/login_res.dart' as logRes;
import 'package:testingevergreen/pages/otp/otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testingevergreen/pages/login/login_controller.dart';
// import '../../Utills/utills.dart';
import '../../Utills3/utills.dart';
import '../auth/auth_repository.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;
  final TAG = "loginDebug";

  LoginController({required this.authRepository});

  RxString currentFCM = "".obs;

  //var service = AuthService();
  var util = Utills();
  var log_email = TextEditingController();
  var log_password = TextEditingController();
  var deviceId = TextEditingController();
  var isLoading = false.obs;
  var isRemember = false.obs;
  var countryCode = "+91".obs;

  RxString cookie = ''.obs;

  bool check() {
    final RegExp regex =
    RegExp(r"^[0-9]+$");
    if (log_email.text.isEmpty || log_email.text.length < 10) {
      util.showSnackBar("Alert",
          "Please enter your 10 digits registered mobile number.", false);
      return false;
    } else if (log_password.text.isEmpty) {
      util.showSnackBar("Alert", "Password field should not be empty.", false);
      return false;
    } else {
      return true;
    }
  }

  Future<logRes.LoginRes?> login() async {
    util.startLoading();
    if (check() == false) {
      util.stopLoading();
      return null;
    }
    util.startLoading();

    await AppConstant.initDeviceId().then((value) => {
          if (value != null)
            {
              debugPrint(TAG + "deviceID:$value"),
              deviceId.clear(),
              deviceId.text = value,
            }
        });




    if (deviceId.text.isEmpty) {
      util.stopLoading();
      util.showSnackBar("Alert", "Couldn't fetch device ID", false);

      return null;
    }
    var res = await authRepository.login({
      "mobile": log_email.text.toString(),
      "password": log_password.text.toString(),
      "deviceId": deviceId.text.toString(),
      "firebase_token": "${currentFCM}"
    });

    util.startLoading();
    debugPrint(TAG + "called");
    debugPrint(TAG + "ferer${res.bodyString}");
    if (res.statusCode == 201 || res.statusCode == 200) {
      util.stopLoading();
      // util.showFailProcess();
      debugPrint(TAG + "200");

      var temp_res = logRes.loginResFromJson(res.bodyString!);
      debugPrint(TAG + "200");
      util.stopLoading();
      return temp_res;
    } else {
      if (res.statusCode == 404) {
        util.stopLoading();
        var temp = jsonDecode(res.bodyString!);
        debugPrint(TAG + "tempmsg${temp['message']}");
        if (temp['message'] == "OTP Not verified") {
          util.showSnackBar("Alert", temp['message'], false);
          Get.to(Otp(false, log_email.text.toString(), "login",
              "Contact admin for OTP"));
          return null;
        } else {
          if (temp['message'] ==
              "Admin has Deactive you please contact admin") {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                context: Get.context!,
                builder: (c) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    height: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "Alert",
                              style: TextStyle(fontSize: 20),
                            )),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Center(
                            child: Text("${temp['message']}"),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppConstant.getTapButton(
                                    TextStyle(color: Colors.white),
                                    "OK",
                                    80,
                                    30, () {
                                  Get.to(ContactUs(
                                    isLogin: false,
                                  ));
                                }),
                                AppConstant.getTapButton(
                                    TextStyle(color: Colors.white),
                                    "Cancel",
                                    80,
                                    30, () {
                                  Get.back();
                                })
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            util.showSnackBar("Alert", temp['message'].toString(), false);
          }
        }
      }
      util.stopLoading();
      debugPrint(TAG + "failed${res.statusCode}");
      util.showFailProcess();
      return null;
    }
  }
}
