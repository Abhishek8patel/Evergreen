import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// import '../../Utills/utills.dart';
import '../../Utills3/utills.dart';
import '../../appconstants/appconstants.dart';
import '../../data/repository/profile_repo.dart';

class EditProfileController extends GetxController {
  final ProfileRepository profileRepository;

  EditProfileController({required this.profileRepository});

  var util = Utills();

  var interest = [];
  var about_me = TextEditingController();
  var last_name = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();
  var dob = TextEditingController();
  var address = TextEditingController();
  var first_name = TextEditingController();

  RxString user_token = "".obs;

  @override
  void onInit() async {
    super.onInit();
  }

  bool validation() {
    if (first_name.value.text.isEmpty) {
      util.showSnackBar("Alert", "Please provide First Name", false);

      return false;
    }else{
      return true;
    }

    }



}
