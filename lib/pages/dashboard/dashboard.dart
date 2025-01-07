import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testingevergreen/pages/SV/addNewReportSV/fill_new_form_sv.dart';
import 'package:intl/intl.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:testingevergreen/pages/SE/edit_report_se/edit_fill_form_se.dart';
import 'package:testingevergreen/pages/SE/se_attendace.dart';
import 'package:testingevergreen/pages/SE/se_controller.dart';
import 'package:testingevergreen/pages/SV/editReportSv/edit_fill_form_sv.dart';
import 'package:testingevergreen/pages/SV/svController/sv_form_one_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:testingevergreen/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

// import '../../Utills/universal.dart';
// import '../../Utills/utills.dart';
import '../../Utills3/universal.dart';
import '../../Utills3/utills.dart';
import '../../getXNetworkManager.dart';
import '../../main.dart';
import '../attendance/take_selfi.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  bool? _isLogin = false;

  Dashboard([bool? isLogin = false]) {
    this._isLogin = isLogin;
  }

  @override
  State<Dashboard> createState() => _DashboardState(_isLogin!);
}

class _DashboardState extends State<Dashboard> {
  bool? _isLogin = false;

  _DashboardState(bool? isLogin) {
    this._isLogin = isLogin;
  }

  ScrollController btnController = ScrollController();
  bool no_data = true;
  final TAG = "dashboardDebug";
  String? myuserid;
  Timer? timer;
  List<String> parts = [];
  var user_data = [];
  var userid = "";
  var submitedBy = "";
  var dateOfsite = "";
  var siteName = "";
  var token = "";
  var user_pic = "";
  var cuurent_site_id = "";
  var newNotification = false;
  var isLogin = false;
  var current_index = 0;
  var util = Utills();
  var currentCategoryID = "";

  String _locationMessage = "Getting location...";
  ScrollController videoscrollController = ScrollController();
  SEController svController = Get.find();
  DashboardController dashboardController = Get.find();
  DashboardController _dashboardController = Get.find();
  ProfileController _profileController = Get.find();
  var mylist = [];
  SvFormOneController svFormOneController = Get.find();
  final pageBucket = PageStorageBucket();

  final _networkManager = Get.find<GetXNetworkManager>();
  final listOfStatus = [
    "Rejected",
    "Accepted",
    "Visited",
    "Accepted",
    "Accepted"
  ];

