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
// // //
// class ForgotPasswordController extends GetxController {
//   final AuthRepository authRepository;
//
//   ForgotPasswordController({required this.authRepository});
//
//   final mobile = TextEditingController();
//   final util = Utills();
//
//   Future<reset_otp_res.ResendOtpRes?> forgotPassword() async {
//     debugPrint("forgetcalled");
//     if (mobile.text.isEmpty) {
//       util.showSnackBar("Alert", "Mobile field is empty!", false);
//       return null;
//     }
//     util.startLoading();
//     var res = await authRepository.resendOtp(mobile.text.toString());
//
//     if (res.statusCode == 200 || res.statusCode == 201) {
//       util.showFailProcess();
//       // var tempres=jsonDecode(res.bodyString!);
//       // if(tempres['status']==false){
//       //   util.showSnackBar("Alert", tempres['message'].toString(), false);
//       //   return null;
//       // }
//
//       var temp = reset_otp_res.resendOtpResFromJson(res.bodyString!);
//
//       if (temp.status == false) {
//         util.showSnackBar("Alert", temp.message, false);
//         return null;
//       }
//       print("sdfd ${res.body}");
//       if (temp.status == true && temp.message == "New OTP sent successfully.") {
//         Get.to(() =>
//             Otp(true, mobile.text, "fogotpassword", "Contact admin for OTP",newOtp: temp.status,));
//       }
//     } else {
//       util.showFailProcess();
//       if (res.statusCode == 404) {
//         util.showSnackBar(
//             "Alert", jsonDecode(res.bodyString!)['message'].toString(), false);
//       } else {
//         jsonDecode(res.bodyString!)['message'].toString() == null
//             ? util.showSnackBar("Alert", "Something went wrong", false)
//             : util.showSnackBar("Alert",
//                 jsonDecode(res.bodyString!)['message'].toString(), false);
//       }
//     }
//   }
// }


import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../Utills3/utills.dart';
import '../auth/auth_repository.dart';
import 'package:testingevergreen/pages/otp/otp.dart';
import 'package:testingevergreen/pages/forgot_password/reset_otp_res.dart' as reset_otp_res;

class ForgotPasswordController extends GetxController {
  final AuthRepository authRepository;

  ForgotPasswordController({required this.authRepository});

  final mobile = TextEditingController();
  final util = Utills();

  Future<void> forgotPassword() async {
    debugPrint("forgetcalled");
    if (mobile.text.isEmpty) {
      util.showSnackBar("Alert", "Mobile field is empty!", false);
      return;
    }

    util.startLoading();
    var res = await authRepository.resendOtp(mobile.text.toString());

    if (res.statusCode == 200 || res.statusCode == 201) {
      util.showFailProcess();
      var temp = reset_otp_res.resendOtpResFromJson(res.bodyString!);

      if (!temp.status) {
        util.showSnackBar("Alert", temp.message, false);
        return;
      }

      debugPrint("Response received: ${res.body}"); // Log the response

      if (temp.status && temp.message == "New OTP sent successfully.") {
        // Parse the response body to extract the OTP
        var responseBody = jsonDecode(res.bodyString!);
        var otp = responseBody['otp'];
print("sdfd ${responseBody}");
        // Navigate to the Otp screen, passing the OTP
        print("sdfd ${otp}");
        Get.to(() => Otp(
          true,
          mobile.text,
          "forgotpassword",
          "Contact admin for OTP",
          newOtp: otp.toString(), //// Pass the OTP

        ));
      }
    } else {
      util.showFailProcess();
      var errorMessage = jsonDecode(res.bodyString!)['message']?.toString();
      util.showSnackBar("Alert", errorMessage ?? "Something went wrong", false);
    }
  }
}



