import 'dart:io';

// import 'package:testingevergreen/Utills/universal.dart';
import '../../../Utills3/universal.dart';
import '../../../Utills3/utills.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:testingevergreen/pages/SE/form_one.dart';
import 'package:testingevergreen/pages/SE/form_three.dart';
import 'package:testingevergreen/pages/SE/form_two.dart';
import 'package:testingevergreen/pages/SE/se_controller.dart';
import 'package:testingevergreen/pages/SE/submit.dart';
import 'package:testingevergreen/pages/SV/addNewReportSV/new_for_sv_submit.dart';
import 'package:testingevergreen/pages/SV/addNewReportSV/new_form_one_sv.dart';
import 'package:testingevergreen/pages/SV/addNewReportSV/new_form_three_sv.dart';
import 'package:testingevergreen/pages/SV/addNewReportSV/new_form_two_sv.dart';
import 'package:testingevergreen/pages/SV/svController/sv_form_one_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FillFormNewSV extends StatefulWidget {
  String? siteID;

  FillFormNewSV({required this.siteID});

  @override
  State<FillFormNewSV> createState() => _FillFormNewSVState();
}

class _FillFormNewSVState extends State<FillFormNewSV>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  final pageController = PageController();

  var pageBucket = PageStorageBucket();
  DashboardController dashboardController = Get.find();
  SEController svController = Get.find();
  SvFormOneController svFormOneController = Get.find();
  final util = Utills();

  @override
  void initState() {
    debugPrint("pagecalled:form_oneNewSV");
    svFormOneController.productReportMap.clear();
    svFormOneController.productMainReportMap.clear();
    AppConstant.getUserData("user_data").then((value) => {
          if (value!.user_token.isNotEmpty)
            {
              dashboardController.user_token.value = value!.user_token!,
              svFormOneController.loadind.value = true,
            }
          else
            {}
        });
    //gettig current page index
    pageController.addListener(() {
      int nextPage = pageController.page!.round();
      if (svFormOneController.currentPage.value != nextPage) {
        setState(() {
          svFormOneController.currentPage.value = nextPage;
        });
      }
    });
    svFormOneController.selectedProductsIds.clear();
    svFormOneController.selectedProductsIds.refresh();
    super.initState();
  }

  Future<void> processEnteredValues() async {
    debugPrint("njcvalue:called");
    debugPrint(
        "njcvalue:called${svFormOneController.enteredValues.toString()}");
    for (var entry in svFormOneController.enteredValues.entries) {
      var productID = entry.key;
      var enteredvalue = entry.value;

      debugPrint("njcvalue:{$productID $enteredvalue}");

      await Future.delayed(Duration(milliseconds: 200));

      await svFormOneController
          .postCorrectValues(
              token: dashboardController.user_token.value,
              siteID: dashboardController.currentSiteID!.value,
              product_id: "${productID}",
              product_report_id:
                  "${svFormOneController.productReportMap["${productID}"]}",
              current_value: "${enteredvalue}",
              is_edit: false)
          .then((res) {
        if (res != null) {
          debugPrint("postvalues:${res.message}");
          debugPrint("postvalues reportid:${res.productReport.mainReportId}");
          if (res.productReport != null &&
              res.productReport.mainReportId.isNotEmpty) {
            svFormOneController.productMainReportMap["${productID}"] =
                res.productReport.mainReportId.toString();
          }
        }
      });

      debugPrint(
          "postCorrectValues:${svFormOneController.productReportMap["${productID}"]}");
    }
  }

  Future executeApiCalls() async {
    svFormOneController.selectedProductsList.value =
        svFormOneController.selectedProductsIds.values.toList();
    debugPrint("ndebug:${svFormOneController.selectedProductsList.value}");
    for (var entry in svFormOneController.selectedProductsIds.entries) {
      var key = entry.key;
      var value = entry.value;

      debugPrint("ndebug:$key $value");

      // Introduce a 2-second delay before each API call
      await Future.delayed(Duration(seconds: 2));

      var res = await svFormOneController.postWorkingType(
          dashboardController.user_token.value,
          dashboardController.currentSiteID!.value,
          "${value['productID']!}",
          "${value['type']!}");

      if (res != null && res.message.isNotEmpty) {
        if (res.productReport != null) {
          if (res.productReport.productReportId.isNotEmpty) {
            svFormOneController.productReportMap["${value['productID']!}"] =
                res.productReport.productReportId.toString();
            debugPrint("njprblem store report id" +
                res.productReport.productReportId.toString());
          }
        }
        debugPrint("postworkingtype" + res.message);
        debugPrint(
            "postworkingtype reportud" + res.productReport.productReportId);
      }
    }
  }

  Future<void> sendImages() async {
    int index = 0;
    for (var entry
        in svFormOneController.selectedProblemswithProductIdValues.entries) {
      var productID = entry.key;
      var value = entry.value;
      var imglist = svFormOneController.productImages.value[index];
      await Future.delayed(Duration(seconds: 2), () async {


        debugPrint("njprblem product id and problem id:$productID $value");
        debugPrint(
            "njprblem report id:${svFormOneController.productReportMap["${productID}"]}");

        debugPrint("end point data send: ${productID}");
        debugPrint(
            "end point data send:  ${svFormOneController.productReportMap["${productID}"]}");
        debugPrint("end point data send: ${value}");

         await svFormOneController
            .addImages(
               dashboardController.user_token.value,
                dashboardController.currentSiteID!.value,
                "${productID}",
                "${svFormOneController.productReportMap["${productID}"]}",
                "${value}",
                "${svFormOneController.selectedSolutionswithProductIdValues.value[productID]}",
                "${svFormOneController.selectedProblemCoverdwithProductIdValues[productID]}",
                index,
                imglist)
            .then((value) => {


              //debugPrint("addImages" + "${value?.message??"null"}")


            });
      });
      index++;
    }
  }

  goToNextPage() async {
    FocusManager.instance.primaryFocus!.unfocus();

    if (svFormOneController.currentPage.value == 0) {
      if (svFormOneController.areAllProductsSelected() == false) {
        util.showSnackBar("Alert", "Please fill all products", false);
      } else {
        if (dashboardController.user_token.value.isNotEmpty) {
          if (dashboardController.currentSiteID!.value.isNotEmpty) {
            svFormOneController.loadind.value = true;
            executeApiCalls().then((value) => {
                  pageController.nextPage(
                      duration: Duration(microseconds: 1),
                      curve: Curves.linear),
                  svFormOneController.loadind.value = false,
                });
          } else {
            util.showSnackBar("Alert", "No site id found,Try again!", false);
          }
          //formOnController.logSelectedProducts();
        }
      }
    }

    if (svFormOneController.currentPage.value == 1) {
      if (dashboardController.currentSiteID!.value.isNotEmpty) {
        svFormOneController.loadind.value = true;
        await sendImages().then((value) => {
              svFormOneController.loadind.value = false,
              pageController.nextPage(
                  duration: Duration(microseconds: 1), curve: Curves.linear),
            });
      } else {
        util.showSnackBar("Alert", "No site id found,Try again!", false);
      }
    }

    if (svFormOneController.currentPage.value == 2) {
      bool allFieldsFilled = true;
      bool allInRange = true;

      for (int i = 0;
          i < svFormOneController.correct_value_controllers.length;
          i++) {
        if (svFormOneController.correct_value_controllers[i].text.isEmpty) {
          allFieldsFilled = false;
          break;
        }

        if (svFormOneController.isOutOfRange.value[i]) {
          allInRange = false;
          break;
        }
      }

      if (!allFieldsFilled) {
        util.showSnackBar("Error", "Please fill all fields", false);
      } else if (!allInRange) {
        util.showSnackBar("Error", "Some values are out of range", false);
      } else {
        //  util.showSnackBar("Success", "All values are valid", true);
        if (dashboardController.currentSiteID!.value.isNotEmpty) {
          svFormOneController.loadind.value = true;
          processEnteredValues().then((value) => {
                svFormOneController.loadind.value = false,
                pageController.nextPage(
                    duration: Duration(microseconds: 1), curve: Curves.linear)
              });
        } else {
          util.showSnackBar("Alert", "No site id found,Try again!", false);
        }

        // Proceed with your logic here
      }
    }
  }

  goToPreViousPage() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (svFormOneController.currentPage.value > 0) {
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
                        "${svController.siteName.value.capitalizeFirst ?? "Unknown"}",
                    toHomePage: false,
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        maintainSize: true,
                        maintainState: true,
                        maintainAnimation: true,
                        visible: svFormOneController.currentPage.value == 0
                            ? false
                            : true,
                        child: Bounceable(
                          onTap: svFormOneController.loadind.value == true
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
                        visible: svFormOneController.currentPage.value == 3
                            ? false
                            : true,
                        child: Bounceable(
                          onTap: svFormOneController.loadind.value == true
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
                              svFormOneController.currentPage.value = page;
                              debugPrint(
                                  "njdebug:${svFormOneController.currentPage.value}");
                              ;
                            });
                          },
                          children: [
                            NewFormOneSV(
                                token: dashboardController.user_token.value,
                                siteID: widget.siteID),
                            NewFormTwoSV(),
                            NewFormThreeSV(),
                            NewFormSVSubmit()
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
