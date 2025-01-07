import 'package:testingevergreen/pages/Consume_Chemical_list/ConsumeChemicallist.dart';
import 'package:testingevergreen/pages/SE/fillform.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:testingevergreen/pages/SV/addNewReportSV/fill_new_form_sv.dart';
import 'package:testingevergreen/pages/SV/svController/sv_form_one_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';

import 'package:testingevergreen/pages/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';

import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';
// import 'package:app_settings/app_settings.dart';

// import '../../Utills/utills.dart';
import '../../Utills3/utills.dart';
import '../../appconstants/appconstants.dart';
import '../../appconstants/mycolor.dart';
import '../../getXNetworkManager.dart';
import '../dashboard/dashboard.dart';
import '../settings/settings.dart';

class MyHomePage extends StatefulWidget {
  var current_index = 0;
  var _isLogin = false;

  MyHomePage(int? _cindex, [bool? isLogin = false]) {
    current_index = _cindex!;
    this._isLogin = isLogin!;
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState(current_index, _isLogin);
}

class _MyHomePageState extends State<MyHomePage> {
  var current_index = 0;
  var _isLogin = false;

  final TAG = "MyHomePageDebug";

  _MyHomePageState(int _cindex, [bool? isLogin = false]) {
    current_index = _cindex;
    pageIndex = _cindex;
    _isLogin = isLogin!;
  }

  DashboardController dashboardController = Get.find();
  static var currentTab = 0;

  var pageIndex = 0;
  var user_data = [];
  // final _checker = AppVersionChecker();
  var userid = "";
  var isLogin = false;
  var user_pic = "";
  var user_role = "";
  var user_token = "";
  final util = Utills();
  final _networkManager = Get.find<GetXNetworkManager>();
  SvFormOneController svFormOneController = Get.find();

  // DashboardController _dashboardController = Get.find();

  var nav_Screens = <Widget>[
    Dashboard(),
  ];
  var page_no = 0;

