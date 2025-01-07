// import 'package:testingevergreen/Utills/universal.dart';
// import '../../../Utills3/utills.dart';
import 'package:testingevergreen/appconstants/mycolor.dart';
import 'package:testingevergreen/pages/SE/se_controller.dart';
import 'package:testingevergreen/pages/SV/svController/sv_edit_form_one_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../../Utills3/utills.dart';

class EditFormThreeSV extends StatefulWidget {
  const EditFormThreeSV({Key? key}) : super(key: key);

  @override
  State<EditFormThreeSV> createState() => _EditFormThreeSVState();
}

class _EditFormThreeSVState extends State<EditFormThreeSV> {
  svEditFormOneController sveditFormOneController = Get.find();

  DashboardController dashboardController = Get.find();

  var pageBucket = PageStorageBucket();
  SEController svController = Get.find();
  final util = Utills();

  @override
  void initState() {
    super.initState();

    sveditFormOneController.errorMsg.value = "Please reconfirm correct values!";
    sveditFormOneController.errorMsg.refresh();
    sveditFormOneController.isLoading.value = true;
    sveditFormOneController.enteredValues.clear();
    sveditFormOneController.correct_value_controllers.value.clear();
    debugPrint("pagecalled:form_three");

    if (dashboardController.currentSiteID!.value.isNotEmpty) {
      sveditFormOneController
          .getEditNotEmptyValues(dashboardController.user_token.value,
              dashboardController.currentSiteID!.value)
          .then((value) {
        if (value != null) {
          sveditFormOneController.correct_value_controllers.value =
              List.generate(
            sveditFormOneController.notEmptyValList.value.length,
            (i) => TextEditingController(
              text: sveditFormOneController
                  .notEmptyValList.value[i]!.currentValue
                  .toString(),
            ),
          );
        }
        sveditFormOneController.isLoading.value = false;
      });
    } else {
      sveditFormOneController.isLoading.value = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        util.showSnackBar("Alert", "No site id found,Try again!", false);
      });
    }
  }

  @override
  void dispose() {
    debugPrint("pagecalleddispose:form_three");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return sveditFormOneController.getEditNotEmptyValues(
                dashboardController.user_token.value,
                dashboardController.currentSiteID!.value);
          },
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Obx(
                  () => sveditFormOneController.errorMsg.value == "OK"
                      ? Text("")
                      : Text(
                          "${sveditFormOneController.errorMsg.value}",
                          style: TextStyle(
                              color:
                                  sveditFormOneController.errorMsg.value == "OK"
                                      ? Colors.green
                                      : Colors.red),
                        ),
                ),
                Expanded(
                  child: Obx(
                    () => sveditFormOneController.isLoading.value
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
                        : sveditFormOneController.notEmptyValList.value.isEmpty
                            ? Center(child: Text("No data available"))
                            : ListView.builder(
                                itemCount: sveditFormOneController
                                    .notEmptyValList.value.length,
                                key: PageStorageKey<String>('formkey'),
                                itemBuilder: (context, i) {
                                  var product = sveditFormOneController
                                      .notEmptyValList.value[i];
                                  if (product == null || product.id == null) {
                                    return Container(); // or you can show some error widget
                                  }

                                  // Ensure isOutOfRange list is initialized properly
                                  if (sveditFormOneController
                                          .isOutOfRange.value.length <=
                                      i) {
                                    sveditFormOneController.isOutOfRange.value
                                        .add(true);
                                  }

                                  return Card(
                                    elevation: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: const Offset(5.0, 5.0),
                                            blurRadius: 10.0,
                                            spreadRadius: 2.0,
                                          ),
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: const Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            spreadRadius: 0.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              "${product!.productName.capitalizeFirst}"!,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color: Color(0xff25BD62),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Obx(
                                                () => Container(
                                                  margin: EdgeInsets.all(10),
                                                  alignment: Alignment.center,
                                                  width: 300,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          sveditFormOneController
                                                                  .isOutOfRange
                                                                  .value[i]
                                                              ? Colors.red
                                                              : Colors.grey,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color:
                                                        sveditFormOneController
                                                                .isOutOfRange
                                                                .value[i]
                                                            ? Colors.red
                                                                .withOpacity(
                                                                    0.1)
                                                            : Color(0x1A3CAA96),
                                                  ),
                                                  child: Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: Obx(
                                                      () => TextField(
                                                        autofocus: true,
                                                        controller:
                                                            sveditFormOneController
                                                                .correct_value_controllers
                                                                .value[i],
                                                        decoration:
                                                            InputDecoration
                                                                .collapsed(
                                                          fillColor: Colors
                                                              .transparent,
                                                          filled: true,
                                                          hintText:
                                                              "Enter Correct Value",
                                                          hintStyle: GoogleFonts
                                                              .roboto(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 16,
                                                            color: Color(
                                                                0xff89968E),
                                                          ),
                                                        ),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        textAlign:
                                                            TextAlign.center,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .deny(
                                                                  RegExp(r'\s'))
                                                        ],
                                                        // Deny spaces
                                                        onChanged:
                                                            (String? value) {
                                                          debugPrint("clicked");
                                                          if (value == null ||
                                                              value == "") {
                                                            sveditFormOneController
                                                                .isOutOfRange
                                                                .value[i] = true;
                                                            sveditFormOneController
                                                                .isOutOfRange
                                                                .refresh();
                                                          }

                                                          double? enteredValue =
                                                              double.tryParse(
                                                                  value ?? "");

                                                          double minValue =
                                                              double.parse(product
                                                                  .parameterMin);
                                                          double maxValue =
                                                              double.parse(product
                                                                  .parameterMax);

                                                          if (enteredValue !=
                                                              null) {
                                                            if (enteredValue <
                                                                    minValue ||
                                                                enteredValue >
                                                                    maxValue) {
                                                              // util.showSnackBar("Alert", "Value should be in range", false);
                                                              sveditFormOneController
                                                                      .errorMsg
                                                                      .value =
                                                                  "Values should be in range";
                                                              sveditFormOneController
                                                                  .errorMsg
                                                                  .refresh();
                                                              debugPrint(
                                                                  "clicked + value should be in range");
                                                              sveditFormOneController
                                                                  .isOutOfRange
                                                                  .value[i] = true;
                                                            } else {
                                                              sveditFormOneController
                                                                      .enteredValues[
                                                                  product
                                                                      .id] = value!;
                                                              sveditFormOneController
                                                                      .isOutOfRange
                                                                      .value[
                                                                  i] = false;
                                                              sveditFormOneController
                                                                  .errorMsg
                                                                  .value = "OK";
                                                              sveditFormOneController
                                                                  .errorMsg
                                                                  .refresh();
                                                            }
                                                            sveditFormOneController
                                                                .isOutOfRange
                                                                .refresh();
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: true,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8.0,
                                                  top: 16,
                                                  bottom: 16),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Min Value: ${product.parameterMin}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 20,
                                                        color:
                                                            Color(0xff265B3A),
                                                      ),
                                                    ),
                                                    Text(
                                                      "-",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 20,
                                                        color:
                                                            Color(0xff265B3A),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Max Value: ${product.parameterMax}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 20,
                                                        color:
                                                            Color(0xff265B3A),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
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
