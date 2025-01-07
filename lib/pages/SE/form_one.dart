// import 'package:testingevergreen/Utills/universal.dart';
import '../../../Utills3/utills.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:testingevergreen/pages/SE/se_controller.dart';
import 'package:testingevergreen/pages/SE/se_controller/form_on_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class Formone extends StatefulWidget {
  String? token;
  String? siteID;

  Formone({required this.token, required this.siteID});

  @override
  State<Formone> createState() => _FormoneState();
}

class _FormoneState extends State<Formone> {
  bool product_one_selected = false;

  SEController svController = Get.find();
  FormOnController formOnController = Get.find();
  DashboardController dashboardController = Get.find();

  var pageBucket = PageStorageBucket();

  final TAG = "formone";
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
    //util.showSnackBar("Alert", "formone", true);
    debugPrint("pagecalled:form_oneold");
    AppConstant.getUserData("user_data").then((value) => {
          if (value != null)
            {
              if (value.user_token.isNotEmpty)
                {
                  if (dashboardController.currentSiteID!.value.isNotEmpty)
                    {
                      formOnController
                          .getProducts(value.user_token,
                          dashboardController.currentSiteID!.value)
                          .then((value) {
                        if (value != null) {
                          if (value.products.isNotEmpty) {
                            debugPrint("njj${value.products.length}");
                            value.products.forEach((listval) {
                              debugPrint("njproducts${listval.productName}");
                            });
                          }
                        }
                      }),
                    }
                  else
                    {
                      util.showSnackBar("Alert", "No siteId found!!", false),
                    }
                }
              else
                {
                  util.showSnackBar("Alert", "No token found!!", false),
                }
            },
        });
    svController.selectedProductsIds.clear();
    svController.selectedProductsIds.refresh();
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

  /*
      // Refresh the related states
        svController.productImages.value.clear();
        svController.productImages.refresh();
        svController.selectedProblemsValues.clear();
        svController.selectedProblemsValues.refresh();
        svController.correct_value_controllers.value.clear();
        //
        // for (int i = 0; i < svController.productList.value.length; i++) {
        //   svController.correct_value_controllers.value
        //       .add(TextEditingController());
        // }

        // svController.isOutOfRange.value =
        //     List.filled(svController.productList.length, true);
        // svController.isOutOfRange.refresh();

        // Update selectedProductsIds based on checkboxIndex
   */

  /*

     debugPrint("selected productID: ${svController.selectedProductsIds.value}");
        debugPrint("selected productID: $productID");
        _onCheckboxChanged(itemIndex, checkboxIndex);
        debugPrint("selected checkbox: ${svController.selectedIndices.value}");
   */


  Widget _buildCheckbox(
      int itemIndex, int checkboxIndex, String label, String productID) {

    // Ensure the formOnController lists are properly initialized
    if (formOnController.selectedIndices.value.length <= itemIndex) {
      formOnController.selectedIndices.addAll(List<int>.filled(itemIndex - formOnController.selectedIndices.value.length + 1, -1));
    }

    if (formOnController.selectedProductsIds[itemIndex] == null) {
      formOnController.selectedProductsIds[itemIndex] = {'type': '', 'productID': ''};
    }

    return Obx(() => CheckboxListTile(
      value: formOnController.selectedIndices[itemIndex] == checkboxIndex,
      onChanged: (bool? value) {
        debugPrint("productIDs: $productID");
        formOnController.selectedProductsIds.forEach((k, v) {
          debugPrint("productIDsstored: $k $v");
        });

        debugPrint("printlabel $label");

        if(label == "Working Ok"){
          formOnController.selectedProductsIds[itemIndex] = {
            'type': "working_ok",
            'productID': productID
          };
        }
        else if(label == "Working Not Ok"){
          formOnController.selectedProductsIds[itemIndex] = {
            'type': "not_working",
            'productID': productID
          };
        }
        else if(label == "Not Applicable"){
          formOnController.selectedProductsIds[itemIndex] = {
            'type': "notApplicable",
            'productID': productID
          };
        }

        formOnController.selectedIndices[itemIndex] = checkboxIndex;

        for (int i = 0; i < formOnController.selectedIndices.value.length; i++) {
          debugPrint("selected index: ${formOnController.selectedIndices.value[i]}");
          debugPrint("selected product IDs: ${formOnController.selectedProductsIds.value[i]}");
        }

        bool allSelected = formOnController.areAllProductsSelected();
        debugPrint("All products selected? $allSelected");
      },
      title: Row(
        children: [
          Expanded(child: Text(label)),
        ],
      ),
      controlAffinity: ListTileControlAffinity.leading,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          formOnController.clearSelections();
          return true; // Return true to allow the back navigation
        },
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: SafeArea(
            child: Card(
              child: Container(
                child: Obx(
                      () => formOnController.loadind.value == true
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/uploading.png", scale: 3),
                        SizedBox(height: 20),
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text("Uploading"),
                      ],
                    ),
                  )
                      : ListView.builder(
                    itemCount: formOnController.productsList.value.length,
                    key: PageStorageKey<String>('formkey'),
                    itemBuilder: (context, i) {
                      var product = formOnController.productsList.value[i];

                      if (product == null || product.id == null) {
                        return Container(
                          child: Center(
                            child: Text("No data!!"),
                          ),
                        );
                      }

                      // Ensure the svController lists are properly initialized
                      if (formOnController.selectedIndices.length <= i) {
                        svController.selectedIndices.add(-1);
                      }
                      if (formOnController.selectedProductsIds.length <= i) {
                        formOnController.selectedProductsIds[i] = {
                          'type': '',
                          'productID': ''
                        };
                      }

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 14),
                                child: Text(
                                  "${formOnController.productsList.value[i]!.productName.capitalizeFirst ?? "null"}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Color(0xff25BD62),
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
                                      "Working Ok",
                                      formOnController.productsList.value[i]!.id!),
                                  _buildCheckbox(
                                      i,
                                      1,
                                      "Working Not Ok",
                                      formOnController.productsList.value[i]!.id!),
                                  _buildCheckbox(
                                      i,
                                      2,
                                      "Not Applicable",
                                      formOnController.productsList.value[i]!.id!),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



}
