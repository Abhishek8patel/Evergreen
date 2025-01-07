import 'dart:io';
import 'package:testingevergreen/leave_regination/regination.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testingevergreen/pages/Consume_Chemical_list/ConsumeChemicallist.dart';
import 'package:testingevergreen/pages/change_password/change_password.dart';
import 'package:testingevergreen/pages/edit_profile/edit_profile.dart';
import 'package:testingevergreen/pages/login/login.dart';
import 'package:testingevergreen/pages/myhomepage/myhomepage.dart';
import 'package:testingevergreen/pages/profile/profile.dart';
import 'package:testingevergreen/pages/settings/about/aboutus.dart';
import 'package:testingevergreen/pages/settings/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../Utills/utills.dart';
import '../../Utills3/utills.dart';
import '../../appconstants/appconstants.dart';
import '../../appconstants/mycolor.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../leave_regination/leave.dart';
import '../contact_us/contatct_us.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class Setting extends StatefulWidget {
  var from = "";

  Setting(String _from) {
    this.from = _from;
  }

  @override
  State<Setting> createState() => _SettingsState(from);
}

class _SettingsState extends State<Setting> {
  var from = "";

  _SettingsState(String _from) {
    this.from = _from;
  }

  // final ProfileController profile_controller = Get.find();
  // final NotificationController notificationController = Get.find();
  // final UserController userController = Get.find();
  final SettingController settingController = Get.find();

  var isLogin = false;
  var util = Utills();
  var uimage = "";
  var mylist = [
    "My Profile",
    "Change Password",
    "T&C",
    "Privacy Policy",
    "About US",
    "Payment History",
    "Consume & Chemical list",
    "Logout"
  ];

  var user_data = [];
  var load_status = true;
  var userid = "";
  var user_name = "";
  var user_mail = "";
  var user_phone = "";

  var token = "";

  Future clearAppCache() async {
    Directory tempDir = await getTemporaryDirectory();
    tempDir.deleteSync(recursive: true);
    debugPrint("App cache cleared");
  }

  Dialog LogoutDialog(BuildContext context, String? msg, String? title) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 200.0,
          width: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  '${title}',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    '${msg}',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => MaterialButton(
                          onPressed: settingController.isProcess == true
                              ? null
                              : () {
                                  if (isLogin == true) {
                                    debugPrint("mytoken" + token);
                                    if (token != null) {
                                      goLogout();
                                    } else {}
                                  } else {}
                                  Navigator.of(context).pop();
                                },
                          child: Text("Ok"),
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                        color: Colors.green,
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }

  void askChangePassword() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Do you really want to change password?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              Navigator.pop(context, 'OK'),
              debugPrint("logout" + "Taped"),
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // startInstamojo() async {
  //   dynamic result = await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (ctx) => InstamojoScreen(
  //                 isLive: true,
  //                 body: CreateOrderBody(
  //                     buyerName: "dbtest",
  //                     buyerEmail: "dbvertexsharma@gmail.com",
  //                     buyerPhone: "+919424894244",
  //                     amount: "10",
  //                     description: "Real Payment"),
  //                 orderCreationUrl:
  //                     "https://www.instamojo.com/@Pearllinedentocare", // The sample server of instamojo to create order id.
  //               )));
  //
  //   setState(() {
  //     final _paymentResponse = result.toString();
  //     Utills().showSnackBar("Alert", _paymentResponse, true);
  //     debugPrint("instanew" + _paymentResponse);
  //   });
  // }

  void logout() async {
    var sp = await SharedPreferences.getInstance();
    util.startLoading();
    sp.remove("user_data").then((value) => {
          if (value == true)
            {
              clearAppCache().then((value) => {
                    util.stopLoading(),
                    Get.offAll(
                      () => Login(),
                    ),
                    settingController.isProcess(false)
                  }),
            }
          else
            {
              settingController.isProcess(false),
              util.stopLoading(),
              util.showSnackBar("Alert", "Something went wrong!", false),
            }
        });
  }

