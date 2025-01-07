// import 'dart:async';
// import 'dart:io';
//
// // import 'package:testingevergreen/Utills/universal.dart';
// import '../../../Utills3/utills.dart';
// import 'package:testingevergreen/appconstants/appconstants.dart';
// import 'package:testingevergreen/pages/SE/se_controller.dart';
// import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:get/get.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../Utills3/universal.dart';
//
// class SEAttendance extends StatefulWidget {
//   String? siteID;
//
//   SEAttendance({required String siteid}) {
//     this.siteID = siteid;
//   }
//
//   @override
//   State<SEAttendance> createState() => _SEAttendanceState(siteID!);
// }
//
// class _SEAttendanceState extends State<SEAttendance> {
//   String? siteID;
//
//   _SEAttendanceState(String sid) {
//     this.siteID = sid;
//   }
//
//   SEController svController = Get.find();
//
//   DashboardController dashboardController = Get.find();
//   final util = Utills();
//   ImagePicker picker = ImagePicker();
//
//   Future<File> _compressImage(File file) async {
//     final filePath = file.absolute.path;
//     final lastIndex = filePath.lastIndexOf('.');
//     final splitFileName = filePath.substring(0, lastIndex);
//     final outPath = "${splitFileName}_compressed.jpg";
//
//     final compressedFile = await FlutterImageCompress.compressAndGetFile(
//       filePath,
//       outPath,
//       quality: 85, // Adjust the quality value as needed
//     );
//
//     // Convert XFile to File
//     return compressedFile != null ? File(compressedFile.path) : file;
//   }
//
//   choose_image(ImageSource source) async {
//     final pickedFile = await picker.pickImage(source: source, imageQuality: 50);
//     if (pickedFile != null) {
//       final file = File(pickedFile.path);
//       final fileSize = await file.length();
//
//       // Check if the file size is more than 1 MB (1 MB = 1,048,576 bytes)
//       if (fileSize > 3145728) {
//         // You can show a message to the user or handle it accordingly
//         debugPrint(
//             "The selected image is larger than 3 MB. Please select a smaller image.");
//         util.showSnackBar(
//             "ALert", "The selected image is larger than 1 MB", false);
//         return;
//       }
//       final compressedFile = await _compressImage(file);
//       setState(() async {
//         svController.image = compressedFile;
//         svController.fimage1.value = compressedFile;
//         // await _dashboardController.uploadImage(
//         //     reg_controller.fimage1!, "${_dashboardController.uid.value}");
//       });
//     }
//   }
//
//   Dialog selectImage(BuildContext context) {
//     return Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0)), //this right here
//         child: Container(
//           height: 200.0,
//           width: 200.0,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Select',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Please select image from:',
//                   style: TextStyle(color: Colors.black, fontSize: 14),
//                 ),
//               ),
//               Padding(padding: EdgeInsets.only(top: 20.0)),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MaterialButton(
//                         onPressed: () async {
//                           Navigator.of(context).pop();
//                           if (dashboardController.uid.value.isNotEmpty) {
//                             choose_image(ImageSource.camera);
//                           } else {
//                             util.showSnackBar(
//                                 "Alert", "Couldn't fetch uid!", false);
//                           }
//                         },
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: Text("CAMERA"),
//                         color: Colors.green,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       MaterialButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//
//                           if (dashboardController.uid.isNotEmpty) {
//                             choose_image(ImageSource.gallery);
//                           } else {
//                             util.showSnackBar(
//                                 "Alert", "Couldn't fetch data!", false);
//                           }
//                         },
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: Text("GALLERY"),
//                         color: Colors.green,
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ));
//   }
//
//   String formatTime(int seconds) {
//     int minutes = seconds ~/ 60;
//     int remainingSeconds = seconds % 60;
//     return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     svController.startTimer();
//     AppConstant.getUserData("user_data").then((value) => {
//           if (value!.user_token.isNotEmpty)
//             {svController.userToken.value = value!.user_token}
//           else
//             {}
//         });
//     dashboardController.getCurrentLocation().then((value) => {
//           if (value == LocationStatus.available)
//             {
//               svController
//                   .fetchDateTime()
//                   .then((value) => {if (value != null) {}})
//             }
//         });
//   }
//
//   @override
//   void dispose() {
//     svController.cancelTimer();
//     svController.fimage1.value = null;
//     //svController.fimage1.value = null;
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Container(
//       margin: EdgeInsets.only(left: 10, right: 10),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           backToolbar(name: "Attendance "),
//           Obx(() => dashboardController.process == loadingNJ.finished
//               ? Expanded(
//                   child: ListView.builder(
//                   itemBuilder: (c, i) {
//                     return Card(
//                       elevation: 1,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 8.0, horizontal: 8.0),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: AppConstant.shadow_bottom()),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       top: 8.0, bottom: 8.0),
//                                   child: Text(
//                                     i == 0 ? "In Time" : "Out Time",
//                                     style: AppConstant.getRoboto(
//                                         FontWeight.w700, 18, Color(0xff494F4D)),
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     showDialog(
//                                         context: context,
//                                         builder: (BuildContext context) =>
//                                             selectImage(context));
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       border: Border.all(color: Colors.green),
//                                     ),
//                                     child: ClipOval(
//                                       child: Obx(() =>
//                                           svController.fimage1.value == null
//                                               ? Image.asset(
//                                                   "assets/images/selfie_logo.png",
//                                                   scale: 2,
//                                                 )
//                                               : Image.file(
//                                                   svController.fimage1.value!,
//                                                   filterQuality:
//                                                       FilterQuality.low,
//                                                   fit: BoxFit.cover,
//                                                   scale: 1,
//                                                   alignment: Alignment.center,
//                                                   cacheWidth: 50,
//                                                   cacheHeight: 50,
//                                                 )),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 4,
//                                 ),
//                                 Text(
//                                   "Take Selfie",
//                                   style: AppConstant.getRoboto(
//                                       FontWeight.w700,
//                                       AppConstant.HEADLINE_SIZE_12,
//                                       Color(0xff53C17F)),
//                                 )
//                               ],
//                             ),
//                             Obx(
//                               () => Text(
//                                 "${svController.current_time.value}",
//                                 style: AppConstant.getRoboto(
//                                     FontWeight.w800,
//                                     AppConstant.HEADLINE_SIZE_25,
//                                     Color(0xff4FB578)),
//                               ),
//                             ),
//                             BounceableButton(
//                               onTap: () {
//                                 // var res=svController.calculateDistance(22.7492967, 75.9146905, 22.6588533, 75.8042773).then((value) => {
//                                 // util.showSnackBar("Alert", value.toStringAsFixed(2), true)
//                                 // });
//                                 if (svController.currentSeconds == 0) {
//                                   util.showSnackBar(
//                                       "Alert",
//                                       "you can not fill attendance reload page.",
//                                       false);
//                                   return null;
//                                 }
//                                 if (i == 0) {
//                                   if (dashboardController
//                                       .user_token.value.isNotEmpty) {
//                                     if (dashboardController
//                                             .lattitude.value.isNotEmpty &&
//                                         dashboardController
//                                             .longitude.value.isNotEmpty) {
//                                       if (widget.siteID!.isNotEmpty) {
//                                         if (dashboardController
//                                             .user_role.value.isNotEmpty) {
//                                           svController
//                                               .seAttendance(
//                                                   dashboardController
//                                                       .user_token.value,
//                                                   "in",
//                                                   dashboardController
//                                                       .lattitude.value,
//                                                   dashboardController
//                                                       .longitude.value,
//                                                   widget.siteID!,
//                                                   dashboardController
//                                                       .user_role.value)
//                                               .then((value) => {
//                                                     if (value != null)
//                                                       {
//                                                         if (i == 0)
//                                                           {
//                                                             util.showSnackBar(
//                                                                 "Alert",
//                                                                 "IN Attendance has recorded",
//                                                                 true)
//                                                           }
//                                                       }
//                                                     else
//                                                       {
//                                                         // util.showSnackBar(
//                                                         //     "Alert",
//                                                         //     "failed",
//                                                         //     false)
//                                                       }
//                                                   });
//                                         } else {
//                                           util.showSnackBar("Alert",
//                                               "No user type found!", false);
//                                         }
//                                       } else {
//                                         util.showSnackBar("Alert",
//                                             "No site id found!", false);
//                                       }
//                                     } else {
//                                       util.showSnackBar(
//                                           "Alert", "No Lat/Long found!", false);
//                                     }
//                                   } else {
//                                     util.showSnackBar(
//                                         "Alert", "No user token found!", false);
//                                   }
//                                 } else {
//                                   if (dashboardController
//                                       .user_token.value.isNotEmpty) {
//                                     if (dashboardController
//                                             .lattitude.value.isNotEmpty &&
//                                         dashboardController
//                                             .longitude.value.isNotEmpty) {
//                                       if (widget.siteID!.isNotEmpty) {
//                                         if (dashboardController
//                                             .user_role.value.isNotEmpty) {
//                                           svController
//                                               .seAttendance(
//                                                   dashboardController
//                                                       .user_token.value,
//                                                   "out",
//                                                   dashboardController
//                                                   .lattitude.value,
//                                                   dashboardController
//                                                       .longitude.value,
//                                                   widget.siteID!,
//                                                   dashboardController
//                                                       .user_role.value)
//                                               .then((value) => {
//                                                     if (value != null)
//                                                       {
//                                                         util.showSnackBar(
//                                                             "Alert",
//                                                             "OUT Attendance has recorded",
//                                                             true)
//                                                       }
//                                                     else
//                                                       {
//                                                         // util.showSnackBar(
//                                                         //     "Alert",
//                                                         //     "failed",
//                                                         //     false)
//                                                       }
//                                                   });
//                                         } else {
//                                           util.showSnackBar('Alert',
//                                               "No user type found!", false);
//                                         }
//                                       } else {
//                                         util.showSnackBar("Alert",
//                                             "No site id found!", false);
//                                       }
//                                     } else {
//                                       util.showSnackBar(
//                                           "Alert", "No Lat/Long found!", false);
//                                     }
//                                   } else {
//                                     util.showSnackBar(
//                                         "Alert", "No user token found!", false);
//                                   }
//                                 }
//                               },
//                               text: 'Done',
//                               width: 95,
//                               height: 48,
//                               gradient: AppConstant.BUTTON_COLOR,
//                               borderRadius: 20,
//                               fontSize: AppConstant.HEADLINE_SIZE_20,
//                               fontWeight: FontWeight.w700,
//                               textColor: Colors.white,
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   itemCount: 2,
//                 ))
//               : Expanded(
//                   child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SpinKitFadingFour(
//                         color: Colors.blue,
//                         size: 50.0,
//                       ),
//                       SizedBox(height: 20),
//                       Text('Fetching...')
//                     ],
//                   ),
//                 ))),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Text(
//                   "Time left to fill attendance",
//                   style: AppConstant.getRoboto(FontWeight.w800,
//                       AppConstant.HEADLINE_SIZE_20, Colors.black),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Obx(
//                 () => Text(
//                   formatTime(
//                     svController.currentSeconds.value,
//                   ),
//                   style: AppConstant.getRoboto(FontWeight.w800,
//                       AppConstant.HEADLINE_SIZE_20, Colors.black),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               )
//             ],
//           )
//         ],
//       ),
//     ));
//   }
// }
import 'dart:async';
import 'dart:io';

// import 'package:testingevergreen/Utills/universal.dart';
import '../../../Utills3/utills.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:testingevergreen/pages/SE/se_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import '../../Utills3/universal.dart';

class SEAttendance extends StatefulWidget {
  String? siteID;

  SEAttendance({required String siteid}) {
    this.siteID = siteid;
  }

  @override
  State<SEAttendance> createState() => _SEAttendanceState(siteID!);
}

class _SEAttendanceState extends State<SEAttendance> {
  String? siteID;

  _SEAttendanceState(String sid) {
    this.siteID = sid;
  }

  SEController svController = Get.find();

  DashboardController dashboardController = Get.find();
  final util = Utills();
  ImagePicker picker = ImagePicker();

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
int imageI =0;
  choose_image(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileSize = await file.length();

      // Check if the file size is more than 1 MB (1 MB = 1,048,576 bytes)
      if (fileSize > 3145728) {
        // You can show a message to the user or handle it accordingly
        debugPrint(
            "The selected image is larger than 3 MB. Please select a smaller image.");
        util.showSnackBar(
            "ALert", "The selected image is larger than 1 MB", false);
        return;
      }
      final compressedFile = await _compressImage(file);
      setState(() async {
        svController.image = compressedFile;
        if(imageI ==0){
          svController.fimage1.value = compressedFile;
        }else{
          svController.fimage2.value = compressedFile;
        }
        // svController.fimage1.value = compressedFile;
        // await _dashboardController.uploadImage(
        //     reg_controller.fimage1!, "${_dashboardController.uid.value}");
      });
    }
  }

  Dialog selectImage(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 200.0,
          width: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Select',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Please select image from:',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          if (dashboardController.uid.value.isNotEmpty) {
                            choose_image(ImageSource.camera);
                          } else {
                            util.showSnackBar(
                                "Alert", "Couldn't fetch uid!", false);
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text("CAMERA"),
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();

                          if (dashboardController.uid.isNotEmpty) {
                            choose_image(ImageSource.gallery);
                          } else {
                            util.showSnackBar(
                                "Alert", "Couldn't fetch data!", false);
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text("GALLERY"),
                        color: Colors.green,
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    svController.startTimer();
    AppConstant.getUserData("user_data").then((value) => {
      if (value!.user_token.isNotEmpty)
        {svController.userToken.value = value!.user_token}
      else
        {}
    });
    dashboardController.getCurrentLocation().then((value) => {
      if (value == LocationStatus.available)
        {
          svController
              .fetchDateTime()
              .then((value) => {if (value != null) {}})
        }
    });
  }

  @override
  void dispose() {
    svController.cancelTimer();
    svController.fimage1.value = null;
    svController.fimage1.value = null;
    super.dispose();
  }

  @override
  //   @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          backToolbar(name: "Attendance "),
          Obx(() => dashboardController.process == loadingNJ.finished
              ? Expanded(
                  child: ListView.builder(
                  itemBuilder: (c, i) {
                    return Card(
                      elevation: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: AppConstant.shadow_bottom()),
                        child: Container(
                          height: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: Text(
                                      i == 0 ? "In Time" : "Out Time",
                                      style: AppConstant.getRoboto(
                                          FontWeight.w700, 18, Color(0xff494F4D)),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            imageI = i;
                                           return selectImage(context);
                                          });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.green),
                                      ),
                                      child: ClipOval(
                                        child: Obx(() =>
                                            (svController.fimage1.value == null && i==0) || (svController.fimage2.value == null && i==1)
                                                ? Image.asset(
                                                    "assets/images/selfie_logo.png",
                                                    scale: 2,
                                                  )
                                                : Image.file(
                                              i == 0 ? svController.fimage1.value! :svController.fimage2.value!,
                                                    filterQuality:
                                                        FilterQuality.low,
                                                    fit: BoxFit.cover,
                                                    scale: 1,
                                                    alignment: Alignment.center,
                                                    cacheWidth: 50,
                                                    cacheHeight: 50,
                                                  )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Take Selfie",
                                    style: AppConstant.getRoboto(
                                        FontWeight.w700,
                                        AppConstant.HEADLINE_SIZE_12,
                                        Color(0xff53C17F)),
                                  )
                                ],
                              ),
                              Obx(
                                () => Text(
                                  "${svController.current_time.value}",
                                  style: AppConstant.getRoboto(
                                      FontWeight.w800,
                                      AppConstant.HEADLINE_SIZE_25,
                                      Color(0xff4FB578)),
                                ),
                              ),
                              BounceableButton(
                                onTap: () {
                                  // var res=svController.calculateDistance(22.7492967, 75.9146905, 22.6588533, 75.8042773).then((value) => {
                                  // util.showSnackBar("Alert", value.toStringAsFixed(2), true)
                                  // });
                                  if (svController.currentSeconds == 0) {
                                    util.showSnackBar(
                                        "Alert",
                                        "you can not fill attendance reload page.",
                                        false);
                                    return null;
                                  }
                                  if (i == 0) {
                                    if (dashboardController
                                        .user_token.value.isNotEmpty) {
                                      if (dashboardController
                                              .lattitude.value.isNotEmpty &&
                                          dashboardController
                                              .longitude.value.isNotEmpty) {
                                        if (widget.siteID!.isNotEmpty) {
                                          if (dashboardController
                                              .user_role.value.isNotEmpty) {
                                            svController
                                                .seAttendance(
                                              i,
                                                    dashboardController
                                                        .user_token.value,
                                                    "in",
                                                    dashboardController
                                                        .lattitude.value,
                                                    dashboardController
                                                        .longitude.value,
                                                    widget.siteID!,
                                                    dashboardController
                                                        .user_role.value)
                                                .then((value) => {
                                                      if (value != null)
                                                        {
                                                          if (i == 0)
                                                            {
                                                              util.showSnackBar(
                                                                  "Alert",
                                                                  "IN Attendance has recorded",
                                                                  true)
                                                            }
                                                        }
                                                      else
                                                        {
                                                          // util.showSnackBar(
                                                          //     "Alert",
                                                          //     "failed",
                                                          //     false)
                                                        }
                                                    });
                                          } else {
                                            util.showSnackBar("Alert",
                                                "No user type found!", false);
                                          }
                                        } else {
                                          util.showSnackBar("Alert",
                                              "No site id found!", false);
                                        }
                                      } else {
                                        util.showSnackBar(
                                            "Alert", "No Lat/Long found!", false);
                                      }
                                    } else {
                                      util.showSnackBar(
                                          "Alert", "No user token found!", false);
                                    }
                                  } else {
                                    if (dashboardController
                                        .user_token.value.isNotEmpty) {
                                      if (dashboardController
                                              .lattitude.value.isNotEmpty &&
                                          dashboardController
                                              .longitude.value.isNotEmpty) {
                                        if (widget.siteID!.isNotEmpty) {
                                          if (dashboardController
                                              .user_role.value.isNotEmpty) {
                                            svController
                                                .seAttendance(i,
                                                    dashboardController
                                                        .user_token.value,
                                                    "out",
                                                    dashboardController
                                                    .lattitude.value,
                                                    dashboardController
                                                        .longitude.value,
                                                    widget.siteID!,
                                                    dashboardController
                                                        .user_role.value)
                                                .then((value) => {
                                                      if (value != null)
                                                        {
                                                          util.showSnackBar(
                                                              "Alert",
                                                              "OUT Attendance has recorded",
                                                              true)
                                                        }
                                                      else
                                                        {
                                                          // util.showSnackBar(
                                                          //     "Alert",
                                                          //     "failed",
                                                          //     false)
                                                        }
                                                    });
                                          } else {
                                            util.showSnackBar('Alert',
                                                "No user type found!", false);
                                          }
                                        } else {
                                          util.showSnackBar("Alert",
                                              "No site id found!", false);
                                        }
                                      } else {
                                        util.showSnackBar(
                                            "Alert", "No Lat/Long found!", false);
                                      }
                                    } else {
                                      util.showSnackBar(
                                          "Alert", "No user token found!", false);
                                    }
                                  }
                                },
                                text: 'Done',
                                width: 95,
                                height: 48,
                                gradient: AppConstant.BUTTON_COLOR,
                                borderRadius: 20,
                                fontSize: AppConstant.HEADLINE_SIZE_20,
                                fontWeight: FontWeight.w700,
                                textColor: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 2,
                ))
              : Expanded(
                  child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitFadingFour(
                        color: Colors.blue,
                        size: 50.0,
                      ),
                      SizedBox(height: 20),
                      Text('Fetching...')
                    ],
                  ),
                ))),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Time left to fill attendance",
                  style: AppConstant.getRoboto(FontWeight.w800,
                      AppConstant.HEADLINE_SIZE_20, Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => Text(
                  formatTime(
                    svController.currentSeconds.value,
                  ),
                  style: AppConstant.getRoboto(FontWeight.w800,
                      AppConstant.HEADLINE_SIZE_20, Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          )
        ],
      ),
    ));
  }



