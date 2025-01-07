import 'dart:io';
import 'package:testingevergreen/pages/SE/se_edit_controller/se_edit_fromone_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:testingevergreen/pages/imageShow/image_show.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:testingevergreen/Utills/universal.dart';
import '../../../Utills3/utills.dart';
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

class EditFormTwoSE extends StatefulWidget {
  bool? viewOnly = false;

  EditFormTwoSE({Key? key, this.viewOnly = false}) : super(key: key);

  @override
  State<EditFormTwoSE> createState() => _Form_twoState();
}

class _Form_twoState extends State<EditFormTwoSE> {
  final GlobalKey _dropdownKey = GlobalKey();

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
  SeEditFormOneController seEditFormOneController = Get.find();
  DashboardController dashboardController = Get.find();

  //final List<String> items = List<String>.generate(20, (i) => 'Item ${i + 1}');

  final List<String> problemCoverdOptions = [
    "problem covered 1",
    "problem covered 2",
    "problem covered 3",
  ];
  final Map<int, String> problemCoverdValues = {};

  final List<String> solutionsOptions = [
    "sol 1",
    "sol 2",
    "sol 3",
  ];
  final Map<int, String> solutionsValues = {};

  var qty = TextEditingController();

  @override
  void initState() {
    super.initState();
    debugPrint("pagecalled:form_two");

    if (dashboardController.currentSiteID!.value.isNotEmpty) {
      seEditFormOneController
          .getSeEditImages(dashboardController.user_token.value,
              dashboardController.currentSiteID!.value)
          .then((value) {
        if (value != null) {
          seEditFormOneController.selectedProblemsOptions.clear();
          svController
              .getAllProblems(dashboardController.user_token.value)
              .then((problemvalue) {
            problemvalue!.problems.data.forEach((item) {
              debugPrint("problemsgot:${item.toString()}");
              seEditFormOneController.selectedProblemsOptions.add(item);
            });
            setState(() {});
            seEditFormOneController.selectedProblemsValues.clear();
            for (var i = 0; i < problemvalue!.problems.data.length; i++) {
              if (value.productReportId[i].problemId != null) {
                seEditFormOneController.selectedProblemsValues[i] =
                    value.productReportId[i].problemId!.id!.toString();
              }
            }
          });
          setState(() {});

          seEditFormOneController.selectedProblemsValues.clear();
          seEditFormOneController.selectedProblemswithProductIdValues.clear();
          for (var i = 0; i < value.productReportId.length; i++) {
            var problemId = value.productReportId[i].problemId!.id!.toString();
            seEditFormOneController.selectedProblemsValues[i] = problemId;
            var productId =
                seEditFormOneController.editProductList.value[i]!.productId!.id;
            seEditFormOneController.selectedProblemswithProductIdValues
                .value[productId] = problemId;
          }
        }
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        util.showSnackBar("Alert", "No site id found,Try again!",
            false); // or your code that uses visitChildElements
      });
    }

    _scrollController.addListener(() {});
    // svController.categories_data.value.clear();
    // for (int i = 0; i < svController.problemsList.value.length; i++) {
    //   svController.categories_data.value.add(DropdownMenuItem(
    //     value: svController.problemsList.value[i]!.problem.toString(),
    //     child: Text(svController.problemsList.value[i]!.problem.toString()),
    //   ));
    // }

    svController.selectedProblemsOptions.value.clear();
    svController.selectedProblemsOptionsIds.value.clear();

    svController.selectedProblemsValues.clear();
    for (int i = 0; i < svController.problemsList.value.length; i++) {
      svController.selectedProblemsOptions.value.add(
        svController.problemsList.value[i],
      );
      svController.selectedProblemsOptionsIds.value.add(
        svController.problemsList.value[i]!.id.toString(),
      );
      svController.selectedProblemsValues.refresh();
    }

    svController.problemsList.value.map((e) {
      debugPrint("njdebug:${e!.problem}");
      svController.categories_data.value
          .add(DropdownMenuItem(child: Text("${e!.problem}")));
    });
    debugPrint("form2+called");

    for (int i = 0;
        i < seEditFormOneController.getseImageslist.value.length;
        i++) {}

    controller.addListener(() {
      controller.keepPage != true;
    });
  }

