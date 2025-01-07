import 'dart:io';

import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';

// import '../../Utills/universal.dart';
// import '../../Utills/utills.dart';

import 'package:get/get.dart';

import '../../Utills3/universal.dart';
import '../../Utills3/utills.dart';
import '../../appconstants/appconstants.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../appconstants/mycolor.dart';

import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../../controller/notificationcontroller.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({Key? key}) : super(key: key);

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  File? fimage1 = null;
  final util = Utills();
  var f_sel = "My Subscriber";
  var video_data = true;
  var pageBucket = PageStorageBucket();
  var _isLoading = false;
  var sel = [
    "My Subscriber",
    "Subscription Request",
  ];
  var isLogin = false;
  var user_data = [];

  var userid = "";
  var token = "";
  var userpic = "";
  bool no_data = true;

  NotificationController notificationController = Get.find();
  DashboardController _dashboardController = Get.find();

  // FriendsController friendsController = Get.find();

  Dialog errorDialog(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 472.0,
          width: 372.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(13),
                        topRight: Radius.circular(13)),
                  ),
                  child: Center(
                    child: Text(
                      'Hooray',
                      style: GoogleFonts.aladin(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: AppConstant.HEADLINE_SIZE_50,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: MyColor.LOGIN_TEXT_GREEN),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  child: Divider(
                    color: Colors.grey,
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 59,
                width: 69,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //
                    // BoxShadow
                  ],
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/icon_hooray.png")),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 48.00, right: 48.00, top: 48.00),
                child: Text(
                  '${AppConstant.TEXT_HOORAY}',
                  style: GoogleFonts.aladin(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: AppConstant.HEADLINE_SIZE_25,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: MyColor.LOGIN_TEXT_GREEN),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20.0)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 110,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: MyColor.LOGIN_TEXT_GREEN, width: 0.5)),
                          child: Center(
                            child: Text("Review",
                                style: TextStyle(
                                  color: MyColor.LOGIN_TEXT_GREEN,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 110,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: MyColor.LOGIN_TEXT_GREEN, width: 0.5)),
                          child: Center(
                            child: Text("OK",
                                style: TextStyle(
                                  color: MyColor.LOGIN_TEXT_GREEN,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }

  void getUserData(key) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      user_data.clear();
      user_data = sp.getStringList(key) ?? [];
      if (!user_data.isEmpty) {
        userid = user_data[0].toString();
        token = user_data[1].toString();

        if (userpic.isNotEmpty &&
            userpic.toString() == AppConstant.DEFAULT_BACKEND_IMG) {
          userpic = "";
        } else {
          userpic = user_data[5].toString();
        }
        debugPrint("userimg" + userpic);
        debugPrint("mytoken" + token);
        debugPrint("mytokensaved" + AppConstant.take_data("token"));
        isLogin = true;
      } else {
        isLogin = false;
      }
      debugPrint("islogin ${isLogin}");

      //  util.showSnackBar("alert", userpic, true);
    });

    // videoscrollController.addListener(() {
    //   double center = videoscrollController.position.viewportDimension / 2;
    //   int index = (videoscrollController.offset + center) ~/ 194; // Assuming item width is 194
    //
    //   if (index >= 0 &&
    //       index < _dashboardController.allTrendingVideosList.value.length) {
    //     shouldPlayVideo.value = true;
    //     debugPrint("video scroll"+ "should play");
    //
    //   } else {
    //     shouldPlayVideo.value = false;
    //     debugPrint("video scroll"+ "should not play");
    //   }
    // });
  }

  Future<void> resetRedDot() async {
    Future.delayed(Duration(milliseconds: 200), () {
      _dashboardController.setRedDot(false);
    });
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      resetRedDot();
      notificationController
          .getNotificationsList(_dashboardController.user_token.value)
          .then((value) => {
                if (value == true)
                  {
                    setState(() {
                      _isLoading = false;
                      notificationController.setDot.value = false;
                    })
                  }
                else
                  {
                    setState(() {
                      _isLoading = false;
                      notificationController.setDot.value = false;
                    })
                  }
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: PageStorage(
        bucket: pageBucket,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            backToolbar(
              name: "Notification",
            ),
          Obx(() =>   Expanded(
              child: no_data == false||notificationController.noData.value==true
                  ? Container(
                child: Center(
                  child: Text("No notifications found!!"),
                ),
              )
                  : Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: _isLoading == true
                      ? AppConstant.getShimmer()
                      : Obx(() => ListView.builder(
                    itemBuilder: (c, i) {
                      return Bounceable(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.2), // Shadow color
                                  spreadRadius:
                                  1, // Spread radius
                                  blurRadius: 5, // Blur radius
                                  offset: Offset(0,
                                      5), // Shadow position (horizontal, vertical)
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                              "${notificationController.getNotificationlist.value[i]!.type == "Daily_report_update" ? "Daily report" : notificationController.getNotificationlist.value[i]!.type == "User_active_status" ? "Admin" : "" ?? "Unknown"}",
                                              style: AppConstant
                                                  .getRoboto(
                                                  FontWeight
                                                      .w500,
                                                  AppConstant
                                                      .HEADLINE_SIZE_18,
                                                  Color(
                                                      0xff265B3A))),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.green,width: 0.1),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Image.network(
                                        "${notificationController.getNotificationlist.value[i]!.sender.pic}",fit: BoxFit.cover,
                                        scale: 5,
                                        errorBuilder: (i, c, e) {
                                          return Image.asset("assets/images/logo_small1.png",scale: 5,fit: BoxFit.cover,);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Expanded(

                                      child:Container (
                                        width: 200,
                                        child: Text(
                                          textAlign:
                                          TextAlign.left,
                                          "${notificationController.getNotificationlist.value[i]!.message ?? "No message"}",
                                          style: AppConstant
                                              .getRoboto(
                                              FontWeight.w300,
                                              AppConstant
                                                  .HEADLINE_SIZE_14,
                                              Colors.green),
                                        ),
                                      ),
                                    ),
                                    Text(
                                        "${notificationController.getNotificationlist.value[i]!.date}",
                                        style: AppConstant.getPopins(
                                            FontWeight.w500,
                                            AppConstant
                                                .HEADLINE_SIZE_11,
                                            Colors.black54))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    key: PageStorageKey<String>('notification'),
                    itemCount: notificationController
                        .getNotificationlist.value.length,
                  )))),),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    ));
  }
}