  goLogout() {
    settingController.isProcess(true);
    settingController.signOut(token).then((value) => {
          if (value == null) {settingController.isProcess(false)},
          debugPrint("logout" + "signout called"),
          debugPrint("logout" + "${token}"),
          logout()
        });

    // Get.to(ChangePassword(false, userid),
    //     duration: Duration(seconds: 1), transition: Transition.leftToRight);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    getUserData("user_data");
  }

  void getUserData(key) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      user_data = sp.getStringList(key) ?? [];

      // util.showSnackBar("userid", user_data[0].toString(), true);
      debugPrint("userdata" + user_data.toString());
      if (!user_data.isEmpty) {
        token = user_data[1].toString();
        userid = user_data[0].toString();
        debugPrint("logout" + user_data[1].toString());
        debugPrint("usertoken" + user_data[1].toString());
        isLogin = true;
      } else {
        debugPrint("logout" + "no data");
        isLogin = false;
      }

      // myuser= UserClass(
      //     userid,user_name,user_mail,user_phone
      // );
      // userid = user_data[0].toString();
      // user_name = user_data[1].toString();
      // user_mail = user_data[2].toString();
      // user_phone = user_data[3].toString();
    });
  }

  Dialog askDialog(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 200.0,
          width: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Select',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Please select image from:',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("CAMERA"),
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("GALLERY"),
                        color: Colors.blue,
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Setting",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Bounceable(
            onTap: () {
              debugPrint("Clicked");
              Get.offAll(() => MyHomePage(0));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image.asset(
                "assets/images/back_btn.png",
                width: 150,
                height: 150,
              ),
            ),
          ),
          // actions: [
          //   Icon(Icons.access_time_filled),
          // ],
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                      child: ListTile(
                    onTap: () {
                      //my profile

                      if (isLogin == false) {
                        Get.to(MyProfile());
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) =>
                        //         AppConstant.loginDialog(context));
                      } else {
                        // util.showSnackBar("Alert", this.isLogin.toString(), true);
                        Get.to(MyProfile());
                      }
                    },
                    leading: SvgPicture.asset(
                      'assets/images/profile_svg.svg',
                      semanticsLabel: 'My SVG Image',
                      height: 30,
                      width: 30,
                      color: Colors.green,
                    ),
//
                    title: Text(
                      "My Profile",
                      style: AppConstant.setting_text("My Profile", context),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  )),
                  Center(
                      child: ListTile(
                    onTap: () {
                      if (isLogin == false) {
                        Get.to(() => EditProfile());
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) =>
                        //         AppConstant.loginDialog(context));
                      } else {
                        Get.to(() => EditProfile());
                      }
                    },
                    leading: SvgPicture.asset(
                      'assets/images/edit_pro.svg',
                      semanticsLabel: 'My SVG Image',
                      height: 30,
                      width: 30,
                      color: Colors.green,
                    ),
                    title: Text(
                      "Edit Profile",
                      style: AppConstant.setting_text("My Profile", context),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  )),
                  //leave
                  Center(
                      child: ListTile(
                    onTap: () {
                      if (isLogin == false) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                AppConstant.loginDialog(context));
                      } else {
                        Get.to(Leave());
                        // util.showSnackBar("Alert", this.isLogin.toString(), true);
                      }
                    },
                    leading: SvgPicture.asset(
                      'assets/images/leave.svg',
                      semanticsLabel: 'My SVG Image',
                      height: 30,
                      width: 30,
                      color: Colors.green,
                    ),
