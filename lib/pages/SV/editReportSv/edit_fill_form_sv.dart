import 'dart:io';

// import 'package:testingevergreen/Utills/universal.dart';
// import '../../../Utills3/utills.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:testingevergreen/pages/SE/form_one.dart';
import 'package:testingevergreen/pages/SE/form_three.dart';
import 'package:testingevergreen/pages/SE/form_two.dart';
import 'package:testingevergreen/pages/SE/se_controller.dart';
import 'package:testingevergreen/pages/SE/submit.dart';
import 'package:testingevergreen/pages/SV/addNewReportSV/new_form_one_sv.dart';
import 'package:testingevergreen/pages/SV/addNewReportSV/new_form_three_sv.dart';
import 'package:testingevergreen/pages/SV/addNewReportSV/new_form_two_sv.dart';
import 'package:testingevergreen/pages/SV/editReportSv/edit_form_one_sv.dart';
import 'package:testingevergreen/pages/SV/editReportSv/edit_form_three_sv.dart';
import 'package:testingevergreen/pages/SV/editReportSv/edit_form_two_sv.dart';
import 'package:testingevergreen/pages/SV/editReportSv/edit_sv_submit.dart';
import 'package:testingevergreen/pages/SV/svController/sv_edit_form_one_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Utills3/universal.dart';
import '../../../Utills3/utills.dart';

class EditFillFormSV extends StatefulWidget {
  String? siteID;

  EditFillFormSV({required this.siteID});

  @override
  State<EditFillFormSV> createState() => _EditFillFormSVState();
}

