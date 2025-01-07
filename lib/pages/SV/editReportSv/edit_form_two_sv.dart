import 'dart:ffi';
import 'dart:io';
import 'package:testingevergreen/pages/SV/svController/sv_edit_form_one_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:testingevergreen/Utills/universal.dart';
import '../../../Utills3/utills.dart';
// import '../../../Utills3/utills.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:testingevergreen/appconstants/mycolor.dart';
import 'package:testingevergreen/pages/SE/se_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:testingevergreen/pages/SE/se_models/allProblems.dart'
    as AllProblems;

class ImageItem {
  ImageItem({this.image});

  var image;
}

class EditFormTwoSV extends StatefulWidget {
  const EditFormTwoSV({Key? key}) : super(key: key);

  @override
  State<EditFormTwoSV> createState() => _Form_twoState();
}

class _Form_twoState extends State<EditFormTwoSV> {
  final GlobalKey _dropdownKey = GlobalKey();
  List<String> images = [];
  var selected_category = "";
  var selected_problem_coverd = "";
  var selected_solution = "";
  var postsel = 0;
  var final_selected_category = [];
  var pageBucket = PageStorageBucket();
  final util = Utills();
  final controller = PageController();
  SEController svController = Get.find();
  ScrollController _scrollController = ScrollController();
  DashboardController dashboardController = Get.find();

  var solutionsOptions = ["sol one"];
  var solutionsValuessolutionsValues = {};

  //final List<String> items = List<String>.generate(20, (i) => 'Item ${i + 1}');

  final List<String> problemCoverdOptions = [
    "services_provided",
    "companies",
  ];
  final Map<int, String> problemCoverdValues = {};

  svEditFormOneController sveditFormOneController = Get.find();

  var qty = TextEditingController();

  @override
  void initState() {
    super.initState();
    debugPrint("pagecalled:form_two");
    sveditFormOneController.errorMsg.value =
        "Select problems to get solutions.";
    sveditFormOneController.errorMsg.refresh();
    if (dashboardController.currentSiteID!.value.isNotEmpty) {
      sveditFormOneController
          .getSeEditImages(dashboardController.user_token.value,
              dashboardController.currentSiteID!.value)
          .then((value) {
        if (value != null) {
          debugPrint(
              "nj solutions: ${sveditFormOneController.solutionsMap.value}");

          // Clear existing values

          setState(() {});

          sveditFormOneController.selectedProblemsOptions.clear();
          svController
              .getAllProblems(dashboardController.user_token.value)
              .then((problemvalue) {
            problemvalue!.problems.data.forEach((item) {
              debugPrint("problemsgot: ${item.toString()}");
              sveditFormOneController.selectedProblemsOptions.add(item);
            });

            setState(() {});
            sveditFormOneController.selectedProblemsValues.clear();
            for (var i = 0; i < problemvalue.problems.data.length; i++) {
              if(value.productReportId[i].problemId!=null){
                sveditFormOneController.selectedProblemsValues[i] =
                    value.productReportId[i].problemId!.id!.toString();
              }

            }
          });

          setState(() {});
          sveditFormOneController.getseImageslist.value.map((e) => {});

          problemCoverdValues.clear();
          sveditFormOneController.selectedProblemsValues.clear();
          sveditFormOneController.selectedProblemswithProductIdValues.clear();
          for (var i = 0; i < value.productReportId.length; i++) {

            var problemvoverd =
                value.productReportId[i].problemCovered?.toString() ??
                    'services_provided'; // Handle null case
            if(value.productReportId[i].problemId!=null){
              sveditFormOneController.selectedProblemsValues[i] = value.productReportId[i].problemId!.id!.toString();
            }

            problemCoverdValues[i] = problemvoverd;
            var productId =
                sveditFormOneController.editProductList.value[i]!.productId!.id;

            if(value.productReportId[i].problemId!=null){

              sveditFormOneController.selectedProblemswithProductIdValues
                  .value[productId] = value.productReportId[i].problemId!.id!.toString();
            }

            sveditFormOneController.selectedProblemCoverdwithProductIdValues
                .value[productId] = problemvoverd;
          }

          sveditFormOneController.ProblemCoverdMap.value.forEach((key, value) {
            debugPrint("nj coverd: $key $value");
          });


        }
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        util.showSnackBar("Alert", "No site id found, Try again!", false);
      });
    }

    _scrollController.addListener(() {});
    svController.selectedProblemsOptions.value.clear();
    svController.selectedProblemsOptionsIds.value.clear();
    svController.selectedProblemsValues.clear();
    for (int i = 0; i < svController.problemsList.value.length; i++) {
      svController.selectedProblemsOptions.value
          .add(svController.problemsList.value[i]);
      svController.selectedProblemsOptionsIds.value
          .add(svController.problemsList.value[i]!.id.toString());
      svController.selectedProblemsValues.refresh();
    }

    svController.problemsList.value.map((e) {
      debugPrint("njdebug: ${e!.problem}");
      svController.categories_data.value
          .add(DropdownMenuItem(child: Text("${e.problem}")));
    });

    controller.addListener(() {
      controller.keepPage != true;
    });
  }