  void openBottomSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      SafeArea(
        child: Container(
          height: MediaQuery.of(Get.context!).size.height - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.close)),
                  )),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Text("No data found!!"),
              )
              //PageView(
              //                   children: [Formone(pageNo: 0), FormTwo(), FormThree()],
              //
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
    );
  }

  @override
  void dispose() {


    debugPrint("disposecalled:" "disposecalledddd");
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkVersion();
    AppConstant.getUserData("user_data").then((value) => {
          if (value!.user_id != null)
            {
              setState(() {
                userid = value.user_id;
                user_pic = value.user_pic;
                user_role = value.user_role;
                user_token = value.user_token;
                isLogin = true;
              }),
              if (user_token.isNotEmpty)
                {
                  dashboardController.user_token.value =
                      value!.user_token.toString(),
                  debugPrint(
                      "njtoken" "${dashboardController.user_token.value}"),
                  setState(() {
                    dashboardController.userpic.value=user_pic;

                  }),
                  if (value.user_role == "super_engineer")
                    {
                      dashboardController
                          .seHomeReport(dashboardController.user_token.value,
                              dashboardController.currentSiteID!.value)
                          .then((value) => {}),
                    },

                }
            }
          else
            {
              util.showSnackBar("alert", "no user id", true),
            }
        });
    setState(() {
      pageIndex = current_index;
    });
  }

  Dialog errorDialog(BuildContext context) {
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
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'You need to login first!',
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
                          //Get.to(const Login());
                        },
                        child: Text("Ok"),
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Cancel"),
                        color: Colors.blue,
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }

  void checkVersion() async {
    var local_ver = "";
    var pub_ver = "";
    var can_upadte = false;
    Map<String, dynamic> myPackageData = {};
    await PackageInfo.fromPlatform().then((value) {
      if (value != null) {
        debugPrint("njdebug from pub ${value.version}");
        local_ver = value.version;
      }
    });
    // await _checker.checkUpdate().then((value) {
    //   if (value != null) {
    //     debugPrint(
    //         "njdebug ${value.canUpdate}"); //return true if update is available
    //     debugPrint(
    //         "njdebug ${value.currentVersion}"); //return current app version
    //     debugPrint("njdebug ${value.newVersion}"); //return the new app version
    //     debugPrint("njdebug ${value.appURL}"); //return the app url
    //     debugPrint("njdebug ${value.errorMessage}");
    //     pub_ver = value.currentVersion;
    //     if (value.canUpdate) {
    //       Get.bottomSheet(
    //         GestureDetector(
    //           onTap: () {},
    //           // Prevents taps from closing the bottom sheet
    //           onVerticalDragStart: (_) {},
    //           // Prevents vertical drags from starting
    //           behavior: HitTestBehavior.opaque,
    //           child: Container(
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(20.0),
    //                 topRight: Radius.circular(20.0),
    //               ),
    //             ),
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: <Widget>[
    //                 ListTile(
    //                   title: Text('New Version Available'),
    //                   onTap: () async {
    //                     await _launchPlayStore();
    //                     Get.back(); // Close the bottom sheet
    //                   },
    //                   trailing: Text(
    //                     'Update',
    //                     style: TextStyle(
    //                       decoration: TextDecoration.underline,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         isDismissible: false,
    //         isScrollControlled: false,
    //       );
    //     }
    //   }
    // });
  }


  _launchPlayStore() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.tobuu.tobuu&pcampaignid=web_share';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetXNetworkManager>(builder: (builder) {
      if (_networkManager.connectionType == 0) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.signal_cellular_nodata_sharp,
                size: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "No Active Network Found!!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // FloatingActionButton.extended(
              //   onPressed: () {
              //     AppSettings.openAppSettingsPanel(
              //         AppSettingsPanelType.internetConnectivity);
              //   },
              //   label: Text("Setting"),
              // )
            ],
          ),
        );
      }

      return OverlaySupport(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            floatingActionButton: Visibility(
              visible: true,
              child: SizedBox(
                width: 80,
                height: 80,
                child: FittedBox(
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        if (isLogin == false) {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  AppConstant.loginDialog(context));
                        } else {
                          if (user_role != null && user_role == "supervisor") {

                            // svFormOneController
                            //     .getSvsites(dashboardController.user_token.value)
                            //     .then((sitevalue) => {
                            //   dashboardController.currentSiteID!.value =
                            //       sitevalue!.first.sites.first.id,
                            //   dashboardController.currentSiteID!
                            //       .refresh(),
                            // });
                            //
                            // dashboardController.currentSiteID!.refresh();
                            Get.to(() => ConsumeChemicalList());
                          } else {
                            if (dashboardController
                                .lastSubmittedReport.value.isNotEmpty) {
                              util.showSnackBar(
                                  "Alert", "Report Already created!", false);
                            } else {
                              Get.to(() => FillForm(
                                    siteID:
                                        '${dashboardController.currentSiteID!.value}',
                                  ));
                            }
                          }
                          //openBottomSheet();
                        }

                        // pageIndex=4;
                      });
                    },
                    child: const Icon(Icons.add),
                    backgroundColor: MyColor.LOGIN_TEXT_GREEN,
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: nav_Screens[pageIndex],
            bottomNavigationBar: Visibility(
              maintainState: true,
              maintainAnimation: false,
              maintainSize: false,
              maintainSemantics: false,
              maintainInteractivity: false,
              visible: pageIndex == 3 ? false : true,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [
                      MyColor.BOTTOM_NAVI_COLOR1,
                      MyColor.BOTTOM_NAVI_COLOR2,
                      MyColor.BOTTOM_NAVI_COLOR1
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: BottomAppBar(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 70,
                  shape: const CircularNotchedRectangle(),
                  notchMargin: 15,
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                pageIndex = 0;
                                currentTab = 0;
                                _networkManager.currentIndex.value = 0;

                                if (isLogin) {
                                  // pageIndex = 4;
                                  // currentTab = 3;
                                  // _networkManager.currentIndex.value = 3;
                                  Get.to(MyProfile());
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          AppConstant.loginDialog(context));
                                }
                              });
                            },
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [Colors.red, Colors.orange],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 14),
                                width: 50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.profile_circled,
                                      color: Colors.pink,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Visibility(
                                        visible: false,
                                        child: SizedBox(
                                          child: Container(
                                            color: Colors.white,
                                          ),
                                          height: 5,
                                          width: 20,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //people_icon.png

                          InkWell(
                            onTap: () {
                              setState(() {
                                if (isLogin) {
                                  // pageIndex = 4;
                                  // currentTab = 3;
                                  // _networkManager.currentIndex.value = 3;
                                  Get.to(Setting("home"));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          AppConstant.loginDialog(context));
                                }
                              });
                            },
                            child: Container(
                              width: 50,
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width / 14),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Icon(CupertinoIcons.settings),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Visibility(
                                      visible:
                                          _networkManager.currentIndex.value ==
                                                  3
                                              ? true
                                              : false,
                                      child: SizedBox(
                                        child: Container(
                                          color: Colors.white,
                                        ),
                                        height: 5,
                                        width: 20,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      );
    });
  }
}
