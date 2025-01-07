import 'package:testingevergreen/leave_regination/leave_and_regination_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import '../appconstants/appconstants.dart';
import 'package:google_fonts/google_fonts.dart';
class Resignation extends StatefulWidget {
  const Resignation({Key? key}) : super(key: key);

  @override
  State<Resignation> createState() => _ResignationState();
}

class _ResignationState extends State<Resignation> {
  LeaveAndReginationController controller =Get.find();
  bool selected = false;
  bool isOtherVisible = false;
  DashboardController _dashboardController = Get.find();
  @override
  void initState() {
    super.initState();
    controller.reasons.value.clear();
    controller.fetchReasonsForResignation().then((value) => {});
  }

  @override
  void dispose() {
    controller.endDate=null;
    controller.formattedStartDate=null;
    controller.startDate = null;
    controller.formattedEndDate =null;
    controller.selectedItem=null;
    super.dispose();
  }




  void _showCustomDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Center(child: Text('Resignation')),
        content: Container(height:50,child: Center(child: Text('Do you really want to apply for Resignation?'))),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

                Bounceable(
                  onTap: () {
                    Get.back();
                    controller.ApplyForResignation(
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
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .displayLarge,
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
                            textStyle: Theme.of(context)
                                .textTheme
                                .displayLarge,
                            fontSize: AppConstant.HEADLINE_SIZE_15,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.normal,
                            color: Colors.white)),
                  ),
                ),
              ),
            ],)
        ],
      ),
      barrierDismissible: false,
    );

    Future<void> _selectDate(BuildContext context) async {
      final DateTime today = DateTime.now();

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
        });

      }
    }


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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime today = DateTime.now();

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
      });

    }
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Resignation",
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
                          child: Text(
                              controller.formattedStartDate == null
                                  ? 'No dates selected!'
                                  : 'Selected date: ${controller.formattedStartDate}',
                              style:
                              GoogleFonts.roboto(fontWeight: FontWeight.w700)),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          controller.selectedItem == null
                              ? 'No reason selected!'
                              : 'Selected reason: ${controller.selectedItem!.name}',
                          style: GoogleFonts.roboto(fontWeight: FontWeight.w700),
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
                              _selectDate(context);
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
                                child: Text("Select Date",
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
                                      hint: Text('Select an  reason'),
                                      value: controller.selectedItem,
                                      onChanged: (Item? newValue) {
                                        setState(() {
                                          controller.selectedItem = newValue;
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
                          child:Obx(()=> Bounceable(
                            onTap:controller.isProcess==true?null: () {

                              // Get.bottomSheet(
                              //     Container(
                              //       decoration: BoxDecoration(
                              //         color: Colors.white,
                              //         borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),)
                              //       ),
                              //       height: 500,
                              //
                              //       child: Center(
                              //         child: Column(
                              //           mainAxisAlignment: MainAxisAlignment.center,
                              //           mainAxisSize: MainAxisSize.min,
                              //           children: <Widget>[
                              //             Center(
                              //               child: Image.asset('assets/images/cong.gif'),
                              //             ),
                              //             ElevatedButton(
                              //               child: Text('Close Bottom Sheet'),
                              //               onPressed: () {
                              //                 Get.back();
                              //               },
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ));

                              FocusScope.of(context).unfocus();

                              if (controller.formattedStartDate == null
                              ) {
                                controller.util.showSnackBar(
                                    "Alert", "Please select dates first!", false);
                              }else if(controller.selectedItem==null){
                                controller.util.showSnackBar(
                                    "Alert", "Please select reason first!", false);
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
                                child: Text("Apply For Resignation",
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
                          ),)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}