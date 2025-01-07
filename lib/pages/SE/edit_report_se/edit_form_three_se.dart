// import 'package:testingevergreen/Utills/universal.dart';
import '../../../Utills3/utills.dart';
import 'package:testingevergreen/appconstants/mycolor.dart';
import 'package:testingevergreen/pages/SE/se_controller.dart';
import 'package:testingevergreen/pages/SE/se_edit_controller/se_edit_fromone_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class EditFormThreeSE extends StatefulWidget {
  bool? viewOnly = false;

  EditFormThreeSE({Key? key, this.viewOnly = false}) : super(key: key);

  @override
  State<EditFormThreeSE> createState() => _EditFormThreeSEState();
}

class _EditFormThreeSEState extends State<EditFormThreeSE> {
  final GlobalKey<_EditFormThreeSEState> _key =
      GlobalKey<_EditFormThreeSEState>();

  SeEditFormOneController seEditFormOneController = Get.find();
  var pageBucket = PageStorageBucket();
  SEController svController = Get.find();
  DashboardController dashboardController = Get.find();
  final util = Utills();

  @override
  void initState() {
    super.initState();
    seEditFormOneController.error_msg.value = "Please,Rconfirm current values.";
    seEditFormOneController.isLoading.value = true;
    seEditFormOneController.enteredValues.clear();
    seEditFormOneController.enteredValues.refresh();
    seEditFormOneController.correct_value_controllers.value.clear();
    seEditFormOneController.correct_value_controllers.refresh();
    debugPrint("pagecalled:form_three");
    seEditFormOneController.loadind.value = true;

    if (dashboardController.currentSiteID!.value.isNotEmpty) {
      seEditFormOneController
          .getEditNotEmptyValues(dashboardController.user_token.value,
              dashboardController.currentSiteID!.value)
          .then((value) {
        if (value != null) {
          int notEmptyListLength =
              seEditFormOneController.notEmptyValList.value.length;
          debugPrint("notEmptyValList length: $notEmptyListLength");

          for (int i = 0; i < notEmptyListLength; i++) {
            seEditFormOneController.correct_value_controllers.value
                .add(TextEditingController());
          }

          for (int i = 0; i < notEmptyListLength; i++) {
            if (seEditFormOneController.notEmptyValList.value[i] != null) {
              seEditFormOneController.correct_value_controllers.value[i].text =
                  seEditFormOneController.notEmptyValList.value[i]!.currentValue
                      .toString();
            }
          }

          seEditFormOneController.isLoading.value = false;
        }
      });
    } else {
      seEditFormOneController.isLoading.value = false;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        util.showSnackBar("Alert", "No site id found, Try again!", false);
      });
    }

    seEditFormOneController.loadind.value = false;
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
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: RefreshIndicator(
            onRefresh: () async {
              super.initState();
            },
            child: Column(
              children: [
                Obx(
                  () => Text(
                    "${seEditFormOneController.error_msg.value}",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => seEditFormOneController.loadind.value
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
                        : IgnorePointer(
                            ignoring: false,
                            child: FutureBuilder(
                                future: Future.delayed(Duration(seconds: 2)),
                                builder: (i, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Text("error");
                                  } else {
                                    return ListView.builder(
                                      itemCount: seEditFormOneController
                                          .notEmptyValList.value.length,
                                      key: PageStorageKey<String>('formkey'),
                                      itemBuilder: (context, i) {
                                        var product = seEditFormOneController
                                            .notEmptyValList.value[i];

                                        if (product == null ||
                                            product.id == null) {
                                          return Container();
                                        }

                                        if (seEditFormOneController
                                                .isOutOfRange.value.length <=
                                            i) {
                                          seEditFormOneController
                                              .isOutOfRange.value
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
                                                  offset:
                                                      const Offset(5.0, 5.0),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 2.0,
                                                ),
                                                BoxShadow(
                                                  color: Colors.white,
                                                  offset:
                                                      const Offset(0.0, 0.0),
                                                  blurRadius: 0.0,
                                                  spreadRadius: 0.0,
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            margin: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                    "${seEditFormOneController.notEmptyValList.value[i]!.productName.capitalizeFirst}"!,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 20,
                                                      color: Color(0xff25BD62),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: Obx(
                                                      () => Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        alignment:
                                                            Alignment.center,
                                                        width: 300,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: seEditFormOneController
                                                                    .isOutOfRange
                                                                    .value[i]
                                                                ? Colors.red
                                                                : Colors.grey,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: seEditFormOneController
                                                                  .isOutOfRange
                                                                  .value[i]
                                                              ? Colors.red
                                                                  .withOpacity(
                                                                      0.1)
                                                              : Color(
                                                                  0x1A3CAA96),
                                                        ),
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Obx(
                                                            () => TextField(
                                                              autofocus: true,
                                                              readOnly:
                                                                  widget.viewOnly ==
                                                                          true
                                                                      ? true
                                                                      : false,
                                                              controller:
                                                                  seEditFormOneController
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
                                                                hintStyle:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 16,
                                                                  color: Color(
                                                                      0xff89968E),
                                                                ),
                                                              ),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              onChanged:
                                                                  (String?
                                                                      value) {
                                                                debugPrint(
                                                                    "clicked");

                                                                if (value ==
                                                                        null ||
                                                                    value ==
                                                                        "") {
                                                                  seEditFormOneController
                                                                          .isOutOfRange
                                                                          .value[
                                                                      i] = true;
                                                                  seEditFormOneController
                                                                      .isOutOfRange
                                                                      .refresh();
                                                                }

                                                                double?
                                                                    enteredValue =
                                                                    double.tryParse(
                                                                        value ??
                                                                            "");

                                                                double
                                                                    minValue =
                                                                    double.parse(seEditFormOneController
                                                                        .notEmptyValList
                                                                        .value[
                                                                            i]!
                                                                        .parameterMin);

                                                                double
                                                                    maxValue =
                                                                    double.parse(seEditFormOneController
                                                                        .notEmptyValList
                                                                        .value[
                                                                            i]!
                                                                        .parameterMax);

                                                                if (enteredValue !=
                                                                    null) {
                                                                  if (enteredValue <
                                                                          minValue ||
                                                                      enteredValue >
                                                                          maxValue) {
                                                                    //util.showSnackBar("Alert", "Value should be in range", false);
                                                                    debugPrint(
                                                                        "clicked+value should be in range");
                                                                    seEditFormOneController
                                                                            .error_msg
                                                                            .value =
                                                                        "Value should be in range";
                                                                    seEditFormOneController
                                                                        .error_msg
                                                                        .refresh();
                                                                    seEditFormOneController
                                                                        .isOutOfRange
                                                                        .value[i] = true;
                                                                    seEditFormOneController
                                                                        .isOutOfRange
                                                                        .refresh();
                                                                  } else {
                                                                    seEditFormOneController.enteredValues[seEditFormOneController
                                                                        .notEmptyValList
                                                                        .value[
                                                                            i]!
                                                                        .id] = value!;

                                                                    seEditFormOneController
                                                                        .enteredValues
                                                                        .remove(seEditFormOneController
                                                                            .notEmptyValList
                                                                            .value[i]!);
                                                                    seEditFormOneController
                                                                        .isOutOfRange
                                                                        .value[i] = false;
                                                                    seEditFormOneController
                                                                        .isOutOfRange
                                                                        .refresh();

                                                                    seEditFormOneController
                                                                        .isOutOfRange
                                                                        .value
                                                                        .forEach(
                                                                            (element) {
                                                                      if (element =
                                                                          true) {
                                                                        seEditFormOneController
                                                                            .error_msg
                                                                            .value = "Re confirm all values!";
                                                                        seEditFormOneController
                                                                            .error_msg
                                                                            .refresh();
                                                                      }
                                                                    });
                                                                  }
                                                                  seEditFormOneController
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0,
                                                            top: 16,
                                                            bottom: 16),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Min Value:${seEditFormOneController.notEmptyValList.value[i]!.parameterMin}",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 20,
                                                              color: Color(
                                                                  0xff265B3A),
                                                            ),
                                                          ),
                                                          Text(
                                                            "-",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 20,
                                                              color: Color(
                                                                  0xff265B3A),
                                                            ),
                                                          ),
                                                          Text(
                                                            "Max Value:${seEditFormOneController.notEmptyValList.value[i]!.parameterMax}",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 20,
                                                              color: Color(
                                                                  0xff265B3A),
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
                                      controller: seEditFormOneController
                                          .scrollController,
                                    );
                                  }
                                }),
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
