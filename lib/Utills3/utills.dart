import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class Utills {
  // static final Utills _singleton = Utills._internal();

  // factory Utills() {
  //   return _singleton;
  // }

  // Utills._internal();

  click() {
    showSnackBar("Alert", "clicked", true);
  }
  static Future<String> getFileUrl(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/$fileName";
  }

  showNewSnack(BuildContext context,String msg){
    final snackBar = SnackBar(
      backgroundColor: Colors.orange,
      content:  Text('${msg}'),

    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showSnackBar(String title, String msg, bool isSuccess,{bool? isDismisable=true,SnackPosition? position=SnackPosition.BOTTOM}) {
    Get.snackbar(
      title,
      msg,
      snackPosition: position,
      backgroundColor: isSuccess == true ? Colors.green : Colors.red,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: 2),
      isDismissible: isDismisable,
      forwardAnimationCurve: Curves.easeOutBack,snackStyle: SnackStyle.FLOATING,

    );
  }

  startLoading() async{
    if(!EasyLoading.isShow){
      await EasyLoading.show(status: 'Please wait...');

    }


  }

  showSuccessProcess() {
    EasyLoading.dismiss();
  }

  showFailProcess() {
    EasyLoading.dismiss();
  }



  void stopLoading() {
    if(EasyLoading.isShow){
      EasyLoading.dismiss();
    }

  }

// void setData(String key, dynamic value) => GetStorage().write(key, value);
//
// dynamic getData(String key) => GetStorage().read(key);
//
// void clearData() async => GetStorage().erase();





}

