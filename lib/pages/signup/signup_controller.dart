import 'dart:convert';
import 'dart:io';

import 'package:testingevergreen/pages/signup/sign_up_res_model.dart' as regRes;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';

// import '../../Utills/utills.dart';
import '../../Utills3/utills.dart';
import '../auth/auth_repository.dart';
import 'package:email_validator/email_validator.dart';

class SignupController extends GetxController {
  final AuthRepository authRepository;

  SignupController({required this.authRepository});

  var util = Utills();
  final TAG = "signupPage";
  var isLoading = false.obs;
  var countryCode = "+91".obs;
  var _errorText = "";
  var fname = TextEditingController();
  var mobile = TextEditingController();
  var email = TextEditingController();
  var address = TextEditingController();
  var password = TextEditingController();
  var Confirmpassword = TextEditingController();

  Rx<File?> fimage1 = Rx<File?>(null);
  File? image;
  DateTime? currentDate;

  bool check() {
    final RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*]).{8,}$');
    final RegExp regexEmail =
    RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (fname.text.isEmpty) {
      util.showSnackBar("Alert", "Please enter full name", false);
      return false;
    } else if (fimage1.value == null) {
      util.showSnackBar("Alert", "Please select valid pic", false);
      return false;
    } else if (mobile.text.isEmpty || mobile.text.length < 10) {
      util.showSnackBar("Alert", "Mobile number is not valid", false);
      return false;
    } else if (email.text.isEmpty || !GetUtils.isEmail(email.text) || !regexEmail.hasMatch(email.text)) {
      util.showSnackBar("Alert", "Please enter valid email address.", false);
      return false;
    } else if (address.text.isEmpty) {
      util.showSnackBar("Alert", "Please enter address.", false);
      return false;
    } else if (password.text.isEmpty || !regex.hasMatch(password.text)) {
      util.showSnackBar(
          "Alert",
          "Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be at least 8 characters long.",
          false);
      return false;
    } else if (Confirmpassword.text.isEmpty ||
        Confirmpassword.text.toString().trim() !=
            password.text.toString().trim()) {
      util.showSnackBar("Alert", "Password not matched!", false);
      return false;
    } else if (fimage1 == null) {
      util.showSnackBar("Alert", "Please select image!", false);
      return false;
    } else {
      debugPrint("debugsignup:"
          "${fname.text.toString()}"
          "${mobile.text.toString()}"
          "${password.text.toString()}"
          "${Confirmpassword.text.toString()}"
          "${email.text.toString()}"
          "${address.text.toString()}"
          "");
      return true;
    }
  }

  Future<regRes.SignupRes?> signUp(
      String deviceId, String? firebase_token) async {
    debugPrint("njj${fimage1}");

    if (check() == false) {
      return null;
    }

    util.startLoading();
    debugPrint(TAG + "called");
    var res = await authRepository.SignupAndUploadImage(
        fimage1.value!,
        fname.text.toString(),
        mobile.text.toString(),
        password.text.toString(),
        deviceId.toString(),
        email.text.toString(),
        address.text.toString(),
        firebase_token);
    debugPrint(TAG + "Abhi Sigup: ${res.bodyString}}");
    if (res.statusCode == 201 || res.statusCode == 200) {
      util.showFailProcess();
      debugPrint(TAG  + "200");

      var temp = regRes.signupResFromJson(res.bodyString!);

      //var temp = jsonDecode(res.bodyString!);
      if (temp.status == false) {
        debugPrint(TAG + "false");
        //isLeagleAge();
        util.showSnackBar("Alert", "Something went wrong!", false);
        return null;
      } else {
        var result = regRes.signupResFromJson(res.bodyString!);
        debugPrint("Abhi result :"  + "${result.toString()}");

        return result;
      }
    } else {
       util.showSnackBar("Alert", "hello " + res.statusCode.toString(), false);
      debugPrint(TAG + "failede${res.statusCode}");
      util.showFailProcess();
      debugPrint(TAG + "failedd${res.body}");
      if (jsonDecode(res.bodyString!)['message'].toString() != null) {
        debugPrint("${TAG}faileddr${json.toString()}");
        util.showSnackBar("Alert ", jsonDecode(res.bodyString!)[' message'].toString(), false);
      } else {
        util.showSnackBar("Alert", "Something went wrong!", false);
      }

      return null;
    }
  }
}
