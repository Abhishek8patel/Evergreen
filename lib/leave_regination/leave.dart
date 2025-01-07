import 'dart:convert';

import 'package:testingevergreen/leave_regination/leave_and_regination_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../appconstants/appconstants.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Leave extends StatefulWidget {
  const Leave({Key? key}) : super(key: key);

  @override
  State<Leave> createState() => _LeaveState();
}

class _LeaveState extends State<Leave> with TickerProviderStateMixin {
  late AnimationController resonController;
  late AnimationController startDateController;
  late AnimationController endDateController;
  late Animation<double> _animation;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  LeaveAndReginationController controller = Get.find();
  bool selected = false;
  bool isOtherVisible = false;
  DashboardController _dashboardController = Get.find();

  @override
  void initState() {
    super.initState();
    resonController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    startDateController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    endDateController = AnimationController(
      duration: const Duration(seconds: 2),
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
    );

    _animation = CurvedAnimation(parent: resonController, curve: Curves.ease);
    _animation1 =
        CurvedAnimation(parent: startDateController, curve: Curves.bounceIn);
    _animation2 =
        CurvedAnimation(parent: endDateController, curve: Curves.slowMiddle);

    resonController.forward();
    startDateController.forward();
    endDateController.forward();

    controller.reasons.value.clear();
    controller.fetchReasons().then((value) => {});
  }

