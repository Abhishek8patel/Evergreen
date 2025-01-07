// import 'package:testingevergreen/Utills/universal.dart';
import '../../../Utills3/utills.dart';
import 'package:testingevergreen/appconstants/mycolor.dart';
import 'package:testingevergreen/pages/SE/se_controller.dart';
import 'package:testingevergreen/pages/SE/se_controller/form_on_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../appconstants/appconstants.dart';

class FormThree extends StatefulWidget {
  const FormThree({Key? key}) : super(key: key);

  @override
  State<FormThree> createState() => _FormThreeState();
}

class _FormThreeState extends State<FormThree> {
  var pageBucket = PageStorageBucket();
  SEController svController = Get.find();
  DashboardController dashboardController = Get.find();
  FormOnController formOnController = Get.find();
  final util = Utills();

  @override
  void initState() {
    super.initState();
    formOnController.errorMsg.value="";
    formOnController.errorMsg.refresh();
    debugPrint("pagecalled:form_three");
    if (dashboardController.currentSiteID!.value.isNotEmpty) {
      formOnController
          .getNotEmptyValues(dashboardController.user_token.value,
              dashboardController.currentSiteID!.value)
          .then((value) {
        if (value != null) {
          value.products.forEach((item) {
            debugPrint("emptyvalues:${item.parameterMax}");
          });
        }
      });
    } else {
      util.showSnackBar("Alert", "No site id found,Try again!", false);
    }
    formOnController.correct_value_controllers.value.clear();
    for (int i = 0; i < formOnController.notEmptyValList.value.length; i++) {
      formOnController.correct_value_controllers.value
          .add(TextEditingController());
    }
    formOnController.isOutOfRange.value =
        List<bool>.filled(svController.productList.length, true).obs;

    //formOnController.isOutOfRange.value= List.filled(svController.productList.length, true);
    formOnController.isOutOfRange.refresh();
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
          child: Column(
            children: [
           Obx(()=>Text("${formOnController.errorMsg.value}",style: TextStyle(color: Colors.red),),),
              Expanded(
                child: Obx(
                  () => formOnController.loadind.value
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
                      : ListView.builder(
                          itemCount: formOnController.notEmptyValList.length,
                          key: PageStorageKey<String>('formkey'),
                          itemBuilder: (context, i) {
                            var product =
                                formOnController.notEmptyValList.value[i];

                            // Ensure the product is not null
                            if (product == null || product.id == null) {
                              return Container(); // or you can show some error widget
                            }

                            // Ensure isOutOfRange list is initialized properly
                            if (formOnController.isOutOfRange.value.length <=
                                i) {
                              formOnController.isOutOfRange.value.add(true);
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "${formOnController.notEmptyValList.value[i]!.productName.capitalizeFirst}"!,
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
                                                  color: formOnController
                                                          .isOutOfRange.value[i]
                                                      ? Colors.red
                                                      : Colors.grey,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: formOnController
                                                        .isOutOfRange.value[i]
                                                    ? Colors.red
                                                        .withOpacity(0.1)
                                                    : Color(0x1A3CAA96),
                                              ),
                                              child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: Obx(
                                                    () => TextField(
                                                      autofocus: true,
                                                      controller: formOnController
                                                          .correct_value_controllers
                                                          .value[i],
                                                      decoration:
                                                          InputDecoration
                                                              .collapsed(
                                                        fillColor:
                                                            Colors.transparent,
                                                        filled: true,
                                                        hintText:
                                                            "Enter Correct Value",
                                                        hintStyle:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff89968E),
                                                        ),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.center,
                                                      onChanged:
                                                          (String? value) {
                                                        debugPrint("clciked");

                                                        if (value == null ||
                                                            value == "") {
                                                          formOnController
                                                              .isOutOfRange
                                                              .value[i] = true;
                                                          formOnController
                                                              .isOutOfRange
                                                              .refresh();
                                                        }

                                                        double? enteredValue =
                                                            double.tryParse(
                                                                value ?? "");

                                                        double minValue = double
                                                            .parse(formOnController
                                                                .notEmptyValList
                                                                .value[i]!
                                                                .parameterMin);

                                                        double maxValue = double
                                                            .parse(formOnController
                                                                .notEmptyValList
                                                                .value[i]!
                                                                .parameterMax);

                                                        if (enteredValue !=
                                                            null) {
                                                          setState(() {
                                                            if (enteredValue <
                                                                    minValue ||
                                                                enteredValue >
                                                                    maxValue) {
                                                              formOnController.errorMsg.value="Values should be in range";
                                                              formOnController.errorMsg.refresh();
                                                              // util.showSnackBar(
                                                              //     "Alert",
                                                              //     "Value should be in range",
                                                              //     false);
                                                              debugPrint(
                                                                  "clciked+value should be in range");
                                                              formOnController
                                                                  .isOutOfRange
                                                                  .value[i] = true;
                                                              formOnController
                                                                  .isOutOfRange
                                                                  .refresh();
                                                            } else {
                                                              formOnController
                                                                      .isOutOfRange
                                                                      .value[
                                                                  i] = false;
                                                              formOnController
                                                                  .isOutOfRange
                                                                  .refresh();
                                                              formOnController.errorMsg.value="";
                                                              formOnController.errorMsg.refresh();
                                                            }

                                                            formOnController
                                                                    .enteredValues[
                                                                formOnController
                                                                    .notEmptyValList
                                                                    .value[i]!
                                                                    .id] = value!;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  )),
                                            ),
                                          )),
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
                                                "Min Value:${formOnController.notEmptyValList.value[i]!.parameterMin}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Color(0xff265B3A),
                                                ),
                                              ),
                                              Text(
                                                "-",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Color(0xff265B3A),
                                                ),
                                              ),
                                              Text(
                                                "Max Value:${formOnController.notEmptyValList.value[i]!.parameterMax}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                  color: Color(0xff265B3A),
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
    );
  }
}
