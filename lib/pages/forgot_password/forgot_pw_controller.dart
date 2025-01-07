import 'dart:convert';

import 'package:testingevergreen/pages/forgot_password/forget_pw_res.dart'
    as ForgetRes;
import 'package:testingevergreen/pages/forgot_password/reset_otp_res.dart'
    as reset_otp_res;
import 'package:testingevergreen/pages/otp/otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// import '../../Utills/utills.dart';
import '../../Utills3/utills.dart';
import '../auth/auth_repository.dart';

class ForgotPasswordController extends GetxController {
  final AuthRepository authRepository;

  ForgotPasswordController({required this.authRepository});

  final mobile = TextEditingController();
  final util = Utills();

  Future<reset_otp_res.ResendOtpRes?> forgotPassword() async {
    debugPrint("forgetcalled");
    if (mobile.text.isEmpty) {
      util.showSnackBar("Alert", "Mobile field is empty!", false);
      return null;
    }
    util.startLoading();
    var res = await authRepository.resendOtp(mobile.text.toString());

    if (res.statusCode == 200 || res.statusCode == 201) {
      util.showFailProcess();
      // var tempres=jsonDecode(res.bodyString!);
      // if(tempres['status']==false){
      //   util.showSnackBar("Alert", tempres['message'].toString(), false);
      //   return null;
      // }

      var temp = reset_otp_res.resendOtpResFromJson(res.bodyString!);

      if (temp.status == false) {
        util.showSnackBar("Alert", temp.message, false);
        return null;
      }
      if (temp.status == true && temp.message == "New OTP sent successfully.") {
        Get.to(() =>
            Otp(true, mobile.text, "fogotpassword", "Contact admin for OTP"));
      }
    } else {
      util.showFailProcess();
      if (res.statusCode == 404) {
        util.showSnackBar(
            "Alert", jsonDecode(res.bodyString!)['message'].toString(), false);
      } else {
        jsonDecode(res.bodyString!)['message'].toString() == null
            ? util.showSnackBar("Alert", "Something went wrong", false)
            : util.showSnackBar("Alert",
                jsonDecode(res.bodyString!)['message'].toString(), false);
      }
    }
  }
}