  getNotifty() {
    Get.defaultDialog(
        radius: 20,
        contentPadding: EdgeInsets.all(20),
        title: "Alert",
        content: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("content"),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Cancel"),
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Ok"),
                    color: Colors.red,
                  ),
                ],
              )
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

        setState(() {
          isLogin = true;
          AppConstant.getUserData("userdata").then((value) => {
                if (value != null)
                  {debugPrint(TAG + "${value!.user_token.toString()}")}
              });
        });

        debugPrint(TAG + "${user_data.toString()}");
      } else {
        isLogin = false;
      }
    });
  }

  init() {
    AppConstant.getUserData("user_data").then((value) => {
          if (value != null)
            {
              debugPrint(TAG + "not nul user data"),
              dashboardController.user_role.value = value.user_role,
              userid = value.user_id,
              token = value.user_token,
              dashboardController.user_token.value = value.user_token,
              dashboardController.user_token.refresh(),
              isLogin = true,
              user_pic = value.user_pic,
              dashboardController.userName.value = value.user_name,
              dashboardController.userName.refresh(),
              dashboardController.user_token.value =
                  value.user_token.toString(),
              debugPrint("userpic" + user_pic),
              _profileController.getProfile(token).then((provalue) => {
                    if (provalue!.user != null)
                      {
                        debugPrint(TAG + "profile data not null"),
                        setState(() {
                          if (provalue.user.role == "supervisor") {
                            debugPrint("cuser:" + "supervisor");
                            svFormOneController
                                .getSvsites(value.user_token)
                                .then((sitevalue) => {
                                      dashboardController.currentSiteID!.value =
                                          sitevalue!.first.sites.first.id,
                                      dashboardController.currentSiteID!
                                          .refresh(),
                                    });
                          }

                          user_pic = provalue!.user.pic;
                          if (provalue.user.siteId.first.isNotEmpty) {
                            dashboardController.currentSiteID!.value =
                                provalue.user.siteId.first.toString();
                            dashboardController.currentSiteID!.refresh();

                            debugPrint("siteidcurrent" +
                                "${dashboardController.currentSiteID!.value}");

                            dashboardController
                                .seHomeReport(value.user_token,
                                    "${dashboardController.currentSiteID!.value}")
                                .then((homeres) {
                              submitedBy = homeres!.submittedBy.fullName;
                              dateOfsite = homeres.date;
                              siteName = homeres.siteId.siteName;
                              setState(() {});
                            });
                          }

                          dashboardController
                              .fetchDateTime()
                              .then((value) => {if (value != null) {}});
                          debugPrint("siteidcurrent::" +
                              "${dashboardController.currentSiteID!}");
                        }),
                      }
                    else
                      {
                        util.showSnackBar('Alert', "no user found", false),
                        debugPrint(TAG + "profile datt null"),
                      }
                  }),
            }
          else
            {
              debugPrint(TAG + " null usrdata"),
              setState(() {
                isLogin = false;
              })
            }
        });
  }

  @override
  void initState() {
    super.initState();

    init();

    debugPrint("savedtoken:" + AppConstant.take_data("token"));
    debugPrint("dashboardpage:called");
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void checkTime() {
    // Define the start and end times
    String startTime = "10:00 AM";
    String endTime = "08:00 PM";

    // Get the current time
    DateTime now = DateTime.now();
    String currentTime = DateFormat("hh:mm a").format(now);

    // Parse the times
    DateFormat dateFormat = DateFormat("hh:mm a");
    DateTime start = dateFormat.parse(startTime);
    DateTime end = dateFormat.parse(endTime);
    DateTime current = dateFormat.parse(currentTime);

    // Adjust date to today
    start = DateTime(now.year, now.month, now.day, start.hour, start.minute);
    end = DateTime(now.year, now.month, now.day, end.hour, end.minute);
    current =
        DateTime(now.year, now.month, now.day, current.hour, current.minute);

    // Check if the current time is NOT between startTime and endTime
    if (current.isBefore(start) || current.isAfter(end)) {
      debugPrint(
          "The current time${currentTime} is NOT between the specified range.");
      dashboardController.isSubmitTimeRange.value = false;
      dashboardController.isSubmitTimeRange.refresh();
    } else {
      debugPrint(
          "The current timetime${currentTime} is between the specified range.");
      dashboardController.isSubmitTimeRange.value = true;
      dashboardController.isSubmitTimeRange.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text("Double tap to exit the app"),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            init();
            return getUserData("user_data");
          },
          child: Center(
            child: PageStorage(
              bucket: pageBucket,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TopToolbar(0, false, "${user_pic}")),
                    Obx(() => Expanded(
                        child: svController.noDataFound.value == true
                            ? Center(
                                child: Text("No data"),
                              )
                            : dashboardController.user_role.value ==
                                    "supervisor"
                                ? Obx(() => Expanded(
                                      child: ListView.builder(
                                        itemBuilder: (c, i) {
                                          return InkWell(
                                            onTap: () {
                                              // "${svFormOneController.svsiteList.value[i].sites[0].siteName.capitalizeFirst}"
                                              Get.dialog(Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  height: 150,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "${svFormOneController.svsiteList?.value[i].sites[0].siteName}",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    "Submitted By:",
                                                                style: GoogleFonts.roboto(
                                                                    fontWeight: FontWeight.w700,
                                                                    color: Colors.black),
                                                                children: [
                                                                  TextSpan(
                                                                      text:
                                                                          "${svFormOneController.svsiteList.value[i].sites[0].reportSubmit?.fullName}",
                                                                      style: GoogleFonts.roboto(
                                                                          fontWeight: FontWeight.w500,
                                                                          color: Colors.black)),
                                                                ],
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                          FutureBuilder(
                                                              future:
                                                                  fetchUserData(),
                                                              builder: (context,
                                                                  snapshot) {
                                                                return Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      // "S.Eng. : ${snapshot.data?['full_name'] ?? "Wanting."}",
                                                                      "S.Eng. : ${svFormOneController.svsiteList?.value[i].sites[0].reportSubmit?.fullName ?? "Not Upated"}",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      // Handle text overflow
                                                                      maxLines:
                                                                          1,
                                                                    )
                                                                  ],
                                                                );
                                                              }),
                                                          // Flexible(
                                                          //   child: RichText(
                                                          //     text: TextSpan(
                                                          //       text:
                                                          //           "Submitted By : ",
                                                          //       style: GoogleFonts
                                                          //           .roboto(
                                                          //         fontWeight:
                                                          //             FontWeight
                                                          //                 .w700,
                                                          //         color: Colors
                                                          //             .black,
                                                          //       ),
                                                          //       children: [
                                                          //         TextSpan(
                                                          //           text:
                                                          //               "${svFormOneController.svsiteList.value[i].sites[0].reportSubmit?.fullName ?? 'N/A'}",
                                                          //           style:
                                                          //               GoogleFonts
                                                          //                   .roboto(
                                                          //             fontWeight:
                                                          //                 FontWeight
                                                          //                     .w500,
                                                          //             color: Colors
                                                          //                 .black,
                                                          //           ),
                                                          //         ),
                                                          //       ],
                                                          //     ),
                                                          //     overflow:
                                                          //         TextOverflow
                                                          //             .ellipsis,
                                                          //     // Handle text overflow
                                                          //     maxLines:
                                                          //         1, // Limit to a single line
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                      AppConstant.getTapButton(
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          "OK",
                                                          60,
                                                          30, () {
                                                        Get.back();
                                                      },
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100))
                                                    ],
                                                  ),
                                                ),
                                              ));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0, right: 16.0),
                                              child: Card(
                                                elevation: 1.0,
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.grey.shade50,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: 150,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "${svFormOneController.svsiteList.value[i].sites[0].siteName.capitalizeFirst}",
                                                                  style: AppConstant.getRoboto(
                                                                      FontWeight
                                                                          .w800,
                                                                      AppConstant
                                                                          .HEADLINE_SIZE_22,
                                                                      Colors
                                                                          .black),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                Visibility(
                                                                  visible: dashboardController
                                                                              .user_role ==
                                                                          "super_engineer"
                                                                      ? false
                                                                      : true,
                                                                  child:
                                                                      Bounceable(
                                                                    onTap: () {
                                                                      dashboardController.currentSiteID!.value = svFormOneController
                                                                          .svsiteList
                                                                          .value[
                                                                              i]
                                                                          .sites[
                                                                              0]
                                                                          .id;
                                                                      dashboardController
                                                                          .currentSiteID!
                                                                          .refresh();
                                                                      Get.to(
                                                                          () =>
                                                                              Take_Selfie(),
                                                                          curve: Curves
                                                                              .fastOutSlowIn,
                                                                          duration:
                                                                              Duration(milliseconds: 1000));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              4),
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .transparent,
                                                                      ),
                                                                      child: Image
                                                                          .asset(
                                                                              "assets/images/selfie.png"),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            "${svFormOneController.svsiteList.value[i].sites[0].startDate}",
                                                            style: AppConstant
                                                                .getRoboto(
                                                                    FontWeight
                                                                        .w500,
                                                                    AppConstant
                                                                        .HEADLINE_SIZE_20,
                                                                    Color(
                                                                        0xff53C17F)),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      FutureBuilder(
                                                        future: fetchUserData(),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Submitted By:",
                                                                    style: AppConstant
                                                                        .getRoboto(
                                                                      FontWeight
                                                                          .w500,
                                                                      AppConstant
                                                                          .HEADLINE_SIZE_20,
                                                                      Color(
                                                                          0xff33272A),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Waiting...",
                                                                    style: AppConstant
                                                                        .getRoboto(
                                                                      FontWeight
                                                                          .w500,
                                                                      AppConstant
                                                                          .HEADLINE_SIZE_20,
                                                                      Color(
                                                                          0xff868686),
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    // Handle text overflow
                                                                    maxLines: 1,
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }

                                                          if (snapshot
                                                                  .hasError ||
                                                              snapshot.data ==
                                                                  null) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Submitted By:",
                                                                  style: AppConstant
                                                                      .getRoboto(
                                                                    FontWeight
                                                                        .w500,
                                                                    AppConstant
                                                                        .HEADLINE_SIZE_20,
                                                                    Color(
                                                                        0xff33272A),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "Error loading data",
                                                                  style: AppConstant
                                                                      .getRoboto(
                                                                    FontWeight
                                                                        .w500,
                                                                    AppConstant
                                                                        .HEADLINE_SIZE_20,
                                                                    Color(
                                                                        0xff868686),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }

                                                          // Extract user data safely
                                                          final userData =
                                                              snapshot.data!;
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Submitted By:",
                                                                style: AppConstant
                                                                    .getRoboto(
                                                                  FontWeight
                                                                      .w500,
                                                                  AppConstant
                                                                      .HEADLINE_SIZE_20,
                                                                  Color(
                                                                      0xff33272A),
                                                                ),
                                                              ),
                                                              Text(
                                                                userData[
                                                                        'full_name'] ??
                                                                    "Wanting.",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppConstant
                                                                    .getRoboto(
                                                                  FontWeight
                                                                      .w500,
                                                                  AppConstant
                                                                      .HEADLINE_SIZE_20,
                                                                  Color(
                                                                      0xff868686),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                      Obx(
                                                        () => Visibility(
                                                          visible: dashboardController
                                                                      .user_role
                                                                      .value ==
                                                                  "super_engineer"
                                                              ? false
                                                              : true,
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        8),
                                                            child:
                                                                FutureBuilder(
                                                                    future:
                                                                        fetchUserData(),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      return Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "S.Eng:",
                                                                            style: AppConstant.getRoboto(
                                                                                FontWeight.w500,
                                                                                AppConstant.HEADLINE_SIZE_20,
                                                                                Color(0xff33272A)),
                                                                          ),
                                                                          Text(
                                                                            // svFormOneController.svsiteList.value[i].sites[0].reportSubmit?.fullName ?? "Not Updated",
                                                                            // "${_dashboardController.userName.value.capitalizeFirst ?? "User"}",
                                                                            "${snapshot.data?['full_name'] ?? "Wanting."}",
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: AppConstant.getRoboto(
                                                                                FontWeight.w500,
                                                                                AppConstant.HEADLINE_SIZE_20,
                                                                                Color(0xff868686)),
                                                                          )
                                                                        ],
                                                                      );
                                                                    }),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      SingleChildScrollView(
                                                        controller:
                                                            btnController,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  bottom: AppConstant
                                                                      .SMALL_TEXT_SIZE),
                                                              child: Bounceable(
                                                                onTap: () {
                                                                  Get.to(() => SEAttendance(
                                                                      siteid: svFormOneController
                                                                          .svsiteList
                                                                          .value[
                                                                              i]
                                                                          .sites[
                                                                              0]
                                                                          .id
                                                                          .toString()));
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    gradient:
                                                                        AppConstant
                                                                            .BUTTON_COLOR,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                  ),
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.00),
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          5.00,
                                                                      bottom:
                                                                          8.00,
                                                                      top: 8.00,
                                                                      right:
                                                                          5.00),
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.2,
                                                                  height: AppConstant
                                                                      .BUTTON_DAHBOARD_HIGHT,
                                                                  child: Center(
                                                                    child: Text(
                                                                        AppConstant
                                                                            .Button_Text_Attendance,
                                                                        style: AppConstant.Dashboard_text(
                                                                            AppConstant.Button_Text_Attendance,
                                                                            context,
                                                                            AppConstant.HEADLINE_SIZE_11)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  bottom: AppConstant
                                                                      .SMALL_TEXT_SIZE),
                                                              child: Bounceable(
                                                                onTap: () {
                                                                  debugPrint(
                                                                      "siteid::${svFormOneController.svsiteList.value[i].sites[0].id.toString()}");
                                                                  dashboardController
                                                                          .currentSiteID!
                                                                          .value =
                                                                      svFormOneController
                                                                          .svsiteList
                                                                          .value[
                                                                              i]
                                                                          .sites[
                                                                              0]
                                                                          .id;
                                                                  dashboardController
                                                                      .currentSiteID!
                                                                      .refresh();
                                                                  Get.to(() => EditFillFormSV(
                                                                      siteID: svFormOneController
                                                                          .svsiteList
                                                                          .value[
                                                                              i]
                                                                          .sites[
                                                                              0]
                                                                          .id
                                                                          .toString()));
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    gradient:
                                                                        AppConstant
                                                                            .BUTTON_COLOR,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                  ),
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.00),
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          5.00,
                                                                      vertical:
                                                                          5.00),
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.2,
                                                                  height: AppConstant
                                                                      .BUTTON_DAHBOARD_HIGHT,
                                                                  child: Center(
                                                                    child: Text(
                                                                        "Edit",
                                                                        style: AppConstant.Dashboard_text(
                                                                            AppConstant.Button_Text_View,
                                                                            context,
                                                                            AppConstant.HEADLINE_SIZE_11)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  bottom: AppConstant
                                                                      .SMALL_TEXT_SIZE),
                                                              child: Bounceable(
                                                                onTap: () {
                                                                  debugPrint(
                                                                      "siteid::${svFormOneController.svsiteList.value[i].sites[0].id.toString()}");
                                                                  dashboardController
                                                                          .currentSiteID!
                                                                          .value =
                                                                      svFormOneController
                                                                          .svsiteList
                                                                          .value[
                                                                              i]
                                                                          .sites[
                                                                              0]
                                                                          .id;
                                                                  dashboardController
                                                                      .currentSiteID!
                                                                      .refresh();
                                                                  Get.to(() => FillFormNewSV(
                                                                      siteID: svFormOneController
                                                                          .svsiteList
                                                                          .value[
                                                                              i]
                                                                          .sites[
                                                                              0]
                                                                          .id
                                                                          .toString()));
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    gradient:
                                                                        AppConstant
                                                                            .BUTTON_COLOR,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                  ),
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.00),
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          5.00,
                                                                      vertical:
                                                                          5.00),
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.2,
                                                                  height: AppConstant
                                                                      .BUTTON_DAHBOARD_HIGHT,
                                                                  child: Center(
                                                                    child: Text(
                                                                        "Add",
                                                                        style: AppConstant.Dashboard_text(
                                                                            AppConstant.Button_Text_View,
                                                                            context,
                                                                            AppConstant.HEADLINE_SIZE_11)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        key: UniqueKey(),
                                        itemCount: svFormOneController
                                            .svsiteList.value.length,
                                      ),
                                    ))
                                : Obx(() {
                                    if (dashboardController.noreport.value ==
                                        true) {
                                      return Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/nodata.jpg",
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text("No report found!"),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            FloatingActionButton(
                                              onPressed: () {
                                                init();
                                              },
                                              child: Icon(
                                                Icons.refresh,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      return ListView.builder(
                                        itemBuilder: (c, i) {
                                          return InkWell(
                                            onTap: () {
                                              debugPrint("njjj" + "click");
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0, right: 16.0),
                                              child: Card(
                                                elevation: 1.0,
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.grey.shade50,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    siteName.capitalizeFirst! ??
                                                                        "Unknown"
                                                                            .capitalizeFirst!,
                                                                    style: AppConstant.getRoboto(
                                                                        FontWeight
                                                                            .w800,
                                                                        AppConstant
                                                                            .HEADLINE_SIZE_22,
                                                                        Colors
                                                                            .black),
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                                Visibility(
                                                                  visible: dashboardController
                                                                              .user_role ==
                                                                          "super_engineer"
                                                                      ? false
                                                                      : true,
                                                                  child:
                                                                      Bounceable(
                                                                    onTap: () {
                                                                      Get.to(
                                                                          () =>
                                                                              Take_Selfie(),
                                                                          curve: Curves
                                                                              .fastOutSlowIn,
                                                                          duration:
                                                                              Duration(milliseconds: 1000));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              4),
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .transparent,
                                                                      ),
                                                                      child: Image
                                                                          .asset(
                                                                              "assets/images/selfie.png"),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            dateOfsite,
                                                            style: AppConstant
                                                                .getRoboto(
                                                                    FontWeight
                                                                        .w500,
                                                                    AppConstant
                                                                        .HEADLINE_SIZE_20,
                                                                    Color(
                                                                        0xff53C17F)),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      FutureBuilder(
                                                        future: fetchUserData(),
                                                        // Ensure fetchUserData returns Future<Map<String, dynamic>>
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Submitted By:",
                                                                  style: AppConstant
                                                                      .getRoboto(
                                                                    FontWeight
                                                                        .w500,
                                                                    AppConstant
                                                                        .HEADLINE_SIZE_20,
                                                                    Color(
                                                                        0xff33272A),
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child: Text(
                                                                    "Waiting...",
                                                                    style: AppConstant
                                                                        .getRoboto(
                                                                      FontWeight
                                                                          .w500,
                                                                      AppConstant
                                                                          .HEADLINE_SIZE_20,
                                                                      Color(
                                                                          0xff868686),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }

                                                          if (snapshot
                                                                  .hasError ||
                                                              snapshot.data ==
                                                                  null) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Submitted By:",
                                                                  style: AppConstant
                                                                      .getRoboto(
                                                                    FontWeight
                                                                        .w500,
                                                                    AppConstant
                                                                        .HEADLINE_SIZE_20,
                                                                    Color(
                                                                        0xff33272A),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "Error loading data",
                                                                  style: AppConstant
                                                                      .getRoboto(
                                                                    FontWeight
                                                                        .w500,
                                                                    AppConstant
                                                                        .HEADLINE_SIZE_20,
                                                                    Color(
                                                                        0xff868686),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }

                                                          final userData = snapshot
                                                              .data!; // Safe to use since null check is above
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Submitted By:",
                                                                style: AppConstant
                                                                    .getRoboto(
                                                                  FontWeight
                                                                      .w500,
                                                                  AppConstant
                                                                      .HEADLINE_SIZE_20,
                                                                  Color(
                                                                      0xff33272A),
                                                                ),
                                                              ),
                                                              Text(
                                                                userData[
                                                                        'full_name'] ??
                                                                    "Not available yet",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppConstant
                                                                    .getRoboto(
                                                                  FontWeight
                                                                      .w500,
                                                                  AppConstant
                                                                      .HEADLINE_SIZE_20,
                                                                  Color(
                                                                      0xff868686),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                      Obx(
                                                        () => Visibility(
                                                          visible: dashboardController
                                                                      .user_role
                                                                      .value ==
                                                                  "super_engineer"
                                                              ? false
                                                              : true,
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        8),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "S.Eng:",
                                                                  style: AppConstant.getRoboto(
                                                                      FontWeight
                                                                          .w500,
                                                                      AppConstant
                                                                          .HEADLINE_SIZE_20,
                                                                      Color(
                                                                          0xff33272A)),
                                                                ),
                                                                Text(
                                                                  "Raj Sharma",
                                                                  style: AppConstant.getRoboto(
                                                                      FontWeight
                                                                          .w500,
                                                                      AppConstant
                                                                          .HEADLINE_SIZE_20,
                                                                      Color(
                                                                          0xff868686)),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                left: AppConstant
                                                                    .LARGE_SIZE,
                                                                bottom: AppConstant
                                                                    .SMALL_TEXT_SIZE),
                                                            child: Bounceable(
                                                              onTap: () {
                                                                Get.to(() => SEAttendance(
                                                                    siteid: dashboardController
                                                                        .currentSiteID!
                                                                        .value));
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient:
                                                                      AppConstant
                                                                          .BUTTON_COLOR,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.00),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            8.00,
                                                                        bottom:
                                                                            8.00,
                                                                        top:
                                                                            8.00,
                                                                        right:
                                                                            8.00),
                                                                width: AppConstant
                                                                    .BUTTON_DAHBOARD_WIDTH,
                                                                height: AppConstant
                                                                    .BUTTON_DAHBOARD_HIGHT,
                                                                child: Center(
                                                                  child: Text(
                                                                      AppConstant
                                                                          .Button_Text_Attendance,
                                                                      style: AppConstant.Dashboard_text(
                                                                          AppConstant
                                                                              .Button_Text_Attendance,
                                                                          context,
                                                                          AppConstant
                                                                              .HEADLINE_SIZE_15)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                right: AppConstant
                                                                    .LARGE_SIZE,
                                                                bottom: AppConstant
                                                                    .SMALL_TEXT_SIZE),
                                                            child: Bounceable(
                                                              onTap: () {
                                                                checkTime();
                                                                //10to 6b/w
                                                                if (dashboardController
                                                                        .isSubmitTimeRange ==
                                                                    true) {
                                                                  //userid
                                                                  if (dashboardController
                                                                      .lastSubmittedReport
                                                                      .value
                                                                      .isNotEmpty) {
                                                                    if (dashboardController
                                                                            .current_date
                                                                            .value ==
                                                                        dateOfsite) {
                                                                      debugPrint(
                                                                          "debugnj:same date");
                                                                      //userid of submited sreport
                                                                      if (dashboardController
                                                                              .lastSubmittedReport
                                                                              .value ==
                                                                          userid) {
                                                                        debugPrint(
                                                                            "debugnj:same date old user edit");
                                                                        dashboardController
                                                                            .viewOnly
                                                                            .value = false;
                                                                        Get.to(() =>
                                                                            EditFillFormSE(
                                                                              siteID: '${dashboardController.currentSiteID!.value}',
                                                                              viewOnly: false,
                                                                            ));
                                                                      } else {
                                                                        dashboardController
                                                                            .viewOnly
                                                                            .value = true;
                                                                        dashboardController
                                                                            .viewOnly
                                                                            .refresh();
                                                                        util.showSnackBar(
                                                                            "Alert",
                                                                            "Report already submitted!",
                                                                            false);
                                                                        Get.to(() =>
                                                                            EditFillFormSE(
                                                                              siteID: '${dashboardController.currentSiteID!.value}',
                                                                              viewOnly: true,
                                                                            ));
                                                                      }
                                                                    } else {
                                                                      dashboardController
                                                                          .viewOnly
                                                                          .value = true;
                                                                      debugPrint(
                                                                          "debugnj:new date");
                                                                      Get.to(() =>
                                                                          EditFillFormSE(
                                                                            siteID:
                                                                                '${dashboardController.currentSiteID!.value}',
                                                                            viewOnly:
                                                                                true,
                                                                          ));
                                                                    }
                                                                  } else {
                                                                    //new report ccreate
                                                                    util.showSnackBar(
                                                                        "Alert",
                                                                        "You can add new report!",
                                                                        true);
                                                                  }
                                                                } else {
                                                                  util.showSnackBar(
                                                                      "Alert",
                                                                      "You can submit report between 10 AM to 06 PM",
                                                                      false);
                                                                }
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient:
                                                                      AppConstant
                                                                          .BUTTON_COLOR,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.00),
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            8.00,
                                                                        vertical:
                                                                            8.00),
                                                                width: AppConstant
                                                                    .BUTTON_DAHBOARD_WIDTH,
                                                                height: AppConstant
                                                                    .BUTTON_DAHBOARD_HIGHT,
                                                                child: Center(
                                                                  child: Text(
                                                                      dashboardController.lastSubmittedReport.value == userid &&
                                                                              dashboardController
                                                                                  .viewOnly.value
                                                                          ? "View Only"
                                                                          : AppConstant
                                                                              .Button_Text_View,
                                                                      style: AppConstant.Dashboard_text(
                                                                          AppConstant
                                                                              .Button_Text_View,
                                                                          context,
                                                                          AppConstant
                                                                              .HEADLINE_SIZE_15)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        key: UniqueKey(),
                                        itemCount: 1,
                                      );
                                    }
                                  })))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
