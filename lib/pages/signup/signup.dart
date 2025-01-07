import 'dart:io';

import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:testingevergreen/pages/login/login.dart';
import 'package:testingevergreen/pages/login/login_controller.dart';
import 'package:testingevergreen/pages/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';

// import '../../Utills/universal.dart';
// import '../../Utills/utills.dart';
import '../../Utills3/universal.dart';
import '../../Utills3/utills.dart';
import '../../appconstants/appconstants.dart';
import '../../appconstants/mycolor.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../otp/otp.dart';
import '../profile/profile_controller.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var notVerified = true;
  var util = Utills();
  var loginData = [];
  var user_data = [];
  var isPhoneClicked = false;
  var isPasswordClicked = false;
  var userMobile = "";
  var userPassword = "";
  var isVisible = false;
  var changePassVisibility = false;
  var changeCPassVisibility = false;

  DateTime selectedDate = DateTime.now();
  var _selected_date = "";
  var _selected_month = "";
  var _selected_year = "";
  ImagePicker picker = ImagePicker();

  DashboardController _dashboardController = Get.find();

  // CalendarController calendarController =Get.find();

  SignupController reg_controller = Get.find();
  LoginController login_Controller = Get.find();
  ProfileController profile_controller = Get.find();

  @override
  void initState() {
    super.initState();
    AppConstant.getUserData("user_data").then((value) => {
          if (value != null)
            {
              if (value!.user_id.isNotEmpty)
                {_dashboardController.uid.value = value!.user_id!}
              else
                {util.showSnackBar("Alert", "Couldn't find userid!", false)}
            }
        });
  }

  @override
  void dispose() {
    super.dispose();
    // reg_controller.fimage1.value = null;
  }

  void saveUserData(key, value) async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      sp.setStringList(key, value);
      if (key == "user_data") {
        print("loginitlogin${"datasaved"}");
      } else if (key == "temp") {
        print("loginit${"datasavedtemp"}");
      }
      ;
    });
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

  choose_image(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 50);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileSize = await file.length();

      // Check if the file size is more than 1 MB (1 MB = 1,048,576 bytes)
      if (fileSize > 104857) {
        // You can show a message to the user or handle it accordingly
        debugPrint(" Please select a smaller image.");
        util.showSnackBar("ALert", "The selected image is larger.", false);
        return;
      }
      final compressedFile = await _compressImage(file);

      //reg_controller.image = File(pickedFile.path);
      reg_controller.fimage1.value = compressedFile;
      reg_controller.refresh();

      // util.showSnackBar("Alert", reg_controller.fimage1.value!.path, true);
      // await _dashboardController.uploadImage(
      //     reg_controller.fimage1!, "${_dashboardController.uid.value}");
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
                          util.showSnackBar("Alert", "clicked", false);
                          if (_dashboardController.uid.value.isNotEmpty) {
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

                          if (_dashboardController.uid.isNotEmpty) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            isPhoneClicked = false;
            isPasswordClicked = false;
          });
        },
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Column(
            children: [
              backToolbar(
                name: "Signup",
                toHomePage: false,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Obx(() {
                      if (login_Controller.isLoading.value == true)
                        return const Center(child: CircularProgressIndicator());
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: AppConstant.APP_NORMAL_PADDING,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(10),
                          //   child: InkWell(
                          //     onTap: () {},
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       children: [
                          //         Bounceable(
                          //
                          //           onTap: () {
                          //
                          //             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                          //           },
                          //           child: Padding(
                          //             padding: const EdgeInsets.only(left:20.0),
                          //             child: Image.asset("assets/images/back_btn.png",scale: 1,),
                          //           ),
                          //         ),
                          //         SizedBox(width: MediaQuery.of(context).size.width/4,),
                          //
                          //
                          //         Center(child: Text(AppConstant.SIGNUP_NAME,
                          //             style: GoogleFonts.abrilFatface(
                          //                 textStyle:
                          //                 Theme.of(context).textTheme.displayLarge,
                          //                 fontSize: AppConstant.HEADLINE_SIZE_20,
                          //                 fontWeight: FontWeight.w400,
                          //                 fontStyle: FontStyle.normal,
                          //                 color: MyColor.LOGIN_TEXT_GREEN)),),
                          //         Container(),
                          //
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          Stack(children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(3),
                                // Adjust padding to control border thickness
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 3.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 60,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Hero(
                                      tag: "imageView",
                                      child: ClipOval(
                                        child: Obx(() {
                                          if (reg_controller.fimage1.value !=
                                              null) {
                                            return Image.file(
                                              reg_controller.fimage1.value!,
                                              width: 120,
                                              height: 120,
                                              scale: 1,
                                              alignment: Alignment.center,
                                              cacheWidth: 120,
                                              cacheHeight: 120,
                                            );
                                          } else {
                                            return Image.asset(
                                              "assets/images/profile.png",
                                              width: 162,
                                              height: 162,
                                              scale: 1,
                                              alignment: Alignment.center,
                                              cacheWidth: 162,
                                              cacheHeight: 162,
                                            );
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 1,
                              right: 10,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              selectImage(context));
                                    },
                                    child: Icon(
                                      Icons.photo_camera_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(60),
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(2, 4),
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),

                          Container(
                            padding: EdgeInsets.all(AppConstant.LARGE_SIZE),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: AppConstant.APP_NORMAL_PADDING,
                                    right: AppConstant.APP_NORMAL_PADDING,
                                    top: AppConstant.APP_NORMAL_PADDING,
                                    bottom: AppConstant.LARGE_SIZE_22,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppConstant.APP_NORMAL_PADDING),
                                        border: Border.all(
                                            color: MyColor.LOGIN_TEXT_OUTLINE,
                                            width: 1.0)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        //firstname
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 45.00,
                                            child: Center(
                                                child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isPhoneClicked == true;
                                                });
                                              },
                                              behavior: HitTestBehavior.opaque,
                                              child: TextFormField(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                                                ],
                                                controller:
                                                    reg_controller.fname,
                                                textAlign: TextAlign.center,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                        hintText: AppConstant
                                                            .HINT_TEXT_FULL_NAME,
                                                        hintStyle: TextStyle(
                                                            fontSize: 16.0,
                                                            color:
                                                                Color.fromRGBO(
                                                                    160,
                                                                    160,
                                                                    160,
                                                                    0.60),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        //
                                                        // border: OutlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        // color: Colors.teal,
                                                        // )),
                                                        floatingLabelAlignment:
                                                            FloatingLabelAlignment
                                                                .start),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                autovalidateMode:
                                                    AutovalidateMode.disabled,
                                                onTap: () {
                                                  setState(() {
                                                    isPhoneClicked = true;
                                                    isPasswordClicked = false;
                                                  });
                                                },
                                                onChanged: (phone) {},
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                              ),
                                            )),
                                          ),
                                        ),
                                        Visibility(
                                          visible: isPhoneClicked == true
                                              ? false
                                              : false,
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 2,
                                            child: Container(
                                              color: const Color(0xFF54E28D),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                //Mobile
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: AppConstant.APP_NORMAL_PADDING,
                                    right: AppConstant.APP_NORMAL_PADDING,
                                    top: AppConstant.APP_NORMAL_PADDING,
                                    bottom: AppConstant.LARGE_SIZE_22,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppConstant.APP_NORMAL_PADDING),
                                        border: Border.all(
                                            color: MyColor.LOGIN_TEXT_OUTLINE,
                                            width: 1.0)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 45,
                                            child: Center(
                                                child: TextFormField(
                                              inputFormatters: [
                                                new LengthLimitingTextInputFormatter(
                                                    10),
                                                FilteringTextInputFormatter.allow(RegExp(r"^[0-9]+$"))
                                              ],
                                              textAlign: TextAlign.center,
                                              onTap: () {
                                                setState(() {
                                                  isPasswordClicked = true;
                                                  isPhoneClicked = false;
                                                });
                                              },
                                              controller: reg_controller.mobile,
                                              decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Color.fromRGBO(
                                                        160, 160, 160, 0.60),
                                                    fontWeight:
                                                        FontWeight.w400),
                                                border: InputBorder.none,
                                                hintText: AppConstant
                                                    .HINT_TEXT_MOBILE_NO,
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              obscureText:
                                                  isVisible ? true : false,
                                            )),
                                          ),
                                        ),
                                        Visibility(
                                          visible: isPasswordClicked == true
                                              ? false
                                              : false,
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 2,
                                            child: Container(
                                              color: const Color(0xFF54E28D),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                //email
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: AppConstant.APP_NORMAL_PADDING,
                                    right: AppConstant.APP_NORMAL_PADDING,
                                    top: AppConstant.APP_NORMAL_PADDING,
                                    bottom: AppConstant.LARGE_SIZE_22,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppConstant.APP_NORMAL_PADDING),
                                        border: Border.all(
                                            color: MyColor.LOGIN_TEXT_OUTLINE,
                                            width: 1.0)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 45,
                                            child: Center(
                                                child: TextFormField(
                                                  inputFormatters: [
                                                   // FilteringTextInputFormatter.deny(RegExp(r'^[a-zA-Z0-9_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'))
                                                  ],
                                              textAlign: TextAlign.center,
                                              onTap: () {
                                                setState(() {
                                                  isPasswordClicked = true;
                                                  isPhoneClicked = false;
                                                });
                                              },
                                              controller: reg_controller.email,
                                              decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Color.fromRGBO(
                                                        160, 160, 160, 0.60),
                                                    fontWeight:
                                                        FontWeight.w400),
                                                border: InputBorder.none,
                                                hintText: "Email",
                                              ),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              obscureText:
                                                  isVisible ? true : false,
                                            )),
                                          ),
                                        ),
                                        Visibility(
                                          visible: isPasswordClicked == true
                                              ? false
                                              : false,
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 2,
                                            child: Container(
                                              color: const Color(0xFF54E28D),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                //address
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: AppConstant.APP_NORMAL_PADDING,
                                    right: AppConstant.APP_NORMAL_PADDING,
                                    top: AppConstant.APP_NORMAL_PADDING,
                                    bottom: AppConstant.LARGE_SIZE_22,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppConstant.APP_NORMAL_PADDING),
                                        border: Border.all(
                                            color: MyColor.LOGIN_TEXT_OUTLINE,
                                            width: 1.0)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 45,
                                            child: Center(
                                                child: TextFormField(
                                              textAlign: TextAlign.center,
                                              onTap: () {
                                                setState(() {
                                                  isPasswordClicked = true;
                                                  isPhoneClicked = false;
                                                });
                                              },
                                              controller:
                                                  reg_controller.address,
                                              decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Color.fromRGBO(
                                                        160, 160, 160, 0.60),
                                                    fontWeight:
                                                        FontWeight.w400),
                                                border: InputBorder.none,
                                                hintText: AppConstant
                                                    .HINT_TEXT_ADDRESS,
                                              ),
                                              keyboardType: TextInputType.text,
                                              obscureText:
                                                  isVisible ? true : false,
                                            )),
                                          ),
                                        ),
                                        Visibility(
                                          visible: isPasswordClicked == true
                                              ? false
                                              : false,
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 2,
                                            child: Container(
                                              color: const Color(0xFF54E28D),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // password
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: AppConstant.APP_NORMAL_PADDING,
                                      right: AppConstant.APP_NORMAL_PADDING,
                                      top: AppConstant.APP_NORMAL_PADDING),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppConstant.APP_NORMAL_PADDING),
                                        border: Border.all(
                                            color: MyColor.LOGIN_TEXT_OUTLINE,
                                            width: 1.0)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 45,
                                            child: Center(
                                                child: TextFormField(
                                              textAlign: TextAlign.center,
                                              controller:
                                                  reg_controller.password,
                                              decoration: InputDecoration(

                                                hintStyle: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Color.fromRGBO(
                                                        160, 160, 160, 0.60),
                                                    fontWeight:
                                                        FontWeight.w400),
                                                border: InputBorder.none,
                                                hintText: AppConstant
                                                    .HINT_TEXT_PASSWORD_SIGNUP,
                                                contentPadding: const EdgeInsets.only(
                                                    right: 60.0,top: 10),
                                                prefixIcon: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        isPasswordClicked =
                                                            true;
                                                        isPhoneClicked = false;

                                                        changePassVisibility =
                                                            !changePassVisibility;
                                                      });
                                                    },
                                                    child: changePassVisibility
                                                        ? Icon(
                                                            Icons
                                                                .remove_red_eye,
                                                            color: Colors.green,
                                                          )
                                                        : Icon(Icons
                                                            .visibility_off,color: Colors.green,)),
                                              ),
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText:
                                                  changePassVisibility == true
                                                      ? false
                                                      : true,
                                            )),
                                          ),
                                        ),
                                        Visibility(
                                          visible: isPasswordClicked == true
                                              ? false
                                              : false,
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 2,
                                            child: Container(
                                              color: const Color(0xFF54E28D),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //cpassword
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: AppConstant.APP_NORMAL_PADDING,
                                      right: AppConstant.APP_NORMAL_PADDING,
                                      top: AppConstant.APP_NORMAL_PADDING),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppConstant.APP_NORMAL_PADDING),
                                        border: Border.all(
                                            color: MyColor.LOGIN_TEXT_OUTLINE,
                                            width: 1.0)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 45,
                                            child: Center(
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                controller: reg_controller
                                                    .Confirmpassword,
                                                decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Color.fromRGBO(
                                                          160, 160, 160, 0.60),
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  border: InputBorder.none,
                                                  prefixIcon: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          isPasswordClicked =
                                                              true;
                                                          isPhoneClicked =
                                                              false;
                                                          changeCPassVisibility =
                                                              !changeCPassVisibility;
                                                        });
                                                      },
                                                      child:
                                                          changeCPassVisibility
                                                              ? Icon(
                                                                  Icons
                                                                      .remove_red_eye,
                                                                  color: Colors
                                                                      .green,
                                                                )
                                                              : Icon(Icons
                                                                  .visibility_off,color: Colors.green,)),
                                                  hintText: AppConstant
                                                      .HINT_TEXT_CONFIRM_PASSWORD_SIGNUP,
                                                ),
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                obscureText:
                                                    changeCPassVisibility ==
                                                            true
                                                        ? false
                                                        : true,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: isPasswordClicked == true
                                              ? false
                                              : false,
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 2,
                                            child: Container(
                                              color: const Color(0xFF54E28D),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Visibility(
                                          visible: false,
                                          child: Checkbox(
                                              value: login_Controller
                                                  .isRemember.value,
                                              onChanged: (value) {
                                                setState(() {
                                                  login_Controller.isRemember
                                                      .value = value!!;
                                                });
                                              }),
                                        ),
                                        Visibility(
                                          visible: false,
                                          child: Text(AppConstant.REM_ME,
                                              style: GoogleFonts.nunitoSans(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge,
                                                  fontSize:
                                                      AppConstant.SMALL_SIZE,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      const Color(0xFF8E8E8E))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: AppConstant.APP_EXTRA_LARGE_PADDING,
                          ),

                          //login
                          Padding(
                            padding: EdgeInsets.only(
                                left: AppConstant.LARGE_SIZE,
                                right: AppConstant.LARGE_SIZE,
                                bottom: AppConstant.SMALL_TEXT_SIZE),
                            child: Bounceable(
                              onTap: () {
                                // if (EasyLoading.isShow == true) {
                                //   return;
                                // }
                                // var res = reg_controller.signUp().then((value) => {
                                //
                                //   if(value!.status==true){
                                //     // isLeagleAge(),
                                //   //  Get.to(Otp(false,reg_controller.mobile.text.toString(),"signup"))
                                //   }
                                //   //else{
                                //   //   isLeagleAge()
                                //   // }
                                //
                                // });

                                // Get.to(() => Otp(false, "9424894244", "signup"));

                                AppConstant.initDeviceId().then((value) => {
                                      debugPrint("callednj${value}"),
                                      if (value.isNotEmpty || value != null)
                                        {
                                          reg_controller
                                              .signUp(
                                                  value,
                                                  login_Controller
                                                      .currentFCM.value)
                                              .then((value) => {
                                                    if (value != null)
                                                      {
                                                        Get.to(() => Otp(
                                                            false,
                                                            reg_controller
                                                                .mobile.text,
                                                            "signup",
                                                            value!.otp!))
                                                      }
                                                  })
                                        }
                                    });
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
                                  child: Text("Sign Up",
                                      style: GoogleFonts.roboto(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          fontSize:
                                              AppConstant.HEADLINE_SIZE_20,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                          Bounceable(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                                //     Get.offAll(const Signup());
                              },
                              child: Container(
                                  child: Center(
                                      child: AppConstant.lgoin_text(context))))
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
