import '../../../Utills3/utills.dart';

import 'package:testingevergreen/pages/SE/se_controller.dart';
import 'package:testingevergreen/pages/SE/se_edit_controller/se_edit_fromone_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class EditFormOneSE extends StatefulWidget {
  String? token;
  String? siteID;
  bool? viewOnly = false;

  EditFormOneSE(
      {required this.token, required this.siteID, this.viewOnly = false});

  @override
  State<EditFormOneSE> createState() => _EditFormOneSEState();
}

class _EditFormOneSEState extends State<EditFormOneSE> {
  bool product_one_selected = false;

  SEController svController = Get.find();
  SeEditFormOneController seEditFormOneController = Get.find();
  DashboardController dashboardController = Get.find();
  var pageBucket = PageStorageBucket();

  final TAG = "EditFormOneSE";
  final util = Utills();

  //final int itemCount = 10;

  //check box 0,1,2
  //item index=pro. len.
  void _onCheckboxChanged(int itemIndex, int checkboxIndex) {
    setState(() {
      seEditFormOneController.selectedIndices.value[itemIndex] = checkboxIndex;
    });
  }

  @override
  void dispose() {
    debugPrint("pagecalleddispose:form_one");
    super.dispose();
  }

  int mapStatusToIndex(String status) {
    switch (status) {
      case 'working_ok':
        return 0;
      case 'Working Ok':
        return 0;
      case 'not_working':
        return 1;
      case "Working Not Ok":
        return 1;
      case "Working Not OK":
        return 1;
      case 'notApplicable':
        return 2;
      case 'Not Applicable':
        return 2;

      default:
        return -1; // Handle unknown status
    }
  }

  void initializeSelectedIndices() {
    seEditFormOneController.isLoading.value = true;
    seEditFormOneController.loadind.value = true;
    seEditFormOneController.loadind.refresh();
    debugPrint("njdebugformone:initselectedindicies");
    seEditFormOneController.selectedIndices.clear();
    seEditFormOneController.selectedProductsIds.clear();
    seEditFormOneController.productReportIdMap.clear();

    // Print the editProductList to check its contents
    debugPrint("Edit Product List: ${seEditFormOneController.editProductList}");

    for (var i = 0; i < seEditFormOneController.editProductList.length; i++) {
      var product = seEditFormOneController.editProductList.value[i];
      debugPrint("Product at index $i: $product");
      if (product != null) {
        debugPrint("Product working status: ${product.workingStatus}");
        if (product.workingStatus != null) {
          int index = mapStatusToIndex(product.workingStatus!);
          debugPrint("Product working status index: ${index.toString()}");
          seEditFormOneController.selectedIndices.add(index);

          seEditFormOneController.selectedProductsIds[i] = {
            'type': index == 0
                ? 'working_ok'
                : index == 1
                    ? 'not_working'
                    : 'notApplicable',
            'productID': product.productId!.id
          };

          // Add entry to productReportIdMap
          if (product.id != null) {
            seEditFormOneController.productReportIdMap[product.productId!.id] =
                product.id!;
            debugPrint(
                "Added report ID for productID ${product.productId!.id}: ${product.id!}");
          }
        } else {
          seEditFormOneController.selectedIndices.add(-1);
          seEditFormOneController.selectedProductsIds[i] = {
            'type': '',
            'productID': ''
          };
        }
      } else {
        seEditFormOneController.selectedIndices.add(-1);
        seEditFormOneController.selectedProductsIds[i] = {
          'type': '',
          'productID': ''
        };
      }
    }
    seEditFormOneController.isLoading.value = false;
    seEditFormOneController.loadind.value = false;
    seEditFormOneController.loadind.refresh();
    // debugPrint("Selected Indices: ${seEditFormOneController.selectedIndices}");
    // debugPrint(
    //     "Selected Products IDs: ${seEditFormOneController.selectedProductsIds.toString()}");
    // debugPrint(
    //     "Product Report ID Map: ${seEditFormOneController.productReportIdMap.toString()}");
  }

