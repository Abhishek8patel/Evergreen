// import 'package:testingevergreen/Utills/universal.dart';
import 'package:flutter/services.dart';

import '../../../Utills3/utills.dart';
import 'package:testingevergreen/appconstants/SceenTitles.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:testingevergreen/appconstants/mycolor.dart';
import 'package:testingevergreen/pages/Consume_Chemical_list/chemical_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:testingevergreen/pages/myhomepage/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsumeChemicalList extends StatefulWidget {
  const ConsumeChemicalList({Key? key}) : super(key: key);

  @override
  State<ConsumeChemicalList> createState() => _ConsumeChemicalListState();
}

class _ConsumeChemicalListState extends State<ConsumeChemicalList> {
  ChemicalController chemicalController = Get.find();
  DashboardController dashboardController = Get.find();
  var util = Utills();

  var categories_data = [""].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Expanded(child: Text(value)),
    );
  }).toList();

  Future<void> getList() async {
    AppConstant.getUserData("user_data").then((value) async => {
          if (value!.user_token.isNotEmpty)
            {
              chemicalController.userToken.value = value!.user_token,
              chemicalController.userToken.refresh(),
              debugPrint("chemicalget+has token:${value!.user_token}"),
              await chemicalController
                  .getChemicalList(value!.user_token,
                      "${dashboardController.currentSiteID!.value}")
                  .then((value) => {
                        chemicalController.chemicalProductsList.refresh(),
                      }),
            }
          else
            {
              debugPrint("chemicalget+no token2"),
              util.showSnackBar("Alert", "couldn't find token", false),
            }
        });
  }
  String convertToString(dynamic value) {
    if (value == null) {
      return ''; // Or handle null values differently
    }
    if (value is int) {
      return value.toString();
    } else if (value is double) {
      return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      return '';
    }
  }


  @override
  void initState() {
    super.initState();
    chemicalController.qty.text = "";

    getList().then((value) {
      chemicalController.chemicalProductsList.refresh();
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                ScreenTtiles.CHEMICAL_PAGE,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: AppConstant.HEADLINE_SIZE_20,
                    color: Colors.green),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Bounceable(
            onTap: () {
              debugPrint("Clicked");
              Get.offAll(() => MyHomePage(0));
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
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: Obx(() => chemicalController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Table(
                                border:
                                    TableBorder.all(color: Colors.transparent),
                                columnWidths: const {
                                  0: FlexColumnWidth(2),
                                  1: FlexColumnWidth(1),
                                  2: FlexColumnWidth(1),
                                },
                                children: [
                                  TableRow(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent),
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Product Name',
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: Color(0xff25BD62))),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Total Quantity',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: Color(0xff25BD62)),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Remaining Qty.',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: Color(0xff25BD62)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ...chemicalController.chemicalProductsList
                                      .map((product) {
                                    return TableRow(
                                      children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              product
                                                  .productName.capitalizeFirst!,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff265B3A)),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                product.productQuantity
                                                    .toString(),
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff265B3A))),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                // convertToString(product.productQuantity),
                                                convertToString(product.productQuantity).toString(),
                                               //  product.remainingQuantity
                                               //      .toString(),
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff265B3A))),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ],
                              ),
                            );
                          }),
                          SizedBox(height: 30),
                          Center(
                            child: Text("Today Used the things",
                                style: GoogleFonts.roboto(
                                  textStyle:
                                      Theme.of(context).textTheme.displayLarge,
                                  fontSize: AppConstant.HEADLINE_SIZE_20,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.green,
                                )),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              alignment: Alignment.center,
                              width: 290,
                              height: 46,
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
                                border: Border.all(
                                  color: MyColor.OUTLINE_COLOR_POST,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    canvasColor: Colors.white,
                                    cardColor: Colors.white,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: DropdownButton<String>(
                                    underline: SizedBox.shrink(),
                                    value: chemicalController
                                        .selectedProductsValues.value[0],
                                    isExpanded: true,
                                    hint:
                                        Center(child: Text('Select products')),
                                    alignment: Alignment.bottomCenter,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        chemicalController
                                            .selectedProductsValues
                                            .value[0] = newValue!;
                                      });
                                    },
                                    items: chemicalController
                                        .chemicalProductsList.value
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem<String>(
                                        value: value!.id,
                                        child: Text(value.productName),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              alignment: Alignment.center,
                              width: 290,
                              height: 46,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: MyColor.OUTLINE_COLOR_POST,
                                    width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: TextField(
                                 inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                                ],
                                  autofocus: true,
                                  controller: chemicalController.qty,
                                  decoration: InputDecoration.collapsed(
                                      fillColor: Colors.transparent,
                                      filled: true,
                                      hintText: "Enter your qty",

                                      hintStyle: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              AppConstant.HEADLINE_SIZE_20,
                                          color: Colors.black26)),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  onChanged: (String? value) {
                                    // Update your state or controller here
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: AppConstant.LARGE_SIZE,
                                  right: AppConstant.LARGE_SIZE,
                                  bottom: 25),
                              child: Bounceable(
                                onTap: () {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  if (chemicalController.qty.text.isEmpty ||
                                      chemicalController.qty.text == "0") {
                                    util.showSnackBar('Alert',
                                        "Please enter valid quantity!", false);
                                  } else if (chemicalController
                                      .selectedProductsValues[0]
                                      .toString()
                                      .isEmpty) {
                                    util.showSnackBar('Alert',
                                        "Please select product first!", false);
                                  } else if (dashboardController
                                      .user_token.value.isEmpty) {
                                    util.showSnackBar(
                                        'Alert', "No usertoken found!", false);
                                  } else if (dashboardController
                                      .currentSiteID!.value.isEmpty) {
                                    util.showSnackBar(
                                        'Alert', "No siteid found!", false);
                                  } else {
                                    chemicalController
                                        .updateChemicalList(
                                        dashboardController.user_token.value,
                                        dashboardController.currentSiteID!.value,
                                        chemicalController
                                            .selectedProductsValues[0]
                                            .toString(),
                                        chemicalController.qty.text)
                                        .then((value) => {
                                      if (value != null) {getList()}
                                    });
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
                                    child: Text("Update",
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60,),

                  ],
                )),
        ),
      ),
    );
  }
}