// Function to handle attendance submission
  void handleAttendance(int index) {
    final attendanceType = index == 0 ? "in" : "out";
    final locationAvailable =
        dashboardController.lattitude.value.isNotEmpty &&
            dashboardController.longitude.value.isNotEmpty;

    if (svController.currentSeconds == 0) {
      util.showSnackBar(
        "Alert",
        "You cannot fill attendance. Reload the page.",
        false,
      );
      return;
    }

    if (dashboardController.user_token.value.isEmpty) {
      util.showSnackBar("Alert", "No user token found!", false);
      return;
    }

    if (!locationAvailable) {
      util.showSnackBar("Alert", "No Lat/Long found!", false);
      return;
    }

    if (widget.siteID!.isEmpty) {
      util.showSnackBar("Alert", "No site ID found!", false);
      return;
    }

    if (dashboardController.user_role.value.isEmpty) {
      util.showSnackBar("Alert", "No user type found!", false);
      return;
    }

    svController
        .seAttendance(index,
      dashboardController.user_token.value,
      attendanceType,
      dashboardController.lattitude.value,
      dashboardController.longitude.value,
      widget.siteID!,
      dashboardController.user_role.value,
    )
        .then((value) {
      if (value != null) {
        util.showSnackBar(
          "Alert",
          "${attendanceType.toUpperCase()} Attendance has been recorded.",
          true,
        );
      } else {
        util.showSnackBar("Alert", "Failed to record attendance.", false);
      }
    });
  }

}