  @override
  void initState() {
    super.initState();

    debugPrint("pagecalled:edit form_one");
    // svController.selectedProductsIds.clear();
    // svController.selectedProductsIds.refresh();
    //
    //
    seEditFormOneController.loadind.value = true;
    seEditFormOneController
        .getEditProductList(dashboardController.user_token.value,
            dashboardController.currentSiteID!.value)
        .then((value) => {
              initializeSelectedIndices(),
            });
  }

  //no useed
  // getProblems() {
  //   svController.getAllProblems(widget.token!).then((value) => {
  //         if (value != null)
  //           {
  //             if (value.problems != null) {if (value.problems.data != null) {}}
  //           }
  //       });
  // }

  Widget _buildCheckbox(
      int itemIndex, int checkboxIndex, String label, String productID,
      [String? productReportID]) {
    return Obx(
      () => CheckboxListTile(
        value:
            seEditFormOneController.selectedIndices[itemIndex] == checkboxIndex,
        onChanged: (bool? value) {
          if (value == true) {
            seEditFormOneController.selectedIndices[itemIndex] = checkboxIndex;

            debugPrint("lable${label}");
            if (label == "Working OK") {
              seEditFormOneController.selectedProductsIds[itemIndex] = {
                'type': "working_ok",
                'productID': productID
              };
            } else if (label == "Working Not OK") {
              seEditFormOneController.selectedProductsIds[itemIndex] = {
                'type': "not_working",
                'productID': productID
              };
            } else if (label == "Not Applicable") {
              seEditFormOneController.selectedProductsIds[itemIndex] = {
                'type': "notApplicable",
                'productID': productID
              };
            }

            for (int i = 0;
                i < seEditFormOneController.selectedProductsIds.value.length;
                i++) {
              //  debugPrint("njjj${formOnController.selectedIndices.value[i]}");
              debugPrint(
                  "njjj${seEditFormOneController.selectedProductsIds.value[i]}");
            }

            // Store productReportID in the productReportIdMap
            if (productReportID != null) {
              seEditFormOneController.productReportIdMap[productID] =
                  productReportID;
              debugPrint(
                  "Stored report ID for productID $productID: $productReportID");
            }

            bool allSelected = seEditFormOneController.areAllProductsSelected();
            debugPrint("All selected? $allSelected");
          } else {
            seEditFormOneController.selectedIndices[itemIndex] = -1;
            seEditFormOneController.selectedProductsIds[itemIndex] = {
              'type': '',
              'productID': ''
            };

            // Remove the productReportID if checkbox is unchecked
            seEditFormOneController.productReportIdMap.remove(productID);
            debugPrint("Removed report ID for productID $productID");
          }
        },
        title:
            Container(width: double.infinity, height: 20, child: Text(label)),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Card(
            child: Container(
              child: Column(
                children: [
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
                                            .editProductList.value.length,
                                        key: PageStorageKey<String>('formkey'),
                                        itemBuilder: (context, i) {
                                          var product = seEditFormOneController
                                              .editProductList.value[i];

                                          // Ensure the product is not null
                                          if (product == null ||
                                              product.productId == null) {
                                            return Container(
                                              child: Center(
                                                child: Text("No data!!"),
                                              ),
                                            );
                                          }

                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 14),
                                                    child: Text(
                                                      product
                                                              .productId!
                                                              .productName
                                                              .capitalizeFirst ??
                                                          "null",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 20,
                                                        color:
                                                            Color(0xff25BD62),
                                                      ),
                                                    ),
                                                  ),
                                                  Wrap(
                                                    spacing: 8.0,
                                                    runSpacing: 4.0,
                                                    children: [
                                                      _buildCheckbox(
                                                          i,
                                                          0,
                                                          "Working OK",
                                                          product.productId!.id,
                                                          product.id),
                                                      _buildCheckbox(
                                                          i,
                                                          1,
                                                          "Working Not OK",
                                                          product.productId!.id,
                                                          product.id),
                                                      _buildCheckbox(
                                                          i,
                                                          2,
                                                          "Not Applicable",
                                                          product.productId!.id,
                                                          product.id),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
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
      ),
    );
  }
}