  @override
  void dispose() {
    debugPrint("pagecalleddispose:form_two");
    super.dispose();
  }

  void _initializeProductImages(int productIndex) {
    if (seEditFormOneController.productImages.length <= productIndex) {
      seEditFormOneController.productImages.addAll(
        List.generate(
          productIndex - seEditFormOneController.productImages.length + 1,
          (index) => [],
        ),
      );
    }
  }

  //List<String> items = ["Item 1", "Item 2", "Item 3", "Item 4"];
  Future<void> _pickImage(int productIndex) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Get the file and its size
      final file = File(pickedFile.path);
      final fileSize = await file.length();

      // Check if the file size is more than 1 MB (1 MB = 1,048,576 bytes)
      if (fileSize > 3145728) {
        // You can show a message to the user or handle it accordingly
        debugPrint(
            "The selected image is larger than 1 MB. Please select a smaller image.");
        util.showSnackBar(
            "ALert", "The selected image is larger than 1 MB", false);
        return;
      }

      // Compress the image
      final compressedFile = await _compressImage(file);

      setState(() {
        _initializeProductImages(
            productIndex); // Ensure the productIndex is initialized
        // Get the current list of images for the product index
        List<File> currentImages =
            seEditFormOneController.productImages[productIndex];

        if (currentImages.length < 3) {
          currentImages.add(compressedFile);
        } else {
          // Replace the first image if there are already 3 images
          currentImages[0] = compressedFile;
        }

        // Update the product images list at the specified index
        seEditFormOneController.productImages[productIndex] = currentImages;

        debugPrint("selectedimg: ${seEditFormOneController.productImages}");
      });
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