  @override
  void dispose() {
    debugPrint("pagecalleddispose:form_two");
    super.dispose();
  }

  void _initializeProductImages(int length) {
    while (sveditFormOneController.productImages.value.length <= length) {
      sveditFormOneController.productImages.value.add([]);
    }
  }

  Future<File> _compressImage(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf('.');
    final splitFileName = filePath.substring(0, lastIndex);
    final outPath = "${splitFileName}_compressed.jpg";

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      quality: 85, // Adjust the quality value as needed
    );

    // Convert XFile to File
    return compressedFile != null ? File(compressedFile.path) : file;
  }

  //List<String> items = ["Item 1", "Item 2", "Item 3", "Item 4"];
  Future<void> _pickImage(int productIndex) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileSize = await file.length();

      // Check if the file size is more than 1 MB (1 MB = 1,048,576 bytes)
      if (fileSize > 3145728) {
        // You can show a message to the user or handle it accordingly
        debugPrint(
            "The selected image is larger than 3 MB. Please select a smaller image.");
        util.showSnackBar(
            "ALert", "The selected image is larger than 3 MB", false);
        return;
      }
      final compressedFile = await _compressImage(file);

      setState(() {
        _initializeProductImages(
            productIndex); // Ensure the productIndex is initialized
        List<File> currentImages =
            sveditFormOneController.productImages[productIndex];
        if (currentImages.length < 3) {
          currentImages.add(compressedFile);
        } else {
          // Replace the first image if there are already 3 images
          currentImages[0] = compressedFile;
        }
        sveditFormOneController.productImages[productIndex] = currentImages;
        debugPrint(
            "selectedimg: ${sveditFormOneController.productImages.value.map((e) => e.toString()).toList()}");
      });
    }
  }

  void _deleteImage(int productIndex, int imageIndex) {
    setState(() {
      if (sveditFormOneController
              .productImages.value[productIndex].isNotEmpty &&
          imageIndex <
              sveditFormOneController
                  .productImages.value[productIndex].length) {
        sveditFormOneController.productImages.value[productIndex]
            .removeAt(imageIndex);
      }
    });
  }

  void _editImage(int productIndex, int imageIndex) {
    setState(() {
      sveditFormOneController.isvisible.value =
          !sveditFormOneController.isvisible.value;
    });
  }

  // final List<ValueNotifier<String>> selectedValues = List.generate(
  //   7,
  //       (index) => ValueNotifier<String>(""),
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Obx(() => InkWell(
              onTap: (){
                sveditFormOneController.scrollToBottom();
              },
              child: Text(
                    "${sveditFormOneController.errorMsg.value}",
                    style: TextStyle(color: Colors.red),
                  ),
            )),
            Expanded(
              child: Obx(
                () => sveditFormOneController.loadind.value == true
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
                        itemBuilder: (c, index) {
                          var product = sveditFormOneController
                              .getseImageslist.value[index];

                          // Ensure the product is not null
                          if (product == null || product.id == null) {
                            return Container(
                              child: Center(
                                child: Text(""),
                              ),
                            ); // or you can show some error widget
                          }

                          _initializeProductImages(
                              index); // Ensure initialization for the current product index

                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Card(
                              elevation: 1,
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
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 8.0),
                                        child: Text(
                                          "${product!.productId.productName}"
                                              .capitalizeFirst!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: Color(0xff25BD62),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    // Horizontal scrollable images

                                    Visibility(
                                        visible: true,
                                        child: SingleChildScrollView(
                                            controller: _scrollController,
                                            scrollDirection: Axis.horizontal,
                                            child: Obx(
                                              () => Row(
                                                children: [
                                                  for (int i = 0;
                                                      i <
                                                          sveditFormOneController
                                                              .getseImageslist
                                                              .value
                                                              .length;
                                                      i++)
                                                    Container(
                                                      child: Card(
                                                        margin:
                                                            EdgeInsets.all(8),
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              height: 200,
                                                              width: MediaQuery.of(context).size.width,
                                                              color: Colors.grey[300],
                                                              child: Center(
                                                                child: Obx(() {
                                                                  // Ensure 'getseImageslist' and its children are observable
                                                                  final imageList = sveditFormOneController.getseImageslist.value;
                                                                  if (imageList.isEmpty || index >= imageList.length) {
                                                                    return Image.asset("assets/images/nodata.jpg");
                                                                  }
                                                                  final image = i == 0
                                                                      ? imageList[index].image0
                                                                      : i == 1
                                                                      ? imageList[index].image1
                                                                      : i == 2
                                                                      ? imageList[index].image2
                                                                      : null;

                                                                  if (image == null || image.isEmpty) {
                                                                    return Image.asset("assets/images/nodata.jpg");
                                                                  }
                                                                  return Image.network(
                                                                    image,
                                                                    fit: BoxFit.cover,
                                                                    errorBuilder: (c, o, e) {
                                                                      return Image.asset("assets/images/nodata.jpg");
                                                                    },
                                                                  );
                                                                }),
                                                              ),
                                                            ),

                                                            // Container(
                                                            //   height: 200,
                                                            //   width:MediaQuery.of(context).size.width,
                                                            //   color: Colors.grey[300],
                                                            //   child: Center(
                                                            //       child: Obx(() {
                                                            //     if (i == 0) {
                                                            //       return Image.network(sveditFormOneController.getseImageslist.value[index].image0 ?? "",
                                                            //         fit: BoxFit.cover, errorBuilder: (c, o, e) {
                                                            //           return Image.asset("assets/images/nodata.jpg");
                                                            //         },
                                                            //       );
                                                            //     }
                                                            //     if (i == 1) {
                                                            //       return Image.network(sveditFormOneController.getseImageslist.value[index].image1 ?? "",
                                                            //         fit: BoxFit.cover,
                                                            //         errorBuilder: (c, o, e) {
                                                            //           return Image.asset("assets/images/nodata.jpg");
                                                            //         },
                                                            //       );
                                                            //     }
                                                            //     if (i == 2) {
                                                            //       return Image.network(
                                                            //         sveditFormOneController.getseImageslist.value[index].image2 ?? "",
                                                            //         fit: BoxFit.cover,
                                                            //         errorBuilder:
                                                            //             (c, o, e) {
                                                            //           return Image.asset("assets/images/nodata.jpg");
                                                            //         },
                                                            //       );
                                                            //     } else {
                                                            //       return Container();
                                                            //     }
                                                            //   })),
                                                            // ),


                                                            // Positioned(
                                                            //   bottom: 0,
                                                            //   left: 0,
                                                            //   right: 0,
                                                            //   child: Row(
                                                            //     mainAxisAlignment:
                                                            //         MainAxisAlignment
                                                            //             .center,
                                                            //     children: [
                                                            //       AppConstant
                                                            //           .getButton(
                                                            //         AppConstant
                                                            //             .getRoboto(
                                                            //           FontWeight
                                                            //               .normal,
                                                            //           10,
                                                            //           Colors
                                                            //               .white,
                                                            //         ),
                                                            //         sveditFormOneController.isvisible.value ==
                                                            //                 false
                                                            //             ? "Edit"
                                                            //             : "Back",
                                                            //         63,
                                                            //         29,
                                                            //         () {
                                                            //           _editImage(
                                                            //               index,
                                                            //               i);
                                                            //         },
                                                            //       ),
                                                            //     ],
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ))),

                                    SingleChildScrollView(
                                        controller: _scrollController,
                                        scrollDirection: Axis.horizontal,
                                        child: Obx(
                                          () => Row(
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      sveditFormOneController
                                                          .productImages
                                                          .value[index]
                                                          .length;
                                                  i++)
                                                Container(
                                                  child: Card(
                                                    margin: EdgeInsets.all(8),
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          height: 200,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              100,
                                                          color:
                                                              Colors.grey[300],
                                                          child: Center(
                                                              child: Obx(
                                                            () => Image.file(
                                                              sveditFormOneController
                                                                  .productImages
                                                                  .value[index][i],
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )),
                                                        ),
                                                        Positioned(
                                                          bottom: 0,
                                                          left: 0,
                                                          right: 0,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              AppConstant
                                                                  .getButton(
                                                                AppConstant
                                                                    .getRoboto(
                                                                  FontWeight
                                                                      .normal,
                                                                  10,
                                                                  Colors.white,
                                                                ),
                                                                "Delete",
                                                                63,
                                                                29,
                                                                () {
                                                                  _deleteImage(
                                                                      index, i);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              if (sveditFormOneController
                                                      .productImages
                                                      .value[index]
                                                      .length <
                                                  3)
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  child: Card(
                                                    margin: EdgeInsets.all(8),
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          color:
                                                              Colors.grey[300],
                                                          child: Center(
                                                            child: Container(
                                                              height: 200,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  100,
                                                              child: Center(
                                                                child: Text(
                                                                    "New updated images"),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom: 0,
                                                          left: 0,
                                                          right: 0,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              AppConstant
                                                                  .getTapButton(
                                                                AppConstant
                                                                    .getRoboto(
                                                                  FontWeight
                                                                      .normal,
                                                                  10,
                                                                  Colors.white,
                                                                ),
                                                                "Upload",
                                                                63,
                                                                29,
                                                                () {
                                                                  _pickImage(
                                                                      index);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        )),

                                    SizedBox(height: 20),
                                    Text(
                                      "Upload 3 photos max",
                                      style: AppConstant.getRoboto(
                                        FontWeight.w700,
                                        AppConstant.HEADLINE_SIZE_12,
                                        Color(0xff265B3A),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 400,
                                        height: 60,
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Container(
                                          //  width: new FractionColumnWidth(0.5).value,
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: sveditFormOneController
                                                  .selectedProblemsValues
                                                  .value[index],
                                              hint: Text('Select problems'),
                                              onChanged: (String? newValue) {
                                                sveditFormOneController
                                                    .solutionMap
                                                  ..clear();
                                                sveditFormOneController
                                                    .getSolutions(
                                                        dashboardController
                                                            .user_token.value,
                                                        newValue!)
                                                    .then((value) {
                                                  if (value!.solution.solution
                                                          .toString() !=
                                                      "[]") {
                                                    sveditFormOneController
                                                            .solutionMap
                                                            .value[index] =
                                                        value.solution.solution
                                                            .first
                                                            .toString();
                                                    sveditFormOneController
                                                        .solutionMap
                                                      ..refresh();
                                                    sveditFormOneController
                                                        .solutionsOptions.value
                                                        .addIf(
                                                            !sveditFormOneController
                                                                .solutionsOptions
                                                                .value
                                                                .contains(value
                                                                    .solution
                                                                    .solution
                                                                    .first
                                                                    .toString()),
                                                            value.solution
                                                                .solution.first
                                                                .toString());

                                                    sveditFormOneController
                                                        .solutionsOptions
                                                        .refresh();
                                                  }
                                                });

                                                // sveditFormOneController
                                                //     .getSolutions(
                                                //         dashboardController
                                                //             .user_token.value,
                                                //         newValue!)
                                                //     .then((data) {
                                                //   if (data!.solution.solution !=
                                                //       null) {
                                                //     debugPrint(
                                                //         "mysol${data!.solution.solution}");
                                                //   }
                                                // });

                                                sveditFormOneController
                                                    .selectedProblemsValues
                                                    .value[index] = newValue!;

                                                sveditFormOneController
                                                        .selectedProblemswithProductIdValues
                                                        .value[
                                                    sveditFormOneController
                                                        .editProductList
                                                        .value[index]!
                                                        .productId!
                                                        .id] = newValue;
                                                setState(() {});
                                              },
                                              items: sveditFormOneController
                                                  .selectedProblemsOptions.value
                                                  .map<DropdownMenuItem<String>>(
                                                      (value) {
                                                return DropdownMenuItem<String>(
                                                  value: value!.id,
                                                  child: Text(value.problem),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Obx(() => Visibility(
                                          visible: dashboardController
                                                  .user_role.value !=
                                              "super_engineer",
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 400,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        offset: const Offset(
                                                            5.0, 5.0),
                                                        blurRadius: 10.0,
                                                        spreadRadius: 2.0,
                                                      ),
                                                      BoxShadow(
                                                        color: Colors.white,
                                                        offset: const Offset(
                                                            0.0, 0.0),
                                                        blurRadius: 0.0,
                                                        spreadRadius: 0.0,
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                      color: MyColor
                                                          .OUTLINE_COLOR_POST,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child:
                                                        DropdownButton<String>(
                                                      value: problemCoverdValues[
                                                                      index] !=
                                                                  null &&
                                                              problemCoverdOptions
                                                                  .contains(
                                                                      problemCoverdValues[
                                                                          index])
                                                          ? problemCoverdValues[
                                                              index]
                                                          : null,
                                                      hint: Text(
                                                          'Select problem covered'),
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          problemCoverdValues[
                                                                  index] =
                                                              newValue ?? '';
                                                          debugPrint(
                                                              "newval: $newValue");

                                                          sveditFormOneController
                                                                  .selectedProblemCoverdwithProductIdValues
                                                                  .value[
                                                              sveditFormOneController
                                                                  .editProductList
                                                                  .value[index]!
                                                                  .productId!
                                                                  .id] = newValue ??
                                                              '';

                                                          debugPrint(
                                                              "newval: ${sveditFormOneController.editProductList.value[index]!.productId!.id}");
                                                          debugPrint(
                                                              "newval: ${sveditFormOneController.selectedProblemCoverdwithProductIdValues.value[sveditFormOneController.editProductList.value[index]!.productId!.id]}");
                                                        });
                                                      },
                                                      items: problemCoverdOptions
                                                          .map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Obx(
                                                  () {
                                                    if (sveditFormOneController
                                                            .solutionsOptions
                                                            .isNotEmpty &&
                                                        index <
                                                            sveditFormOneController
                                                                .solutionsValues
                                                                .length) {
                                                      String? currentValue =
                                                          sveditFormOneController
                                                                  .solutionsValues[
                                                              index];

                                                      // Ensure the current value is part of the solutionsOptions
                                                      if (!sveditFormOneController
                                                          .solutionsOptions
                                                          .contains(
                                                              currentValue)) {
                                                        debugPrint(
                                                            "Invalid value detected: $currentValue. Resetting to first available option.");
                                                        currentValue =
                                                            sveditFormOneController
                                                                .solutionsOptions
                                                                .first;
                                                        sveditFormOneController
                                                                .solutionsValues[
                                                            index] = currentValue;
                                                      }

                                                      return Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 400,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              offset: Offset(
                                                                  5.0, 5.0),
                                                              blurRadius: 10.0,
                                                              spreadRadius: 2.0,
                                                            ),
                                                            BoxShadow(
                                                              color:
                                                                  Colors.white,
                                                              offset: Offset(
                                                                  0.0, 0.0),
                                                              blurRadius: 0.0,
                                                              spreadRadius: 0.0,
                                                            ),
                                                          ],
                                                          border: Border.all(
                                                            color: MyColor
                                                                .OUTLINE_COLOR_POST,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: DropdownButton<
                                                            String>(
                                                          value: currentValue,
                                                          onChanged: (String?
                                                              newValue) {
                                                            sveditFormOneController
                                                                    .selectedSolutionswithProductIdValues
                                                                    .value[
                                                                sveditFormOneController
                                                                    .getseImageslist
                                                                    .value[
                                                                        index]
                                                                    .productId
                                                                    .id] = newValue!;
                                                            sveditFormOneController
                                                                    .solutionsValues[
                                                                index] = newValue!;
                                                          },
                                                          items: sveditFormOneController
                                                              .solutionsOptions
                                                              .map<
                                                                  DropdownMenuItem<
                                                                      String>>((String
                                                                  value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      );
                                                    } else {
                                                      return Container();
                                                    }
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: sveditFormOneController
                            .getseImageslist.value.length,
                        key: PageStorageKey<String>('formkey'),
                        controller: sveditFormOneController.scrollController,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*Builder(
                                        builder: (context) => DropdownButtonFormField<String>(
                                          autofocus: true,
                                          isDense: true,
                                          isExpanded: true,
                                          decoration: InputDecoration.collapsed(
                                            fillColor: Colors.transparent,
                                            filled: true,
                                            hintText: "",
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          hint: Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 18.0),
                                              child: Text(
                                                "Select Problem Name",
                                                style: AppConstant.getRoboto(
                                                  FontWeight.w400,
                                                  AppConstant.HEADLINE_SIZE_15,
                                                  Color(0xff265B3A),
                                                ),
                                              ),
                                            ),
                                          ),
                                          items: svController.categories_data.value,
                                          onChanged: (String? value) {
                                            selectedValues[index].value = value!;
                                          },
                                        ),
                                      ),*/
