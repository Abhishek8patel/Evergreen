// import 'package:testingevergreen/Utills/universal.dart';
import '../../../Utills3/utills.dart';
import 'package:testingevergreen/pages/SE/se_controller.dart';
import 'package:testingevergreen/pages/SV/svController/sv_form_one_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewFormOneSV extends StatefulWidget {
  String? token;
  String? siteID;

  NewFormOneSV({required this.token, required this.siteID});

  @override
  State<NewFormOneSV> createState() => _NewFormOneSVState();
}

class _NewFormOneSVState extends State<NewFormOneSV> {
  bool product_one_selected = false;

  SEController svController = Get.find();

  var pageBucket = PageStorageBucket();
  DashboardController dashboardController = Get.find();
  SvFormOneController svFormOneController = Get.find();
  final TAG = "NewFormOneSV";
  final util = Utills();

  //final int itemCount = 10;

  //check box 0,1,2
  //item index=pro. len.
  void _onCheckboxChanged(int itemIndex, int checkboxIndex) {
    setState(() {
      svController.selectedIndices.value[itemIndex] = checkboxIndex;
    });
  }

  @override
  void dispose() {
    debugPrint("pagecalleddispose:form_one");
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    debugPrint("pagecalled:form_one");
    svFormOneController
        .getProducts(dashboardController.user_token.value,
            dashboardController.currentSiteID!.value)
        .then((value) => {
              if (value!.products.isNotEmpty)
                {debugPrint("products:${value!.products}")}
            });
    svFormOneController.selectedProductsIds.clear();
    svFormOneController.selectedProductsIds.refresh();
  }

  //no useed
  getProblems() {
    svController.getAllProblems(widget.token!).then((value) => {
          if (value != null)
            {
              if (value.problems != null) {if (value.problems.data != null) {}}
            }
        });
  }

  Widget _buildCheckbox(
      int itemIndex, int checkboxIndex, String label, String productID) {

    // Ensure the formOnController lists are properly initialized
    if (svFormOneController.selectedIndices.value.length <= itemIndex) {
      svFormOneController.selectedIndices.addAll(List<int>.filled(itemIndex - svFormOneController.selectedIndices.value.length + 1, -1));
    }

    if (svFormOneController.selectedProductsIds[itemIndex] == null) {
      svFormOneController.selectedProductsIds[itemIndex] = {'type': '', 'productID': ''};
    }

    return Obx(() => CheckboxListTile(
      value: svFormOneController.selectedIndices[itemIndex] == checkboxIndex,
      onChanged: (bool? value) {
        debugPrint("productIDs: $productID");
        svFormOneController.selectedProductsIds.forEach((k, v) {
          debugPrint("productIDsstored: $k $v");
        });

        debugPrint("printlable${label}");

        if (label == "Working Ok" || label == "Working OK") {
          svFormOneController.selectedProductsIds[itemIndex] = {
            'type': "working_ok",
            'productID': productID
          };
        } else if (label == "Working Not Ok" || label == "Working Not OK") {
          svFormOneController.selectedProductsIds[itemIndex] = {
            'type': "not_working",
            'productID': productID
          };
        } else if (label == "Not Applicable") {
          svFormOneController.selectedProductsIds[itemIndex] = {
            'type': "notApplicable",
            'productID': productID
          };
        }

        svFormOneController.selectedIndices[itemIndex] = checkboxIndex;

        for (int i = 0; i < svFormOneController.selectedIndices.value.length; i++) {
          //  debugPrint("njjj${formOnController.selectedIndices.value[i]}");
          debugPrint("njjj${svFormOneController.selectedProductsIds.value[i]}");
        }

        bool allSelected = svFormOneController.areAllProductsSelected();
        debugPrint("njjj? $allSelected");
      },
      title: Text(label),
      controlAffinity: ListTileControlAffinity.leading,
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          svFormOneController.clearSelections();
          return true; // Return true to allow the back n
        },
        child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            behavior: HitTestBehavior.opaque,
            child: SafeArea(
              child: Card(
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(
                          () => svFormOneController.loadind.value == true
                              ? Center(
                            child: Column(mainAxisAlignment:MainAxisAlignment.center,children: [Image.asset("assets/images/uploading.png",scale: 3,),SizedBox(height: 20,),CircularProgressIndicator(),SizedBox(height: 20,),Text("Uploading")],),
                          )
                              : ListView.builder(
                                  itemCount: svFormOneController
                                      .productsList.value.length,
                                  key: PageStorageKey<String>('formkey'),
                                  itemBuilder: (context, i) {
                                    var product = svFormOneController
                                        .productsList.value[i];

                                    // Ensure the product is not null
                                    if (product == null || product.id == null) {
                                      return Container(
                                          child: Center(
                                        child: Text(""),
                                      )); // or you can show some error widget
                                    }

                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 14),
                                              child: Text(
                                                "${svFormOneController.productsList.value[i]!.productName.capitalizeFirst ?? "null"}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Color(0xff25BD62),
                                                ),
                                              ),
                                            ),
                                            Wrap(
                                              spacing: 8.0,
                                              // Gap between adjacent children in the main axis.
                                              runSpacing: 4.0,
                                              // Gap between lines.
                                              children: [
                                                _buildCheckbox(
                                                    i,
                                                    0,
                                                    "Working OK",
                                                    svFormOneController
                                                        .productsList
                                                        .value[i]!
                                                        .id),
                                                _buildCheckbox(
                                                    i,
                                                    1,
                                                    "Working Not OK",
                                                    svFormOneController
                                                        .productsList
                                                        .value[i]!
                                                        .id),
                                                _buildCheckbox(
                                                    i,
                                                    2,
                                                    "Not Applicable",
                                                    svFormOneController
                                                        .productsList
                                                        .value[i]!
                                                        .id),
                                              ],
                                            )
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
            )),
      ),
    );
  }
}
