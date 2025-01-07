import 'dart:io';
import 'package:testingevergreen/pages/SE/se_controller/form_on_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
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

class FormTwo extends StatefulWidget {
  const FormTwo({Key? key}) : super(key: key);

  @override
  State<FormTwo> createState() => _Form_twoState();
}

class _Form_twoState extends State<FormTwo> {
  final GlobalKey _dropdownKey = GlobalKey();
  FormOnController formOnController = Get.find();
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
      formOnController
          .getProducts(dashboardController.user_token.value,
          dashboardController.currentSiteID!.value);
      formOnController
          .getNotEmptyValues(dashboardController.user_token.value,
          dashboardController.currentSiteID!.value)
          .then((value) {
        if (value != null) {
          value.products.forEach((item) {
            debugPrint("emptyvalues:${item.productName}");
          });
          svController
              .getAllProblems(dashboardController.user_token.value)
              .then((value) {
            value!.problems.data.forEach((item) {
              debugPrint("problemsgot:${item.toString()}");
              formOnController.selectedProblemsOptions.add(item);
            });
            setState(() {});
          });
        }
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        util.showSnackBar("Alert", "No site id found,Try again!", false);
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

    formOnController.selectedProblemsOptions.value.clear();
    formOnController.selectedProblemsOptionsIds.value.clear();

    formOnController.selectedProblemsValues.clear();
    formOnController.productsList.value.clear();
    for (int i = 0; i < formOnController.problemsList.value.length; i++) {
      formOnController.selectedProblemsOptions.value.add(
        formOnController.problemsList.value[i],
      );
      formOnController.selectedProblemsOptionsIds.value.add(
        formOnController.problemsList.value[i]!.id.toString(),
      );
      formOnController.selectedProblemsValues.refresh();
    }

    formOnController.problemsList.value.map((e) {
      debugPrint("njdebug:${e!.problem}");
      formOnController.categories_data.value
          .add(DropdownMenuItem(child: Text("${e!.problem}")));
    });
    debugPrint("form2+called");
    images.add("assets/images/test.png");
    images.add("assets/images/test.png");
    images.add("assets/images/test.png");
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
    while (formOnController.productImages.value.length <= length) {
      formOnController.productImages.value.add([]);
    }
  }

  //List<String> items = ["Item 1", "Item 2", "Item 3", "Item 4"];
  Future<void> _pickImage(int productIndex) async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileSize = await file.length();
      if (fileSize > 3145728) {
        // You can show a message to the user or handle it accordingly
        debugPrint(
            "The selected image is larger than 1 MB. Please select a smaller image.");
        util.showSnackBar(
            "ALert", "The selected image is larger than 1 MB", false);
        return;
      }
      final compressedFile = await _compressImage(file);
      setState(() {
        _initializeProductImages(
            productIndex); // Ensure the productIndex is initialized
        List<File> currentImages = formOnController.productImages[productIndex];
        if (currentImages.length < 3) {
          currentImages.add(compressedFile);
        } else {
          // Replace the first image if there are already 3 images
          currentImages[0] = compressedFile;
        }
        formOnController.productImages[productIndex] = currentImages;

        debugPrint("selectedimg: ${formOnController.productImages}");
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
      if (formOnController.productImages.value[productIndex].isNotEmpty &&
          imageIndex <
              formOnController.productImages.value[productIndex].length) {
        formOnController.productImages.value[productIndex].removeAt(imageIndex);
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
                    () => formOnController.loadind.value == true
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
                    var product =
                    formOnController.productsList.value[index];

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

                    return Visibility(
                      visible: formOnController.selectedIndices.value[index]==1,
                      child: Container(
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
                                      "${product.productName}"
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
                                    child: Obx(
                                          () => Row(
                                        children: [
                                          for (int i = 0;
                                          i <
                                              formOnController
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
                                                          .width,
                                                      color:
                                                      Colors.grey[300],
                                                      child: Center(
                                                          child: Obx(
                                                                () => Image.file(
                                                              formOnController
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
                                          if (formOnController.productImages
                                              .value[index].length <
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
                                                      color: Colors
                                                          .grey[300],
                                                      child: Center(
                                                        child:
                                                        Container(
                                                          height: 200,
                                                          width: MediaQuery.of(context).size.width-100,
                                                          child: Center(child: Text("Add new images"),),
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
                                      child: DropdownButton<String>(
                                        value: formOnController
                                            .selectedProblemsValues
                                            .value[index],
                                        isExpanded: true,
                                        hint: Text('Select problems'),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            formOnController
                                                .selectedProblemsValues
                                                .value[index] = newValue!;
                                            formOnController
                                                .selectedProblemswithProductIdValues
                                                .value[
                                            formOnController
                                                .productsList
                                                .value[index]!
                                                .id] = newValue;
                                          });
                                        },
                                        items: formOnController
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
                                                      String>>(
                                                      (String value) {
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
                      ),
                    );
                  },
                  itemCount:
                  formOnController.productsList.value.length,
                  key: PageStorageKey<String>('formkey'),
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
