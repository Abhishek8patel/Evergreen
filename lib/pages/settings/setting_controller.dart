import 'dart:convert';

import 'package:testingevergreen/others/normal_res_dto.dart' as NormalRES;
import 'package:testingevergreen/pages/settings/setting_models/setting_model.dart'
    as SettingDTO;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../Utills/utills.dart';
import '../../Utills3/utills.dart';
import '../../appconstants/appconstants.dart';
import '../auth/auth_repository.dart';

class SettingController extends GetxController {
  var util = Utills();
  RxBool _isProcess=false.obs;
  RxBool get isProcess=>_isProcess;
  var password = TextEditingController();

  var cpassword = TextEditingController();

  var old_password = TextEditingController();

  RxString mydata = "".obs;

  RxString get _mydata => mydata;

  final AuthRepository authRepository;

  SettingController({required this.authRepository});

  RxBool oldPasswordError = false.obs;

  RxBool newPasswordError = false.obs;

  RxBool confirmPasswordError = false.obs;

  RxString _error_text = "".obs;

  RxString get error_text => _error_text;
  // else if (old_password.value.text.isEmpty) {
  // util.showSnackBar("Alert", "Old password field is empty matched!", false);
  // return false;
  // }
  bool validation() {
    if (password.value.text.isEmpty) {
      util.showSnackBar("Alert", "Please enter your password", false);
      return false;
    } else if (cpassword.value.text.isEmpty) {
      util.showSnackBar("Alert", "Please enter your confirm password", false);
      return false;
    } else if (cpassword.text.length < 6 || password.text.length < 6) {
      util.showSnackBar(
          "Alert", "Password length must be greater or equal 6 char", false);
      return false;
    } else if (cpassword.value.text.trim() != password.value.text.trim()) {
      util.showSnackBar(
          "Alert", "Password and confirm password not matched!", false);
      return false;
    }  else {
      return true;
    }
  }

  Future<NormalRES.NormalResponse?> signOut(String token) async {
    final result = await authRepository.logout(token);
    if (result.statusCode == 200 || result.statusCode == 201) {
      final res = NormalRES.normalResponseFromJson(result.bodyString!);

      return res;
    } else {
      return null;
    }
  }


  //problems



  Future<String?> changePassword(String token)async{
    if(validation()==false){
      return null;
    }
    final result=await authRepository.changePassword(cpassword.text, token);
    AppConstant.njDebug(TAG: "NJ", msg: "called");
    if(result.statusCode==201||result.statusCode==200){
      AppConstant.njDebug(TAG: "NJ", msg: "200");
      var temp=jsonDecode(result.bodyString!);
      if(temp['status']=="error"){
        util.showSnackBar("Alert", temp['Message'], false);
        return null;
      }

      if(temp['status']==true){
        //util.showSnackBar("Alert", temp['message'], false);
        return temp['message'];
      }


    }else{
      AppConstant.njDebug(TAG: "NJ", msg: "failed");
      return null;
    }
  }

  Future<SettingDTO.SettingResponse?> getaboutus(String endpoint) async {
    // if (check() == false) {
    //   return null;
    // }
    util.startLoading();
    debugPrint("getaboutus" + "called");
    var res = await authRepository.about_us(endpoint);
    if (res.statusCode == 201 || res.statusCode == 200) {
      debugPrint("getaboutus" + "200");
      util.showFailProcess();

      var result = SettingDTO.settingResponseFromJson(res.bodyString!);
      if (result.status == true) {
        // util.showSnackBar("Alert", result.content, true);
        mydata.value = "";
        mydata.value = result.content;
        mydata.refresh();
      } else if (result.status == false) {
        util.showSnackBar("Alert", "failed", false);
      }
    } else {
      debugPrint("getaboutus" + "failed");
      util.showFailProcess();
      return null;
    }
  }

  Future<void> logout() async {}

  @override
  void dispose() {
    password.dispose();
    cpassword.dispose();
  }
}