  void _deleteImage(int productIndex, int imageIndex) {
    setState(() {
      if (productIndex < seEditFormOneController.productImages.length) {
        List<File> currentImages =
            seEditFormOneController.productImages[productIndex];
        if (imageIndex < currentImages.length) {
          currentImages.removeAt(imageIndex);
          seEditFormOneController.productImages[productIndex] = currentImages;

          debugPrint(
              "Image deleted. Current images: ${seEditFormOneController.productImages}");
        }
      }
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
            Expanded(
              child: Obx(
                () => seEditFormOneController.loadind.value == true
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
                        child: ListView.builder(
                          itemBuilder: (c, index) {
                            var product = seEditFormOneController
                                .getseImageslist.value[index];

                            // Ensure the product is not null
                            if (product == null || product.id == null) {
                              return Container(
                                child: Center(
                                  child: Text(""),
                                ),
                              ); // or you can show some error widget
                            }

                            // // Preload images
                            // var imageWidgets = <Widget>[];
                            // if (product.image0 != null) {
                            //   imageWidgets.add(Image.network(
                            //     product.image0!,
                            //     fit: BoxFit.cover,
                            //   ));
                            // }
                            // if (product.image1 != null) {
                            //   imageWidgets.add(Image.network(
                            //     product.image1!,
                            //     fit: BoxFit.cover,
                            //   ));
                            // }
                            // if (product.image2 != null) {
                            //   imageWidgets.add(Image.network(
                            //     product.image2!,
                            //     fit: BoxFit.cover,
                            //   ));
                            // }

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

                                      SingleChildScrollView(
                                        controller: _scrollController,
                                        scrollDirection: Axis.horizontal,
                                        child: InkWell(
                                            child: Obx(
                                          () => Row(
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      seEditFormOneController
                                                          .getseImageslist
                                                          .value
                                                          .length;
                                                  i++)
                                                InkWell(
                                                  onTap: () {
                                                    if (i == 0 &&
                                                        seEditFormOneController
                                                                .getseImageslist
                                                                .value[index]
                                                                .image0 !=
                                                            null) {
                                                      Get.to(() => ImageShow(
                                                          URL: seEditFormOneController
                                                              .getseImageslist
                                                              .value[index]
                                                              .image0));
                                                    } else if (i == 0 &&
                                                        seEditFormOneController
                                                                .getseImageslist
                                                                .value[index]
                                                                .image1 !=
                                                            null) {
                                                      Get.to(() => ImageShow(
                                                          URL: seEditFormOneController
                                                              .getseImageslist
                                                              .value[index]
                                                              .image1));
                                                    } else {
                                                      if (seEditFormOneController
                                                              .getseImageslist
                                                              .value[index]
                                                              .image2 !=
                                                          null) {
                                                        Get.to(() => ImageShow(
                                                            URL: seEditFormOneController
                                                                .getseImageslist
                                                                .value[index]
                                                                .image2));
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    child: Card(
                                                      margin: EdgeInsets.all(8),
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            height: 200,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            color: Colors
                                                                .grey[300],
                                                            child: Center(
                                                                child: Obx(
                                                              () => i == 0
                                                                  ? Image
                                                                      .network(
                                                                      seEditFormOneController
                                                                              .getseImageslist
                                                                              .value[index]
                                                                              .image0 ??
                                                                          "",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      errorBuilder:
                                                                          (c, o,
                                                                              e) {
                                                                        return Image.asset(
                                                                            "assets/images/nodata.jpg");
                                                                      },
                                                                    )
                                                                  : i == 1
                                                                      ? Image
                                                                          .network(
                                                                          seEditFormOneController.getseImageslist.value[index].image1 ??
                                                                              "",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          errorBuilder: (c,
                                                                              o,
                                                                              e) {
                                                                            return Image.asset("assets/images/nodata.jpg");
                                                                          },
                                                                        )
                                                                      : Image
                                                                          .network(
                                                                          seEditFormOneController.getseImageslist.value[index].image2 ??
                                                                              "",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          errorBuilder: (c,
                                                                              o,
                                                                              e) {
                                                                            return Image.asset("assets/images/nodata.jpg");
                                                                          },
                                                                        ),
                                                            )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        )),
                                      ),
                                      SingleChildScrollView(
                                          controller: _scrollController,
                                          scrollDirection: Axis.horizontal,
                                          child: Obx(
                                            () => Row(
                                              children: [
                                                for (int i = 0;
                                                    i <
                                                        seEditFormOneController
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
                                                            color: Colors
                                                                .grey[300],
                                                            child: Center(
                                                                child: Obx(
                                                              () => Image.file(
                                                                seEditFormOneController
                                                                        .productImages
                                                                        .value[
                                                                    index][i],
                                                                fit: BoxFit
                                                                    .cover,
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
                                                                    Colors
                                                                        .white,
                                                                  ),
                                                                  "Delete",
                                                                  63,
                                                                  29,
                                                                  () {
                                                                    _deleteImage(
                                                                        index,
                                                                        i);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                if (seEditFormOneController
                                                        .productImages
                                                        .value[index]
                                                        .length <
                                                    3)
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    child: Card(
                                                      margin: EdgeInsets.all(8),
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            color: Colors
                                                                .grey[300],
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
                                                                    Colors
                                                                        .white,
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
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: seEditFormOneController
                                                  .selectedProblemsValues
                                                  .value[index],
                                              hint: Text('Select problems'),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  seEditFormOneController
                                                      .selectedProblemsValues
                                                      .value[index] = newValue!;

                                                  seEditFormOneController
                                                          .selectedProblemswithProductIdValues
                                                          .value[
                                                      seEditFormOneController
                                                          .editProductList
                                                          .value[index]!
                                                          .productId!
                                                          .id] = newValue;
                                                });
                                              },
                                              items: seEditFormOneController
                                                  .selectedProblemsOptions.value
                                                  .map<
                                                      DropdownMenuItem<
                                                          String>>((value) {
                                                return DropdownMenuItem<String>(
                                                  value: value!.id,
                                                  child: Text(value.problem),
                                                );
                                              }).toList(),
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
                                                      child: DropdownButton<
                                                          String>(
                                                        value:
                                                            problemCoverdValues[
                                                                index],
                                                        hint: Text('Select'),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            problemCoverdValues[
                                                                    index] =
                                                                newValue!;
                                                          });
                                                        },
                                                        items: problemCoverdOptions.map<
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
                                                      child: DropdownButton<
                                                          String>(
                                                        value: solutionsValues[
                                                            index],
                                                        hint: Text('Select'),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            solutionsValues[
                                                                    index] =
                                                                newValue!;
                                                          });
                                                        },
                                                        items: solutionsOptions.map<
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
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: seEditFormOneController
                              .getseImageslist.value.length,
                          key: PageStorageKey<String>('formkey'),
                          controller: seEditFormOneController.scrollController,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
