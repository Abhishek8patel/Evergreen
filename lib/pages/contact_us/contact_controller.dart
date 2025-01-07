import 'package:testingevergreen/pages/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
// import '../../Utills/utills.dart';
import 'package:email_validator/email_validator.dart';

import '../../Utills3/utills.dart';
import '../../appconstants/appconstants.dart';
import '../../data/repository/profile_repo.dart';
import '../myhomepage/myhomepage.dart';
class ContactController extends GetxService{

  final ProfileRepository profileRepository;

  ContactController({required this.profileRepository});
  final TAG="contactusdebug";

  var util=Utills();

  var name = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();
  var message = TextEditingController();

  bool check() {
    if (name.text.isEmpty ) {
      util.showSnackBar("Alert", "Please fill up name field", false);
      return false;
    }else if (mobile.text.isEmpty||mobile.text.length!=10) {
      util.showSnackBar("Alert", "Please fill up mobile field.", false);
      return false;
    } else if (email.text.isEmpty||!EmailValidator.validate(email.text)) {
      util.showSnackBar("Alert", "Please fill up valid email field.", false);
      return false;
    }  else if (message.text.isEmpty) {
      util.showSnackBar("Alert", "Please fill up message field.", false);
      return false;
    } else {
      return true;
    }
  }
  //
  Future<void> contactUS(bool? isLogin) async {
    if (check() == false) {
      return null;
    }
    util.startLoading();
    var res = await profileRepository.contact_us(
        AppConstant.take_data('token'),
        name.text,email.text,mobile.text,message.text);
    AppConstant.njDebug(TAG: TAG,msg: "called");
    if (res.statusCode == 200 || res.statusCode == 201) {
      AppConstant.njDebug(TAG: TAG,msg: "200");
      // var temp=  jsonDecode(res.bodyString!);
      debugPrint("contact_res:${ AppConstant.take_data('token').toString()}");
      // temp.
      util.stopLoading();
      util.showSnackBar("Alert", "Uploaded successfully!", true);
      name.text = "";
      email.text = "";
      mobile.text = "";
      message.text = "";
      if(isLogin==false){
        Future.delayed(Duration(milliseconds: 200),(){
          Get.offAll(Login());
        });

      }else{
        Future.delayed(Duration(milliseconds: 200),(){
          Get.offAll(MyHomePage(0));
        });
      }


    } else {
      AppConstant.njDebug(TAG: TAG,msg: "failed:${res.status.hasError}");
      util.stopLoading();
      util.showSnackBar("Alert", "failed to upload!${res.bodyString}", false);
    }
  }


}