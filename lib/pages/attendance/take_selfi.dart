import 'dart:io';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:get/get.dart';
// import 'package:testingevergreen/Utills/universal.dart';
import '../../../Utills3/utills.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../Utills3/universal.dart';


class Take_Selfie extends StatefulWidget {
  const Take_Selfie({Key? key}) : super(key: key);

  @override
  State<Take_Selfie> createState() => _Take_SelfieState();
}

File? _image;
File? fimage1;

class _Take_SelfieState extends State<Take_Selfie> {
  final util = Utills();
  File? _image;
  File? fimage1;
  String? token;
  ImagePicker picker = ImagePicker();

  XFile? _video;
  DashboardController dashboardController = Get.find();



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

  choose_image(
    ImageSource source,
  ) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      if (pickedFile != null) {
        // Get the file and its size
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
        ;
        final compressedFile = await _compressImage(file);
        setState(() {
          fimage1 = compressedFile;
        });
      }
    }
  }

  Future<XFile?> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = path.join(dir.absolute.path, "temp.jpg");

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50, // Adjust quality as needed
    );

    return result!;
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

                          choose_image(
                            ImageSource.camera,
                          );

                          util.showSnackBar(
                              "Alert", "Couldn't fetch user id", false);
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
                          Get.back();

                          choose_image(ImageSource.gallery);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        backToolbar(name: "Selfie Team Member"),
        Stack(
          children: [
            Visibility(
              visible: true,
              child: Container(
                height: 200,
                child: fimage1 != null
                    ? Image.file(
                        fimage1!,
                        scale: 1,
                        alignment: Alignment.center,
                      )
                    : Image.asset("assets/images/selfy_pic.png"),
              ),
            ),
            Visibility(
              visible: true,
              child: Container(
                height: 200,
                child: fimage1 != null
                    ? Image.file(
                        fimage1!,
                        scale: 1,
                        alignment: Alignment.center,
                      )
                    : Image.asset("assets/images/selfy_pic.png"),
              ),
            ),
            Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.cancel_presentation_rounded),
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      fimage1 = null;
                    });
                  },
                ))
          ],
        ),
        Container(
            margin: EdgeInsets.all(10),
            child: Center(
                child: Text(
                    "Take a selfie with your team member",
                    style: AppConstant.getRoboto(
                      FontWeight.w800,
                      AppConstant.HEADLINE_SIZE_20,
                      Color(0xff33272A),
                    ),
                    textAlign: TextAlign.center))),
        Padding(
          padding: EdgeInsets.only(
              left: AppConstant.LARGE_SIZE,
              right: AppConstant.LARGE_SIZE,
              bottom: 25),
          child: BounceableButton(
              onTap: () {
                choose_image(ImageSource.camera);
              },
              text: "Take Selfie",
              width: 111,
              height: 42,
              gradient: AppConstant.BUTTON_COLOR,
              borderRadius: 20,
              fontSize: AppConstant.HEADLINE_SIZE_15,
              fontWeight: FontWeight.w800,
              textColor: Colors.white),
        ),
        Visibility(
            visible: false,
            child: Text(
              "OR",
              style: AppConstant.getRoboto(FontWeight.w800,
                  AppConstant.HEADLINE_SIZE_20, Color(0xff33272A)),
            )),
        Visibility(
          visible: false,
          child: Padding(
            padding: EdgeInsets.only(
                left: AppConstant.LARGE_SIZE,
                right: AppConstant.LARGE_SIZE,
                bottom: 25),
            child: BounceableButton(
                onTap: () {

                },
                text: "Gallery Video",
                width: 163,
                height: 42,
                gradient: AppConstant.BUTTON_COLOR,
                borderRadius: 20,
                fontSize: AppConstant.HEADLINE_SIZE_15,
                fontWeight: FontWeight.w800,
                textColor: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: AppConstant.LARGE_SIZE,
              right: AppConstant.LARGE_SIZE,
              bottom: 25),
          child: BounceableButton(
              onTap: () async {
                if (fimage1 != null) {
                  if (dashboardController.user_token.value.isEmpty) {
                    util.showSnackBar("Alert", "No token found!", false);
                  } else if (dashboardController.currentSiteID!.value.isEmpty) {
                    util.showSnackBar("Alert", "No site id found!", false);
                  } else {
                    util.startLoading();
                    await dashboardController
                        .uploadSelfi(dashboardController.user_token.value,
                            dashboardController.currentSiteID!.value, fimage1!)
                        .then((value) => {
                              if (value == null)
                                {
                                  debugPrint("uploadSelfi:post value null"),
                                  util.stopLoading(),
                                }
                              else
                                {
                                  if (value!.status == true)
                                    {
                                      debugPrint("uploadSelfi:post value true"),

                                      util.stopLoading(),
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        util.showSnackBar("Alert", "Uploded!",
                                            true); // or your code that uses visitChildElements
                                      }),
                                      //util.showSnackBar("Alert", value.message, true),
                                      Get.back(),
                                    }
                                  else
                                    {
                                      debugPrint(
                                          "uploadSelfi:post value false"),
                                      util.stopLoading()
                                    }
                                }
                            });
                  }
                } else {
                  util.showSnackBar("Alert", "Please add image first.", false);
                }
              },
              text: "Submit",
              width: 373,
              height: 53,
              gradient: AppConstant.BUTTON_COLOR,
              borderRadius: 20,
              fontSize: AppConstant.HEADLINE_SIZE_20,
              fontWeight: FontWeight.w800,
              textColor: Colors.white),
        ),
      ],
    ));
  }
}
