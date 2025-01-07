import 'dart:io';

// import 'package:testingevergreen/Utills/universal.dart';
import '../../../Utills3/utills.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:testingevergreen/pages/SE/form_one.dart';
import 'package:testingevergreen/pages/SE/form_three.dart';
import 'package:testingevergreen/pages/SE/form_two.dart';
import 'package:testingevergreen/pages/SE/se_controller.dart';
import 'package:testingevergreen/pages/SE/se_controller/form_on_controller.dart';
import 'package:testingevergreen/pages/SE/submit.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Utills3/universal.dart';

class FillForm extends StatefulWidget {
  String? siteID;

  FillForm({required this.siteID});

  @override
  State<FillForm> createState() => _FillFormState();

}

class _FillFormState extends State<FillForm>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  final pageController = PageController();
  FormOnController formOnController = Get.find();

  var pageBucket = PageStorageBucket();
  DashboardController dashboardController = Get.find();
  SEController svController = Get.find();
  final util = Utills();

  @override
  void initState() {
    formOnController.productReportMap.clear();
    formOnController.productMainReportMap.clear();
    AppConstant.getUserData("user_data").then((value) {
      if (value != null) {
        svController
            .getAllProblems(value.user_token)
            .then((value) => {svController.loadind.value = false});
      }
    });
    // AppConstant.getUserData("user_data").then((value) => {
    //       if (value!.user_token.isNotEmpty)
    //         {
    //           dashboardController.user_token.value = value!.user_token!,
    //           if (widget.siteID!.isNotEmpty)
    //             {
    //               svController.siteid.value = widget.siteID!,
    //               svController.siteID.refresh(),
    //               //get site products list
    //               //changing on sv and se
    //
    //               if (value.user_role == "supervisor")
    //                 {
    //                   svController
    //                       .svGetReport(
    //                           value.user_token, "667be8454e731d90558d8d0a")
    //                       .then((value) => {
    //                             if (value!.userData.isNotEmpty)
    //                               {
    //
    //
    //                                 //user adta is in array .first will be first
    //                                 svController.svProductsList.first.product
    //                                     .forEach((element) {
    //                                   debugPrint("reportedproduct" +
    //                                       element.productName);
    //                                 }),
    //                                 util.showSnackBar(
    //                                     'Alert:', value!.message, true),
    //                               }
    //                           }),
    //                 },
    //
    //               svController.SiteProducts(
    //                       value.user_token, "${widget.siteID}", value.user_role)
    //                   .then((myvalue) async {
    //                 if (myvalue != null) {
    //                   //select indices are lst of -1,1,0,2 where no selected -1,ok=0,no ok=1,not applicable=2
    //                   svController.selectedIndices.clear();
    //                   svController.selectedIndices.refresh();
    //                   svController.selectedIndices.value = List.generate(
    //                       svController.productList.length, (_) => -1);
    //                   svController.selectedIndices.refresh();
    //                   //all no selected(-1)
    //                   await Future.delayed(Duration(seconds: 1), () async {
    //                     svController.getAllProblems(value.user_token).then(
    //                         (value) => {svController.loadind.value = false});
    //                   });
    //                 }
    //               }),
    //             }
    //           else
    //             {util.showSnackBar('Alert', "No siteid found", false)}
    //           // dashboardController.getCurrentLocation().then((value) =>
    //           // {
    //           //   if (value == LocationStatus.available)
    //           //     {
    //           //       svController
    //           //           .fetchDateTime()
    //           //           .then((value) => {if (value != null) {}})
    //           //     }
    //           // }),
    //         }
    //       else
    //         {util.showSnackBar('Alert', "empty", false)}
    //     });
    //gettig current page index
    // pageController.addListener(() {
    //   int nextPage = pageController.page!.round();
    //   if (formOnController.currentPage.value != nextPage) {
    //     setState(() {
    //       formOnController.currentPage.value = nextPage;
    //     });
    //   }
    // });

    super.initState();
  }

  Future executeApiCalls() async {
    for (var entry in formOnController.selectedProductsIds.entries) {
      var key = entry.key;
      var value = entry.value;

      debugPrint("ndebug:$key $value");

      // Introduce a 2-second delay before each API call
      await Future.delayed(Duration(seconds: 2));

      var res = await formOnController.postWorkingType(
          dashboardController.user_token.value,
          dashboardController.currentSiteID!.value,
          "${value['productID']!}",
          "${value['type']!}");

      if (res != null && res.message.isNotEmpty) {
        if (res.productReport != null) {
          if (res.productReport.productReportId.isNotEmpty) {
            formOnController.productReportMap["${value['productID']!}"] =
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
    int index=0;
    for (var entry in formOnController.selectedProblemswithProductIdValues.entries) {
      var productID = entry.key;
      var value = entry.value;
      var imglist = formOnController.productImages.value[index];
    // var newimglist = imglist[productID];

      await Future.delayed(Duration(seconds: 2));
        debugPrint("njprblem product id and problem id:$productID $value");
        debugPrint("njprblem report id:${formOnController.productReportMap["${productID}"]}");

        debugPrint("end point data productID: ${productID}");
        debugPrint("end point data productReportid:  ${formOnController.productReportMap["${productID}"]}");
        debugPrint("end point data problem id: ${value}");
        debugPrint("end point data productID: ${imglist}");

        var productReportID = formOnController.productReportMap["$productID"];
     if(productReportID!=null){
       await formOnController
           .addImages(
           dashboardController.user_token.value,
           dashboardController.currentSiteID!.value,
           "${productID}",
           productReportID,
           "$value",
           index,imglist)
           .then((value) => {
             if(value!=null){
               debugPrint("addImages" + "${value!.message}")
             }

       });
     }else{
       debugPrint("Product report ID is null for productID: $productID");
     }

      index++;
    }
  }


  Future<void> processEnteredValues() async {
    for (var entry in formOnController.enteredValues.entries) {
      var productID = entry.key;
      var enteredvalue = entry.value;

      debugPrint("njcvalue:{$productID $enteredvalue}");

      await Future.delayed(Duration(milliseconds: 200));

      await formOnController
          .postCorrectValues(
          token: dashboardController.user_token.value,
          siteID: dashboardController.currentSiteID!.value,
          product_id: "${productID}",
          product_report_id:
          "${formOnController.productReportMap["${productID}"]}",
          current_value: "${enteredvalue}",
          is_edit: false)
          .then((res) {
        if (res != null) {
          debugPrint("postvalues:${res.message}");
          debugPrint("postvalues reportid:${res.productReport.mainReportId}");
          if (res.productReport != null && res.productReport.mainReportId.isNotEmpty) {
            formOnController.productMainReportMap["${productID}"] =
                res.productReport.mainReportId.toString();
          }
        }
      });

      debugPrint(
          "postCorrectValues:${formOnController.productReportMap["${productID}"]}");
    }
  }


  goToNextPage() async {


    FocusManager.instance.primaryFocus!.unfocus();

//page 1
    if (formOnController.currentPage.value == 0) {
      if (formOnController.areAllProductsSelected() == false) {
        util.showSnackBar("Alert", "Please fill all products", false);
      } else {
        if (dashboardController.user_token.value.isNotEmpty) {
          if (dashboardController.currentSiteID!.value.isNotEmpty) {
            // formOnController.selectedProductsIds.forEach((key, value) async {
            //   debugPrint("ndebug:$key $value");
            //
            //   await Future.delayed(Duration(seconds: 2));
            //
            //   await formOnController
            //       .postWorkingType(
            //           dashboardController.user_token.value,
            //           dashboardController.currentSiteID!.value,
            //           "${value['productID']!}",
            //           "${value['type']!}")
            //       .then((res) {
            //     if (res!.message.isNotEmpty) {
            //       if (res.productReport != null) {
            //         if (res.productReport.productReportId.isNotEmpty) {
            //           formOnController
            //                   .productReportMap["${value['productID']!}"] =
            //               res.productReport.productReportId.toString();
            //           debugPrint("njprblem store report id" +
            //               res.productReport.productReportId.toString());
            //
            //           // formOnController.productReportId.value =
            //           //     res.productReport.productReportId.toString();
            //         }
            //       }
            //       debugPrint("postworkingtype" + res.message);
            //       debugPrint("postworkingtype reportud" +
            //           res.productReport.productReportId);
            //     }
            //   });
            // });
            formOnController.loadind.value = true;
            executeApiCalls().then((value) => {
                  pageController.nextPage(
                      duration: Duration(microseconds: 1),
                      curve: Curves.linear),
                  formOnController.loadind.value = false,
                });
          } else {
            util.showSnackBar("Alert", "No site id found,Try again!", false);
          }
          //formOnController.logSelectedProducts();
        }
      }
    }

    //page 2
    if (formOnController.currentPage.value == 1) {
      // formOnController.selectedProblemsValues.forEach((key, value) {
      // //  debugPrint("njprblem selectedProblemsValues:$key $value");
      // });

      formOnController.loadind.value = true;
      if (dashboardController.currentSiteID!.value.isNotEmpty) {
        await sendImages().then((value) => {
          formOnController.loadind.value = false,
              pageController.nextPage(
                  duration: Duration(microseconds: 1), curve: Curves.linear),

            });
      } else {
        util.showSnackBar("Alert", "No site id found,Try again!", false);
      }
    }

    //page3
    if (formOnController.currentPage.value == 2) {
      //check if all vaues in range and filled
      //    util.showSnackBar(
      //         'ProductReportID', formOnController.productReportId.value, true);
      bool allFieldsFilled = true;
      bool allInRange = true;

      for (int i = 0;
          i < formOnController.correct_value_controllers.length;
          i++) {
        if (formOnController.correct_value_controllers[i].text.isEmpty) {
          allFieldsFilled = false;
          break;
        }

        if (formOnController.isOutOfRange.value[i]) {
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
          formOnController.loadind.value=true;
          await processEnteredValues().then((value) => {
          formOnController.loadind.value=false,
                pageController.nextPage(
                    duration: Duration(microseconds: 1), curve: Curves.linear)
              });
        } else {
          util.showSnackBar("Alert", "No site id found,Try again!", false);
        }

        // Proceed with your logic here
      }
    } else {}

    if (formOnController.currentPage.value == 3) {}

    /*
                if (value['productID'] != null && value['type'] != null) {
              formOnController.postWorkingType(
                  dashboardController.user_token.value,
                  "6675168cd78fce5f007e8c13",
                  value['productID']!,
                  value['type']!
              ).then((response) {
                if (response != null) {
                  debugPrint("njjjjjr" + response.message);
                } else {
                  debugPrint("njjjjjr" + 'value is empty');
                }
              });
            } else {
              debugPrint("Invalid productID or type for key $key");
            }
    */

    // debugPrint("Alertnj" + "${svController.selectedProductsIds.value}");

    // if (_currentPage < 4) {
    //   //form 3
    //   if (_currentPage == 2) {
    //     //index of selected false
    //     List<int> trueIndices = svController.isOutOfRange.value
    //         .asMap()
    //         .entries
    //         .where((entry) => entry.value == false)
    //         .map((entry) => entry.key)
    //         .toList();
    //
    //     debugPrint(
    //         "njj:The list contains false(correct value) at the following indices: $trueIndices");
    //
    //     //not working products size
    //     int countOfnotworkinglengh = svController.selectedIndices.value
    //         .where((element) => element == 1)
    //         .length;
    //
    //     debugPrint(
    //         "njj:count of not working products${countOfnotworkinglengh}");
    //     // int noOFNOtCorevalues =
    //     //     svController.isOutOfRange.where((p0) => p0 == true).toList().length;
    //     // debugPrint("njj:noOFwronvalues:${noOFNOtCorevalues}");
    //     // for (int i = 0; i < svController.isOutOfRange.value.length; i++) {
    //     //   debugPrint(
    //     //       "njj:isOutOfRangevalues:${svController.isOutOfRange.value[i]}");
    //     // }
    //
    //     // Ensure the indexList contains valid indices within the bounds of boolList
    //     List<int> validIndices = trueIndices
    //         .where((index) =>
    //             index >= 0 && index < svController.isOutOfRange.value.length)
    //         .toList();
    //
    //     // Check which of the valid indices contain false values
    //     List<int> falseIndices = validIndices
    //         .where((index) => !svController.isOutOfRange.value[index])
    //         .toList();
    //
    //     debugPrint("njj:The indices with false values are: $falseIndices");
    //
    //     // svController.correct_value_controllers.forEach((element) {
    //     //   if(element.text.isEmpty){
    //     //     util.showSnackBar(
    //     //         'Alert', "All values should be filled correctly", false);
    //     //   }else{
    //     //     pageController.nextPage(
    //     //         duration: Duration(microseconds: 1), curve: Curves.ease);
    //     //   }
    //     // });
    //     if (falseIndices.length != 0 &&
    //         countOfnotworkinglengh == falseIndices.length) {
    //       pageController.nextPage(
    //           duration: Duration(microseconds: 1), curve: Curves.ease);
    //     } else {
    //       util.showSnackBar(
    //           'Alert', "All values should be filled correctly", false);
    //     }
    //   } //form 2
    //   //images/problem,sol
    //   else if (_currentPage == 1) {
    //     int countOfnotworkinglengh = svController.selectedIndices.value
    //         .where((element) => element == 1)
    //         .length;
    //     int prob_len = svController.selectedProblemsValues.value.length;
    //
    //     debugPrint("finalnj:length:${prob_len}");
    //     debugPrint("finalnj:not working length:${countOfnotworkinglengh}");
    //     if (prob_len != countOfnotworkinglengh) {
    //       util.showSnackBar(
    //           "Alert", "Please fill all problems correctly", false);
    //     } else {
    //       // svController.selectedProblemsValues.value.forEach((key, value) {
    //       //   debugPrint("finalnj:selectedProblemsValues:${key} ${value}");
    //       // });
    //       pageController.nextPage(
    //           duration: Duration(microseconds: 1), curve: Curves.ease);
    //     }
    //
    //     /*
    //       images check
    //     int countOfnotworkingproduct = svController.selectedIndices.value
    //         .where((element) => element == 1)
    //         .length;
    //
    //     for(int i=0;i<countOfnotworkingproduct;i++){
    //       for (int j = 0; j <  3; i++) {
    //         debugPrint("finalnj:images:${svController.productImages.value[i]}");
    //
    //
    //       }
    //     }
    //     */
    //   } else {
    //     pageController.nextPage(
    //         duration: Duration(microseconds: 1), curve: Curves.ease);
    //   }
    // }
  }

  goToPreViousPage() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (formOnController.currentPage.value > 0) {
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
                backToolbar(name: ""),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Visibility(
                          maintainSize: true,
                          maintainState: true,
                          maintainAnimation: true,
                          visible: formOnController.currentPage.value == 0
                              ? false
                              : true,
                          child: Bounceable(
                            onTap:  formOnController.loadind.value==true?null:() {
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
                      ),
                      Obx(
                        () => Visibility(
                          maintainSize: true,
                          maintainState: true,
                          maintainAnimation: true,
                          visible: formOnController.currentPage.value == 3
                              ? false
                              : true,
                          child: Bounceable(
                            onTap: () {
                              formOnController.loadind.value == true
                                  ? null
                                  : goToNextPage();
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
                              formOnController.currentPage.value = page;
                              debugPrint(
                                  "njdebugcpage:${formOnController.currentPage.value}");
                              ;
                            });
                          },
                          children: [
                            Formone(
                                token: dashboardController.user_token.value,
                                siteID: widget.siteID),
                            FormTwo(),
                            FormThree(),
                            Submit()
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