//
                    title: Text(
                      "Apply for Leave",
                      style: AppConstant.setting_text("My Profile", context),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  )),
                  Center(
                      child: ListTile(
                    onTap: () {
                      //my profile

                      if (isLogin == false) {
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) =>
                        //         AppConstant.loginDialog(context));
                      } else {
                        Get.to(Resignation());

                        // util.showSnackBar("Alert", this.isLogin.toString(), true);
                      }
                    },
                    leading: SvgPicture.asset(
                      'assets/images/leave.svg',
                      semanticsLabel: 'My SVG Image',
                      height: 30,
                      width: 30,
                      color: Colors.green,
                    ),
//
                    title: Text(
                      "Apply for Resignation",
                      style: AppConstant.setting_text("My Profile", context),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  )),
                  Center(
                      child: ListTile(
                    onTap: () {
                      setState(() {
                        // settingController.getaboutus("getAboutUs");
                        Get.to(About(0, "About Us"));
                      });
                    },
                    leading: Icon(Icons.info_outline, color: Colors.green),
                    title: Text("About Us",
                        style: AppConstant.setting_text("About Us", context)),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  )),
                  Center(
                      child: ListTile(
                    onTap: () {
                      setState(() {
                        // util.showSnackBar("Alert", "tc", true);
                        Get.to(() => About(2, "T&C"));
                      });
                    },

                    //dev_guide.svg
                    leading: SvgPicture.asset(
                      'assets/images/contract.svg',
                      semanticsLabel: 'My SVG Image',
                      height: 30,
                      width: 30,
                      color: Colors.green,
                    ),
                    title: Text("T&C",
                        style: AppConstant.setting_text("T&C", context)),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  )),
                  Center(
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          // util.showSnackBar("Alert", "privacy", true);
                          Get.to(() => About(1, "Privacy"));
                        });
                      },
                      leading: SvgPicture.asset(
                        'assets/images/policy.svg',
                        semanticsLabel: 'My SVG Image',
                        height: 30,
                        width: 30,
                        color: Colors.green,
                      ),
                      title: Text("Privacy",
                          style: AppConstant.setting_text("Privacy", context)),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                  Center(
                      child: ListTile(
                    onTap: () {
                      if (isLogin == false) {
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) =>
                        //         AppConstant.loginDialog(context));
                        Get.to(() => ChangePassword());
                      } else {
                        Get.to(() => ChangePassword());
                      }
                    },
                    leading: Icon(
                      Icons.lock_open,
                      color: Colors.green,
                    ),

                    // SvgPicture.asset(
                    //   'assets/images/pass.svg',
                    //   semanticsLabel: 'My SVG Image',
                    //   height: 30,
                    //   width: 30,
                    //   color: Colors.green,
                    // ),
                    title: Text("Change Password",
                        style: AppConstant.setting_text(
                            "Change Password", context)),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: MyColor.LOGIN_TEXT_GREEN,
                    ),
                  )),
                  Visibility(
                      visible: true,
                      child: ListTile(
                        onTap: () {
                          //util.showSnackBar("Alert", "Will be upadte soon...", true);
                          Get.to(() => ConsumeChemicalList());
                        },

                        //contact.svg
                        leading: Icon(
                          Icons.receipt,
                          color: Colors.green,
                        ),
                        // SvgPicture.asset(
                        //   'assets/images/contact.svg',
                        //   semanticsLabel: 'My SVG Image',
                        //   height: 30,
                        //   width: 30,
                        //   color: Colors.green,
                        // ),
                        title: Text("Consume & Chemical list",
                            style: AppConstant.setting_text(
                                "Contact Us", context)),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      )),
                  Center(
                      child: ListTile(
                    onTap: () {
                      Get.to(() => ContactUs(
                            isLogin: true,
                          ));
                    },

                    //contact.svg
                    leading: SvgPicture.asset(
                      'assets/images/contact.svg',
                      semanticsLabel: 'My SVG Image',
                      height: 30,
                      width: 30,
                      color: Colors.green,
                    ),
                    title: Text("Contact Us",
                        style: AppConstant.setting_text("Contact Us", context)),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  )),
                  Bounceable(
                    onTap: () {
                      if (isLogin == false) {
                        Get.to(Login());
                      } else {
                        showDialog(
                            context: context,
                            builder: (c) => LogoutDialog(context,
                                "Do you really want to Logout?", "Logout"));
                      }
                    },
                    child: Center(
                      child: Container(
                        width: 235,
                        height: 57,
                        margin:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color: Color(0xFF578A48), width: 0.5)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout,
                                color: MyColor.LOGIN_TEXT_GREEN,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(isLogin == true ? "Logout" : "Login",
                                  style: AppConstant.setting_text(
                                      "LOG OUT", context)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