class _EditFillFormSVState extends State<EditFillFormSV>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  final pageController = PageController();
  int _currentPage = 0;
  var pageBucket = PageStorageBucket();
  DashboardController dashboardController = Get.find();
  SEController svController = Get.find();
  final util = Utills();
  svEditFormOneController sveditFormOneController = Get.find();

  @override
  void initState() {
    super.initState();
    sveditFormOneController.isLoading.value = true;
    sveditFormOneController.productReportMap.clear();
    AppConstant.getUserData("user_data").then((value) => {
          if (value!.user_token.isNotEmpty)
            {
              dashboardController.user_token.value = value!.user_token!,
              if (widget.siteID!.isNotEmpty)
                {
                  svController.siteid.value = widget.siteID!,
                  svController.siteID.refresh(),
                  //get site products list
                  //changing on sv and se

                  if (value.user_role == "supervisor") {},
                }
              else
                {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    util.showSnackBar('Alert', "No siteid found", false);
                  }),
                }
            }
          else
            {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                util.showSnackBar('Alert', "empty", false);
              }),
            }
        });
    //gettig current page index
    pageController.addListener(() {
      int nextPage = pageController.page!.round();
      if (_currentPage != nextPage) {
        setState(() {
          _currentPage = nextPage;
        });
      }
    });
  }

  Future<void> processEditSeaddImages() async {
    debugPrint("njimages" + "called");
    int index = 0;
    for (var entry in sveditFormOneController
        .selectedProblemswithProductIdValues.entries) {
      var productID = entry.key;
      var ProblemID = entry.value;

      var imglist = sveditFormOneController.productImages.value[index];
      // Debugging information
      debugPrint(
          "editSeaddImages proid probid:${productID}  ProblemID:${ProblemID}");
      debugPrint(
          "editSeaddImages proreport id:${sveditFormOneController.productReportMap["${productID}"]}");
      debugPrint(
          "mycoverd problem selected:${sveditFormOneController.selectedProblemCoverdwithProductIdValues[productID]}");
      // Adding a delay of 2 seconds
      await Future.delayed(Duration(seconds: 2));

      await sveditFormOneController
          .editSeaddImages(
              dashboardController.user_token.value,
              dashboardController.currentSiteID!.value,
              "${productID}",
              "${sveditFormOneController.productReportMap["${productID}"]}",
              "${ProblemID}",
              "${sveditFormOneController.selectedSolutionswithProductIdValues.value[productID]}",
              "${sveditFormOneController.selectedProblemCoverdwithProductIdValues[productID]}",
              index,
              imglist)
          .then((value) {
        if (value != null) {
          debugPrint("addImages" + "${value.message}");
        }
      });
      index++;
    }
  }

  Future<void> processWorkingTypes() async {
    for (var entry in sveditFormOneController.selectedProductsIds.entries) {
      var key = entry.key;
      var value = entry.value;

      debugPrint("ndebug:$key $value");
      debugPrint(
          "ndebug:${sveditFormOneController.productReportIdMap["${value['productID']!}"]}");

      await Future.delayed(Duration(seconds: 2)); // Adding a delay of 2 seconds

      await sveditFormOneController
          .postWorkingType(
              dashboardController.user_token.value,
              dashboardController.currentSiteID!.value,
              "${value['productID']!}",
              "${value['type']!}",
              "${sveditFormOneController.productReportIdMap["${value['productID']!}"]}",
              sveditFormOneController.currentReportID.value)
          .then((res) {
        if (res != null) {
          debugPrint(
              "postworkingtype" + "${res.productId}" + "${res.workingStatus}");
        }
      });
    }
  }

  Future postValuesWithDelay() async {
    for (var entry in sveditFormOneController.enteredValues.entries) {
      var productID = entry.key;
      var enteredValue = entry.value;

      debugPrint("njcvalue:{$productID $enteredValue}");
      debugPrint("njcvalue productreportID:" +
          "${sveditFormOneController.productReportMap["${productID}"]}");

      await sveditFormOneController
          .postCorrectValuesSeEdit(
        token: dashboardController.user_token.value,
        siteID: dashboardController.currentSiteID!.value,
        product_id: "$productID",
        product_report_id:
            "${sveditFormOneController.productReportMap["${productID}"]}",
        current_value: "$enteredValue",
        is_edit: true,
      )
          .then((res) {
        if (res != null) {
          debugPrint("postvalues:${res.message}");
          debugPrint("postvalues reportid:${res.productReport.mainReportId}");

          if (res.productReport != null) {
            if (res.productReport.mainReportId.isNotEmpty) {
              sveditFormOneController.productMainReportMap["$productID"] =
                  res.productReport.mainReportId.toString();

              debugPrint(
                  "mainreportidsaved${sveditFormOneController.productMainReportMap["$productID"]}");
            }
          }
        }
      });

      // Delay for 2 seconds before the next iteration
      await Future.delayed(Duration(seconds: 2));
    }
  }

  goToNextPage() async {
    FocusManager.instance.primaryFocus!.unfocus();

    debugPrint("Alertnj" + "${svController.selectedProductsIds.value}");

    if (sveditFormOneController.currentPage.value == 0) {
      if (sveditFormOneController.areAllProductsSelected() == false) {
        util.showSnackBar("Alert", "Please fill all products", false);
      } else {
        if (dashboardController.user_token.value.isNotEmpty) {
          if (dashboardController.currentSiteID!.value.isNotEmpty) {
            if (sveditFormOneController.currentReportID.value.isNotEmpty) {
              sveditFormOneController.loadind.value = true;
              await processWorkingTypes().then((value) => {
                    sveditFormOneController.loadind.value = false,
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

    if (sveditFormOneController.currentPage.value == 1) {
      debugPrint("njprblem product id and problem id:on form on clicked");

      sveditFormOneController.scrollToBottom().then((value) async => {
            if (dashboardController.currentSiteID!.value.isNotEmpty)
              {
                sveditFormOneController.loadind.value = true,
                await processEditSeaddImages().then((value) => {
                      sveditFormOneController.loadind.value = false,
                      pageController.nextPage(
                          duration: Duration(microseconds: 1),
                          curve: Curves.linear),
                    })
              }
            else
              {
                debugPrint("njprblem No site id found,Try again!"),
                util.showSnackBar(
                    "Alert", "No site id found,Try again!", false),
              }
          });
    }

    if (sveditFormOneController.currentPage.value == 2) {
      //         'ProductReportID', formOnController.productReportId.value, true);
      bool allFieldsFilled = true;
      bool allInRange = true;

      for (int i = 0;
          i < sveditFormOneController.correct_value_controllers.length;
          i++) {
        if (sveditFormOneController.correct_value_controllers[i].text.isEmpty) {
          allFieldsFilled = false;
          break;
        }

        if (sveditFormOneController.isOutOfRange.value[i]) {
          allInRange = false;
          break;
        }
      }
      //check all field has valid values
      if (!allFieldsFilled) {
        util.showSnackBar("Error", "Please fill all fields", false);
        debugPrint("njcvalue" + "Please fill all fields");
      } else if (!allInRange) {
        util.showSnackBar("Error", "Reconfirms all values", false);
        debugPrint("njcvalue" + "Some values are out of range");
      } else if (sveditFormOneController.errorMsg.value != "OK") {
        util.showSnackBar("Error", "Please reconfirm values", false);
      } else {
        debugPrint("njcvalue" + "all ok");
        sveditFormOneController.isLoading.value = true;
        postValuesWithDelay().then((value) => {
              sveditFormOneController.isLoading.value = false,
              pageController.nextPage(
                  duration: Duration(microseconds: 1), curve: Curves.linear)
            });
      }
    }
  }

  goToPreViousPage() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (_currentPage > 0) {
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
                        visible: _currentPage == 0 ? false : true,
                        child: Bounceable(
                          onTap: sveditFormOneController.loadind.value == true
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
                        visible: _currentPage == 3 ? false : true,
                        child: Bounceable(
                          onTap: sveditFormOneController.loadind.value == true
                              ? null
                              : () {
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
                              sveditFormOneController.currentPage.value = page;
                              debugPrint(
                                  "njdebug:${sveditFormOneController.currentPage.value}");
                              ;
                            });
                          },
                          children: [
                            EditFormOneSV(
                                token: dashboardController.user_token.value,
                                siteID: widget.siteID),
                            EditFormTwoSV(),
                            EditFormThreeSV(),
                            SvEditSubmit()
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
