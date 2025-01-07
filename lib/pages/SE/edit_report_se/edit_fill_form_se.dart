

// import 'package:testingevergreen/Utills/universal.dart';
import '../../../Utills3/universal.dart';
import '../../../Utills3/utills.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:testingevergreen/pages/SE/edit_report_se/edit_form_one_se.dart';
import 'package:testingevergreen/pages/SE/edit_report_se/edit_form_three_se.dart';
import 'package:testingevergreen/pages/SE/edit_report_se/edit_form_two_se.dart';
import 'package:testingevergreen/pages/SE/edit_report_se/edit_se_submit.dart';

import 'package:testingevergreen/pages/SE/se_controller.dart';
import 'package:testingevergreen/pages/SE/se_edit_controller/se_edit_fromone_controller.dart';

import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EditFillFormSE extends StatefulWidget {
  String? siteID;
  bool? viewOnly = false;

  EditFillFormSE({required this.siteID, this.viewOnly = false});

  @override
  State<EditFillFormSE> createState() => _EditFillFormSEState();
}

class _EditFillFormSEState extends State<EditFillFormSE>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  final pageController = PageController();

//  int _currentPage = 0;
  var pageBucket = PageStorageBucket();
  DashboardController dashboardController = Get.find();
  SeEditFormOneController seEditFormOneController = Get.find();
  SEController svController = Get.find();
  final util = Utills();

  @override
  void initState() {
    super.initState();
    seEditFormOneController.isLoading.value = true;
    seEditFormOneController.productReportMap.clear();
    //seEditFormOneController.productMainReportMap.clear();
    seEditFormOneController.loadind.value = true;
    AppConstant.getUserData("user_data").then((value) => {
          if (value!.user_token.isNotEmpty)
            {
              dashboardController.user_token.value = value!.user_token!,
              if (widget.siteID!.isNotEmpty)
                {
                  svController.siteid.value = widget.siteID!,
                  svController.siteID.refresh(),
                  seEditFormOneController.loadind.value = false,
                }
              else
                {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    util.showSnackBar('Alert', "No siteid found", false);
                    seEditFormOneController.loadind.value = false;
                  }),
                }
              // dashboardController.getCurrentLocation().then((value) =>
              // {
              //   if (value == LocationStatus.available)
              //     {
              //       svController
              //           .fetchDateTime()
              //           .then((value) => {if (value != null) {}})
              //     }
              // }),
            }
          else
            {
              seEditFormOneController.loadind.value = false,
              WidgetsBinding.instance.addPostFrameCallback((_) {
                util.showSnackBar('Alert', "empty",
                    false); // or your code that uses visitChildElements
              })
            }
        });
    //gettig current page index
    pageController.addListener(() {
      int nextPage = pageController.page!.round();
      if (seEditFormOneController.currentPage.value != nextPage) {
        setState(() {
          seEditFormOneController.currentPage.value = nextPage;
        });
      }
    });
  }

  Future<void> processWorkingTypes() async {
    for (var entry in seEditFormOneController.selectedProductsIds.entries) {
      var key = entry.key;
      var value = entry.value;

      debugPrint("ndebug:$key $value");
      debugPrint(
          "ndebug:${seEditFormOneController.productReportIdMap["${value['productID']!}"]}");

      await Future.delayed(Duration(seconds: 2)); // Adding a delay of 2 seconds

      await seEditFormOneController
          .postWorkingType(
              dashboardController.user_token.value,
              dashboardController.currentSiteID!.value,
              "${value['productID']!}",
              "${value['type']!}",
              "${seEditFormOneController.productReportIdMap["${value['productID']!}"]}",
              seEditFormOneController.currentReportID.value)
          .then((res) {
        if (res != null) {
          debugPrint(
              "postworkingtype" + "${res.productId}" + "${res.workingStatus}");
        }
      });
    }
  }

  Future<void> processEditSeaddImages() async {
    int index = 0;
    for (var entry in seEditFormOneController
        .selectedProblemswithProductIdValues.entries) {
      var productID = entry.key;
      var problemID = entry.value;

      // Debugging information
      debugPrint(
          "editSeaddImages proid probid: $productID ProblemID: $problemID");

      var imglist = seEditFormOneController.productImages.value[index];

      debugPrint("selectedimg index: $index");
      debugPrint("selectedimg: $imglist");

      // Adding a delay of 2 seconds
      await Future.delayed(Duration(seconds: 2));

      // Calling editSeaddImages
      var productReportID =
          seEditFormOneController.productReportMap["$productID"];
      if (productReportID != null) {
        await seEditFormOneController
            .editSeaddImages(
          dashboardController.user_token.value,
          dashboardController.currentSiteID!.value,
          "$productID",
          "$productReportID",
          "$problemID",
          index,
          imglist,
        )
            .then((value) {
          if (value != null) {
            debugPrint("addImages: ${value.message}");
          }
        });
      } else {
        debugPrint("Product report ID is null for productID: $productID");
      }
      index++;
    }
  }

  goToNextPage() async {
    FocusManager.instance.primaryFocus!.unfocus();

    debugPrint("Alertnj" + "${svController.selectedProductsIds.value}");

    if (seEditFormOneController.currentPage.value == 0) {
      if (widget.viewOnly == true) {
        seEditFormOneController.loadind.value = false;
        pageController.nextPage(
            duration: Duration(microseconds: 1), curve: Curves.linear);
      } else {
        if (seEditFormOneController.areAllProductsSelected() == false) {
          util.showSnackBar("Alert", "Please fill all products", false);
        } else {
          if (dashboardController.user_token.value.isNotEmpty) {
            if (dashboardController.currentSiteID!.value.isNotEmpty) {
              if (seEditFormOneController.currentReportID.value.isNotEmpty) {
                seEditFormOneController.loadind.value = true;
                await processWorkingTypes().then((value) => {
                      seEditFormOneController.loadind.value = false,
                      pageController.nextPage(
                          duration: Duration(microseconds: 1),
                          curve: Curves.linear)
                    });
              } else {
                util.showSnackBar("Alert", "No report if found!", false);
              }
            } else {
              util.showSnackBar("Alert", "No site id found,Try again!", false);
            }
            //formOnController.logSelectedProducts();
          }
        }
      }
    }

    if (seEditFormOneController.currentPage.value == 1) {
      // debugPrint(
      //     "selectedimg: ${seEditFormOneController.productImages.value.map((e) => e.toString()).toList()}");

      seEditFormOneController.scrollToBottom().then((value) async => {
            if (widget.viewOnly == true)
              {
                seEditFormOneController.loadind.value = false,
                pageController.nextPage(
                    duration: Duration(microseconds: 1), curve: Curves.linear),
              }
            else
              {
                debugPrint(
                    "njprblem product id and problem id:on form on clicked"),
                if (dashboardController.currentSiteID!.value.isNotEmpty)
                  {
                    seEditFormOneController.loadind.value = true,
                    await processEditSeaddImages().then((value) => {
                          seEditFormOneController.loadind.value = false,
                          pageController.nextPage(
                              duration: Duration(microseconds: 1),
                              curve: Curves.linear),
                        }),
                  }
                else
                  {
                    util.showSnackBar(
                        "Alert", "No site id found,Try again!", false),
                  }
              }
          });
    }

    if (seEditFormOneController.currentPage.value == 2) {
      if (widget.viewOnly == true) {
        seEditFormOneController.loadind.value = false;
        pageController.nextPage(
            duration: Duration(microseconds: 1), curve: Curves.linear);
      } else {
        //         'ProductReportID', formOnController.productReportId.value, true);
        bool allFieldsFilled = true;
        bool allInRange = true;

        for (int i = 0;
            i < seEditFormOneController.correct_value_controllers.length;
            i++) {
          if (seEditFormOneController
              .correct_value_controllers[i].text.isEmpty) {
            allFieldsFilled = false;
            break;
          }

          if (seEditFormOneController.isOutOfRange.value[i]) {
            allInRange = false;
            break;
          }
        }
        //check all field has valid values
        if (!allFieldsFilled) {
          util.showSnackBar("Error", "Please fill all fields", false);
          debugPrint("njcvalue" + "Please fill all fields");
        } else if (!allInRange) {
          util.showSnackBar("Error", "Some values are out of range", false);
          debugPrint("njcvalue" + "Some values are out of range");
        } else {
          debugPrint("njcvalue" + "all ok");
          seEditFormOneController.loadind.value = true;
          postValuesWithDelay().then((value) => {
                seEditFormOneController.loadind.value = false,
                pageController.nextPage(
                    duration: Duration(microseconds: 1), curve: Curves.linear)
              });
        }
      }
    }
  }

  Future postValuesWithDelay() async {
    for (var entry in seEditFormOneController.enteredValues.entries) {
      var productID = entry.key;
      var enteredValue = entry.value;

      debugPrint("njcvalue:{$productID $enteredValue}");
      debugPrint("njcvalue productreportID:" +
          "${seEditFormOneController.productReportMap["${productID}"]}");

      await seEditFormOneController
          .postCorrectValuesSeEdit(
        token: dashboardController.user_token.value,
        siteID: dashboardController.currentSiteID!.value,
        product_id: "$productID",
        product_report_id:
            "${seEditFormOneController.productReportMap["${productID}"]}",
        current_value: "$enteredValue",
        is_edit: true,
      )
          .then((res) {
        if (res != null) {
          debugPrint("postvalues:${res.message}");
          debugPrint("postvalues reportid:${res.productReport.mainReportId}");

          if (res.productReport != null) {
            if (res.productReport.mainReportId.isNotEmpty) {
              seEditFormOneController.productMainReportMap["$productID"] =
                  res.productReport.mainReportId.toString();

              debugPrint(
                  "mainreportidsaved${seEditFormOneController.productMainReportMap["$productID"]}");
            }
          }
        }
      });

      // Delay for 2 seconds before the next iteration
      await Future.delayed(Duration(seconds: 2));
    }
  }

  goToPreViousPage() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (seEditFormOneController.currentPage.value > 0) {
      pageController.previousPage(
          duration: Duration(microseconds: 1), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: pageBucket,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => backToolbar(
                      name:
                          "${svController.siteName.value.capitalizeFirst ?? "Unknown"}"),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        maintainSize: true,
                        maintainState: true,
                        maintainAnimation: true,
                        visible: seEditFormOneController.currentPage.value == 0
                            ? false
                            : true,
                        child: Bounceable(
                          onTap: seEditFormOneController.loadind.value == true
                              ? null
                              : () {
                                  goToPreViousPage();
                                },
                          child: Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Icon(
                                    Icons.arrow_back_ios,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Previous",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  gradient: AppConstant.Form_Btn_Gredient(
                                      AppConstant.Form_btn_color_one,
                                      AppConstant.Form_btn_color_one),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              height: 50,
                              width: 100,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        maintainSize: true,
                        maintainState: true,
                        maintainAnimation: true,
                        visible: seEditFormOneController.currentPage.value == 3
                            ? false
                            : true,
                        child: Bounceable(
                          onTap: () {
                            goToNextPage();
                          },
                          child: Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Next",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  gradient: AppConstant.Form_Btn_Gredient(
                                      AppConstant.Form_btn_color_one,
                                      AppConstant.Form_btn_color_one),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              height: 50,
                              width: 100,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  height: 40,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView(
                          controller: pageController,
                          key: PageStorageKey<String>('formkey'),
                          physics: NeverScrollableScrollPhysics(),
                          onPageChanged: (page) {
                            setState(() {
                              seEditFormOneController.currentPage.value = page;
                              debugPrint(
                                  "njdebug:${seEditFormOneController.currentPage.value}");
                              ;
                            });
                          },
                          children: [
                            EditFormOneSE(
                              token: dashboardController.user_token.value,
                              siteID: dashboardController.currentSiteID!.value,
                              viewOnly: widget.viewOnly,
                            ),
                            EditFormTwoSE(
                              viewOnly: widget.viewOnly,
                            ),
                            EditFormThreeSE(
                              viewOnly: widget.viewOnly,
                            ),
                            SeEditSubmit(
                              viewOnly: widget.viewOnly,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SmoothPageIndicator(
                          controller: pageController, // PageController
                          count: 4,
                          effect: WormEffect(), // Indicator effect
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
