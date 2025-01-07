import 'dart:convert';

// import 'package:testingevergreen/Utills/endpoints.dart';
// import 'package:testingevergreen/Utills/universal.dart';
import '../../../Utills3/endpoints.dart';
import '../../../Utills3/utills.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:testingevergreen/pages/SV/client_email.dart';
import 'package:testingevergreen/pages/SV/svController/sv_edit_form_one_controller.dart';
import 'package:testingevergreen/pages/SV/svController/sv_form_one_controller.dart';

import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:testingevergreen/pages/myhomepage/myhomepage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SvEditSubmit extends StatefulWidget {
  const SvEditSubmit({Key? key}) : super(key: key);

  @override
  State<SvEditSubmit> createState() => _SubmitState();
}

class _SubmitState extends State<SvEditSubmit> {
  final util = Utills();

  DashboardController dashboardController = Get.find();

  svEditFormOneController sveditFormOneController = Get.find();

  SvFormOneController svFormOneController = Get.find();

  Future<http.Response> submitReport(
      String url, String token, List<Map<String, String>> dataMap) async {
    try {
      // Serialize the data to JSON format
      String jsonData = jsonEncode(dataMap);

      // Debugging to see the data being sent
      debugPrint("njres: $jsonData");

      debugPrint("njres: $token");
      // Sending the POST request with JSON payload and appropriate headers
      var res = await http.post(
        Uri.parse(AppConstant.BASE_URL + "${AppEndPoints.SUBMITFORM}"),
        headers: {
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer $token",
        },
        body: jsonData,
      );

      return res;
    } catch (e) {
      // Return a response with an error status code and error message
      return http.Response('{"statusText": "${e.toString()}"}', 500);
    }
  }

  Future<void> processFinalFormSubmits() async {
    for (var entry in sveditFormOneController.productMainReportMap.entries) {
      var productID = entry.key;
      var MainReportID = entry.value;

      // Debugging information
      debugPrint(
          "final values: proID${productID}  mainreportID${MainReportID}");

      // Adding a delay of 2 seconds
      await Future.delayed(Duration(seconds: 2));

      // Calling finalFormSubmit
      await svFormOneController
          .finalFormSubmit(
              dashboardController.user_token.value, "${MainReportID}")
          .then((res) {
        if (res != null) {
          debugPrint("Mainresponse:" + "${res.message}");
          util.showSnackBar('Alert', res.message, true);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() => sveditFormOneController.loadind.value
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/uploading.png",
                      scale: 3,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Uploading")
                  ],
                ),
              )
            : Center(
                child: AppConstant.getTapButton(
                    AppConstant.getRoboto(FontWeight.w800, 18, Colors.white),
                    "Submit",
                    200,
                    50, () {
                  // Get.to(() => ClientEmail());
                  sveditFormOneController.loadind.value = true;
                  if (sveditFormOneController.productMainReportMap.isNotEmpty) {
                    processFinalFormSubmits().then((value) => {
                          svFormOneController.currentPage.value = 0,
                          svFormOneController.clearSelections(),
                          sveditFormOneController.clearSelections(),
                          sveditFormOneController.currentPage.value = 0,
                          sveditFormOneController.clearSelections(),
                          sveditFormOneController.loadind.value = false,
                          Get.offAll(ClientEmail()),

                        });
                  } else {
                    util.showSnackBar(
                        'Alert', "No mainreport id found!!", false);
                  }

                  // formOnController.finalFormSubmit(dashboardController.user_token.value, "6680ef9ad2584253002421ce").then((val){
                  //   if(val!=null){
                  //     util.showSnackBar("Alert", val.message.toString(), true);
                  //   }else{
                  //     util.showSnackBar("Alert", "failed",false);
                  //   }
                  // });
                }),
              ))
      ],
    )));
  }
}
/*

     int countOfnotworkinglengh = svController
                                .selectedIndices.value
                                .where((element) => element == 1)
                                .length;

                            svController.productImages.value.forEach((element) {
                              debugPrint("finalnj:productImages:$element");
                            });

                            svController.selectedProblemsValues.value
                                .forEach((key, value) {
                              debugPrint(
                                  "finalnj:selectedProblemsValues:${key} ${value}");
                            });

                            svController.selectedProductsIds.value
                                .forEach((k, v) {
                              debugPrint("finalnj:selectedProductsIds:$k $v}");
                            });

                            svController.correct_value_controllers.value
                                .forEach((value) {
                              debugPrint("finalnj:correct_value:${value.text}");
                            });
                            if (dashboardController
                                .user_token.value.isNotEmpty) {
                              List<Map<String, String>> listmap = [];
                              listmap.clear();
                              List<int> trueIndices = svController
                                  .isOutOfRange.value
                                  .asMap()
                                  .entries
                                  .where((entry) => entry.value == false)
                                  .map((entry) => entry.key)
                                  .toList();

                              debugPrint("njmap" + "${trueIndices}");

                              List<Map<String, String>> map = [];
                              map.clear();
                              trueIndices.forEach((element) {
                                debugPrint("njmap1: $element");
                                debugPrint(
                                    "njmap:Selected Product ID: ${svController.selectedProductsIds[element]}");
                                debugPrint(
                                    "njmap:Correct Value: ${svController.correct_value_controllers[element].text}");
                                debugPrint(
                                    "njmap:Selected Problem Value: ${svController.selectedProblemsValues[element]}");

                                map.add({
                                  "product_id":
                                      "${svController.selectedProductsIds[element]}",
                                  "problem_id":
                                      "${svController.selectedProblemsValues[element]}",
                                  "current_value":
                                      "${svController.correct_value_controllers[element].text}",
                                });
                              });
                              listmap.clear();
                              listmap.addAll(map);
                              listmap.add({
                                "site_id":
                                    "${dashboardController.currentSiteID!.value}"
                              });
                              debugPrint("njmap2" + listmap.toString());

                              svController
                                  .submit_report(
                                      dashboardController.user_token.value,
                                      listmap,
                                      svController.productImages.value)
                                  .then((value) => {
                                        if (value == null)
                                          {
                                            util.showSnackBar(
                                                'Alert', "Failed!", false),
                                          }
                                        else
                                          {
                                            if (value!.status == true)
                                              {
                                                util.showSnackBar("Alert",
                                                    "Report Submitted!", true)
                                              }
                                          }
                                      });
                            } else {
                              util.showSnackBar(
                                  "Alert", "Couldn't find user id", false);
                            }
 */
