import 'dart:convert';

import 'package:testingevergreen/others/normal_res_dto.dart' as normalRes;
import 'package:testingevergreen/pages/login/login.dart';
import 'package:testingevergreen/pages/otp/model/otp_verification_res.dart' as otpVerificationRes;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// import '../../Utills/utills.dart';
import '../../Utills3/utills.dart';
import '../auth/auth_repository.dart';
class OtpController extends GetxController {
  final AuthRepository authRepository;

  OtpController({required this.authRepository});
  final TAG="OtpDebug";
  final util = Utills();
  var result = [];

  var codesent = false;
  var total_chance = 0;
  var count = 10;

  var otp_otp = TextEditingController();
  var otp = TextEditingController();
  var password = TextEditingController();
  var con_password = TextEditingController();
  var mobile = TextEditingController();

  bool otp_validation() {
    if (otp.text.isEmpty) {
      util.showSnackBar("Alert", "Please enter your otp", false);
      return false;
    } else {
      return true;
    }
  }

  bool validation() {
    final RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*]).{8,}$');

    if (otp.text.isEmpty) {
      util.showSnackBar("Alert", "Please enter your otp", false);
      return false;
    } else if (password.text.isEmpty || !regex.hasMatch(password.text)) {
      util.showSnackBar(
          "Alert",
          "Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be at least 8 characters long.",
          false);
      return false;
    } else if (con_password.text.isEmpty ||
        !regex.hasMatch(con_password.text)) {
      util.showSnackBar(
          "Alert",
          "Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be at least 8 characters long.",
          false);
      return false;
    } else if (password.text != con_password.text) {
      util.showSnackBar("Alert", "Passwords should be same", false);
      return false;
    } else if (mobile.text.isEmpty) {
      util.showSnackBar("Alert", "Mobile number is empty", false);
      return false;
    } else {
      return true;
    }
  }

  Future<normalRes.NormalResponse?> resendOtp(String email) async {
    if (email.toString().isEmpty) {
      util.showSnackBar("Alert", "Please fill valid mobile number.", false);
      return null;
    }
    debugPrint(TAG + "called${email}");
    util.startLoading();
    var result = await authRepository.resendOtp(email);
    debugPrint("resendotp" + result.bodyString.toString());
    if (result.statusCode == 200 || result.statusCode == 201) {
      debugPrint(TAG + "200");
      util.showFailProcess();
      debugPrint("resendotp" + "${email}");
      var res = normalRes.normalResponseFromJson(result.bodyString!);
      if (res.status == false) {
        util.showSnackBar("Alert", res.message, true);
      } else if (res.status == true) {
        util.showSnackBar("Alert", res.message, true);
      }
    } else {
      debugPrint(TAG + "failed${result.statusCode}");
      util.showFailProcess();
      util.showSnackBar(
          "Alert", "something went wrong.Please try again", false);
    }
  }
  Future<otpVerificationRes.OtpVerificationRes?> verifyOtp(
      String email, String otp) async {
    if (otp_validation() == false) {
      return null;
    }
    util.startLoading();
    var res = await authRepository.verifyOtp(email, otp);
    debugPrint("TAG"+"called");

    if (res.statusCode == 201 || res.statusCode == 200) {
      util.showFailProcess();
      debugPrint("TAG"+"200");
      //var temp = jsonDecode(res.bodyString!);

      var temp =otpVerificationRes.otpVerificationResFromJson(res.bodyString!);

      debugPrint("verifyotp ${res.statusCode}");

      if (temp.status == false) {
        debugPrint("verifyotp false");
        util.showSnackBar("Alert", temp.message.toString(), false);
        return null;
      }
      var result = otpVerificationRes.otpVerificationResFromJson(res.bodyString!);

      if (result.status == true) {

        debugPrint("verifyotp ok");
        util.showSnackBar("Hello", result.user.fullName, true);

        return result;
      } else {
        util.showSnackBar("Alert", "Something went wrong!", true);
        return null;
      }

      // if (temp['status'] == true) {
      //   otp_otp.text = "";
      //   util.showSnackBar("Alert", temp['message'].toString(), true);
      //
      //
      //   return OTPresponse.verifyotpResponseFromJson(res.bodyString!);
      // }else if(temp['status']==false){
      //   util.showSnackBar("Alert", temp['message'].toString(), false);
      // }
    } else  {
      if(res.statusCode==404){
        var temp=jsonDecode(res.bodyString!);
        if(temp['message'].toString()!=null){
          util.showSnackBar(
              "Alert", temp['message'].toString(), false);
        }

      }
      debugPrint("TAG"+"failed${res.statusCode}");
      util.showFailProcess();
      util.showSnackBar(
          "Alert", "Something went wrong.\nPlease try again later", false);
      return null;
    }
  }

  Future<normalRes.NormalResponse?> changePassword(
      String mobile, String otp, String newpass) async {
    if (validation() == false) {
      return null;
    }
    util.startLoading();
    var res = await authRepository.forgotPassword(mobile, newpass, otp);
    debugPrint("verifyotp called");
    if (res.statusCode == 201 || res.statusCode == 200) {
      util.showFailProcess();
      debugPrint("verifyotp 200");
      var temp = normalRes.normalResponseFromJson(res.bodyString!);

      debugPrint("verifyotp ${res.statusCode}");

      if (temp.status == true) {
        Get.to(Login(from:"forgotpassword"));

      } else if (temp.status == false) {
        util.showSnackBar("Alert", temp.message, false);
      }
    } else {
      debugPrint("verifyotp failed");
      util.showFailProcess();
      if(jsonDecode(res.bodyString!)['message'].toString()!=null){
        util.showSnackBar(
            "Alert", "${jsonDecode(res.bodyString!)['message'].toString()}", false);
      }else{
        util.showSnackBar(
            "Alert", "Something went wrong.\nPlease try again later", false);
      }

      return null;
    }
  }


}