  @override
  void dispose() {
    controller.endDate = null;
    controller.formattedStartDate = null;
    controller.startDate = null;
    controller.formattedEndDate = null;
    controller.selectedItem = null;
    resonController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  Widget _buildCustomDatePicker(BuildContext context, DateTime initialDate,
      DateTime firstDate, DateTime lastDate) {
    return AlertDialog(
      title: !selected
          ? Text('Pick your starting date')
          : Text('Pick your ending date'),
      content: Container(
        height: 300,
        width: 300,
        child: CalendarDatePicker(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          onDateChanged: (DateTime date) {
            if (selected == true) {
              setState(() {
                selected = false;
                ;
              });
            } else {
              setState(() {
                selected = true;
                ;
              });
            }

            Navigator.of(context).pop(date);
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  void _showCustomDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Center(child: Text('Leave')),
        content: Container(
            height: 50,
            child:
                Center(child: Text('Do you really want to apply for leave?'))),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Bounceable(
                onTap: () {
                  Get.back();
                  controller.ApplyforLeave(
                          _dashboardController.user_token.value)
                      .then((value) => {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppConstant.BUTTON_COLOR,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(8.00),
                  width: 90,
                  height: 40,
                  child: Center(
                    child: Text("Ok",
                        style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: AppConstant.HEADLINE_SIZE_15,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.normal,
                            color: Colors.white)),
                  ),
                ),
              ),
              Bounceable(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppConstant.BUTTON_COLOR,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(8.00),
                  width: 90,
                  height: 40,
                  child: Center(
                    child: Text("Cancel",
                        style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: AppConstant.HEADLINE_SIZE_15,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.normal,
                            color: Colors.white)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );

    Future<void> _selectDate(BuildContext context) async {
      final DateTime today = DateTime.now();

      // Select start date
      await selectStartDate(context, today, startAnimationDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _selectStartDate(BuildContext context) async {
      final DateTime today = DateTime.now();

      // Select start date
      await selectStartDate(context, today, startAnimationDate);
    }

    Future<void> _selectEndDate(BuildContext context) async {
      if (controller.startDate == null) {
        controller.util
            .showSnackBar('Alert', "Please select start date first", true);
        return;
      }
      final DateTime today = DateTime.now();

      // Select start date
      await SelectEndDate(context, controller.startDate!, today);
    }

    void _startAnimation() {
      resonController.forward(from: 0.0); // Start the animation
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Apply for leave",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Bounceable(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Image.asset(
              "assets/images/back_btn.png",
              width: 150,
              height: 150,
            ),
          ),
        ),
        // actions: [
        //   Icon(Icons.access_time_filled),
        // ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: FadeTransition(
                        opacity: startDateController,
                        child: Text(
                            controller.formattedStartDate == null
                                ? 'No starting date selected!'
                                : 'Start date: ${controller.formattedStartDate}',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      child: FadeTransition(
                        opacity: endDateController,
                        child: Text(
                            controller.formattedEndDate == null
                                ? 'No ending date selected!'
                                : 'End date: ${controller.formattedEndDate}',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    FadeTransition(
                      opacity: resonController,
                      child: Text(
                        controller.selectedItem == null
                            ? 'No reason selected!'
                            : 'Selected reason: ${controller.selectedItem!.name}',
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Padding(
                      padding: EdgeInsets.only(
                          left: AppConstant.LARGE_SIZE,
                          right: AppConstant.LARGE_SIZE,
                          bottom: 25),
                      child: Bounceable(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          _selectStartDate(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: AppConstant.BUTTON_COLOR,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(8.00),
                          width: AppConstant.BUTTON_WIDTH,
                          height: AppConstant.BUTTON_HIGHT,
                          child: Center(
                            child: Text("Select Start Date",
                                style: GoogleFonts.roboto(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                    fontSize: AppConstant.HEADLINE_SIZE_20,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: AppConstant.LARGE_SIZE,
                          right: AppConstant.LARGE_SIZE,
                          bottom: 25),
                      child: Bounceable(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          _selectEndDate(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: AppConstant.BUTTON_COLOR,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(8.00),
                          width: AppConstant.BUTTON_WIDTH,
                          height: AppConstant.BUTTON_HIGHT,
                          child: Center(
                            child: Text("Select End Date",
                                style: GoogleFonts.roboto(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                    fontSize: AppConstant.HEADLINE_SIZE_20,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Container(
                        child: controller.reasons.value.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.green, width: 2)),
                                    margin: const EdgeInsets.all(8.00),
                                    width: AppConstant.BUTTON_WIDTH,
                                    height: AppConstant.BUTTON_HIGHT,
                                    child: Center(
                                      child: DropdownButton<Item>(
                                        elevation: 0,
                                        hint: Text('Select an reason'),
                                        value: controller.selectedItem,
                                        onChanged: (Item? newValue) {
                                          setState(() {
                                            controller.selectedItem = newValue;
                                            _startAnimation();
                                          });
                                        },
                                        items: controller.reasons.value
                                            .map((Item item) {
                                          return DropdownMenuItem<Item>(
                                            value: item,
                                            child: Text(item.name),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Visibility(
                      visible: isOtherVisible,
                      child: Center(
                        child: Container(
                          height: 150,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.00),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText:
                                    'Enter your problem  here(max 200 char)',
                                border: InputBorder.none,
                              ),
                              controller: controller.problem,
                              maxLines: 12,
                              maxLength: 200,
                              style: TextStyle(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: AppConstant.LARGE_SIZE,
                            right: AppConstant.LARGE_SIZE,
                            bottom: 25),
                        child: Obx(
                          () => Bounceable(
                            onTap: controller.isProcess == true
                                ? null
                                : () {
                                    FocusScope.of(context).unfocus();

                                    if (controller.formattedStartDate == null ||
                                        controller.formattedEndDate == null) {
                                      controller.util.showSnackBar("Alert",
                                          "Plesse select dates first!", false);
                                    } else if (controller.selectedItem ==
                                        null) {
                                      controller.util.showSnackBar("Alert",
                                          "Plesse select reason first!", false);
                                    } else if (controller.selectedItem!.name ==
                                        null) {
                                      controller.util.showSnackBar("Alert",
                                          "Plesse select reason first!", false);
                                    } else {
                                      _showCustomDialog();
                                    }
                                  },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: AppConstant.BUTTON_COLOR,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.all(8.00),
                              width: AppConstant.BUTTON_WIDTH,
                              height: AppConstant.BUTTON_HIGHT,
                              child: Center(
                                child: Text("Apply For Leave",
                                    style: GoogleFonts.roboto(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                        fontSize: AppConstant.HEADLINE_SIZE_20,
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<void> selectStartDate(
    BuildContext context,
    DateTime today,
    Function startAnimationDate,
  ) async {
    // Select start date
    final DateTime? pickedStart = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: DateTime(today.year + 5),
      builder: (BuildContext context, Widget? child) {
        return _buildCustomDatePicker(
            context, today, today, DateTime(today.year + 5));
      },
    );

    if (pickedStart != null) {
      setState(() {
        controller.startDate = pickedStart;
        controller.formattedStartDate =
            DateFormat('dd-MM-yyyy').format(pickedStart);

        startAnimationDate();
      });

      // Select end date
    }
  }

  Future<void> SelectEndDate(
      BuildContext context, DateTime pickedStart, DateTime today) async {
    // Select end date
    final DateTime? pickedEnd = await showDatePicker(
      context: context,
      initialDate: pickedStart,
      firstDate: pickedStart,
      lastDate: DateTime(today.year + 5),
      builder: (BuildContext context, Widget? child) {
        return _buildCustomDatePicker(
            context, pickedStart, pickedStart, DateTime(today.year + 5));
      },
    );

    if (pickedEnd != null) {
      setState(() {
        controller.endDate = pickedEnd;
        controller.formattedEndDate =
            DateFormat('dd-MM-yyyy').format(pickedEnd);
        controller.util.showSnackBar(
            'Alert', "Please confirm your starting and ending dates", true);
        startAnimationEndDate();
      });
    }
  }

  Future startAnimationDate() async {
    await startDateController.forward(from: 0.0); //
  }

  Future startAnimationEndDate() async {
    await endDateController.forward(from: 0.0); //
  }
}

// item_model.dart
