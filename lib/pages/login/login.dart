import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../../Utills/utills.dart';
import '../../Utills3/utills.dart';
import '../../appconstants/appconstants.dart';
import '../../appconstants/mycolor.dart';
import '../dashboard/dahboard_controller.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import '../forgot_password/forgot_password.dart';
import '../myhomepage/myhomepage.dart';
import '../signup/signup.dart';
import '../user_model.dart';
import 'login_controller.dart';

class Login extends StatefulWidget {
  String? from;

  Login({Key? key, this.from}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var notVerified = true;
  var util = Utills();
  var loginData = [];
  var user_data = [];
  var isPhoneClicked = false;
  var isPasswordClicked = false;
  var userMobile = "";
  var userPassword = "";
  var isVisible = false;
  var changeCPassVisibility = false;
  DashboardController _dashboardController = Get.find();
  LoginController login_Controller = Get.find();

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

  Future<String?> getUserdata(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  @override
  void initState() {
    super.initState();
    getUserdata("fcm").then((value) {
      if (value!.isNotEmpty) {
        login_Controller.currentFCM.value = "${value}";
        login_Controller.currentFCM.refresh();
        debugPrint("fcmget:${value}");
      }
    });

    Future.delayed(Duration(milliseconds: 500), () {
      if (widget.from == "signup"|| widget.from =="forgotpassword") {
        AppConstant.showCustomDialog( widget.from =="forgotpassword"?"Password Changed Successfully \n Please login with new password":"Please login", context);
      }
    });

    if (login_Controller.isRemember == true) {
      if (AppConstant.take_data("mobile").isNotEmpty &&
          AppConstant.take_data("password").isNotEmpty) {
        login_Controller.log_email.text = "${AppConstant.take_data("mobile")}";
        login_Controller.log_password.text =
            "${AppConstant.take_data("password")}";
      }
    }
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
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                child: Obx(() {
                  if (login_Controller.isLoading.value == true)
                    return const Center(child: CircularProgressIndicator());
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Bounceable(
                        onTap: () {
                          //  _dashboardController.isLogindashboard.value=false;
                          Get.offAll(MyHomePage(0));
                        },
                        child: Visibility(
                          visible: false,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "Skip",
                                      style: TextStyle(
                                          color: Colors.green,
                                          textBaseline:
                                              TextBaseline.ideographic))
                                ]))),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                    onTap: () {
                                      //    Get.to(MyHomePage());
                                    },
                                    child: Image.asset(
                                      'assets/images/logo_small1.png',
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.00, top: 1.00),
                        child: InkWell(
                          onTap: () {},
                          child: Text(AppConstant.LOGIN_HEAD,
                              style: GoogleFonts.roboto(
                                  textStyle:
                                      Theme.of(context).textTheme.displayLarge,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.normal,
                                  color: MyColor.LOGIN_TEXT_LOGIN_GREEN)),
                        ),
                      ),
                      //mobile
                      Container(
                        padding: EdgeInsets.all(AppConstant.LARGE_SIZE),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                AppConstant.APP_NORMAL_PADDING,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppConstant.APP_NORMAL_PADDING),
                                    border: Border.all(
                                        color: MyColor.EDITTEXT_OUTLINE_COLOR,
                                        width: 1.0)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
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
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0),
                                            child:
                                            TextFormField(
                                              controller:
                                                  login_Controller.log_email,
                                              inputFormatters: [
                                                new LengthLimitingTextInputFormatter(
                                                    10),
                                                FilteringTextInputFormatter.allow(RegExp(r"^[0-9]+$"))
                                              ],
                                              textAlign: TextAlign.center,
                                              decoration:
                                                  InputDecoration.collapsed(
                                                      hintText: AppConstant
                                                          .HINT_TEXT_MOBILE,
                                                      hintStyle: TextStyle(
                                                          fontSize: 16.0,
                                                          color: Color.fromRGBO(
                                                              160,
                                                              160,
                                                              160,
                                                              0.60),
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      //
                                                      // border: OutlineInputBorder(
                                                      // borderSide: BorderSide(
                                                      // color: Colors.teal,
                                                      // )),
                                                      floatingLabelAlignment:
                                                          FloatingLabelAlignment
                                                              .start),
                                              keyboardType:
                                                  TextInputType.number,
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
                                          ),
                                        )),
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          isPhoneClicked == true ? true : false,
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
                              height: 10,
                            ),
                            //password
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
                                        color: MyColor.EDITTEXT_OUTLINE_COLOR,
                                        width: 1.0)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Container(
                                    //     height: 45,
                                    //     child: Center(
                                    //         child: Padding(
                                    //       padding: const EdgeInsets.only(
                                    //           right: 20.0),
                                    //       child: TextFormField(
                                    //         textAlign: TextAlign.center,
                                    //         // Align horizontally
                                    //         // Align vertically
                                    //
                                    //         onTap: () {
                                    //           setState(() {
                                    //             isPasswordClicked = true;
                                    //             isPhoneClicked = false;
                                    //           });
                                    //         },
                                    //
                                    //         controller:
                                    //             login_Controller.log_password,
                                    //         decoration: InputDecoration(
                                    //             hintStyle: TextStyle(
                                    //                 fontSize: 16.0,
                                    //                 color: Color.fromRGBO(
                                    //                     160, 160, 160, 0.60),
                                    //                 fontWeight:
                                    //                     FontWeight.w400),
                                    //             border: InputBorder.none,
                                    //             hintText: AppConstant
                                    //                 .HINT_TEXT_PASSWORD,
                                    //             prefixIcon: InkWell(
                                    //                 onTap: () {
                                    //                   setState(() {
                                    //                     isPasswordClicked =
                                    //                         true;
                                    //                     isPhoneClicked = false;
                                    //                     changeCPassVisibility =
                                    //                         !changeCPassVisibility;
                                    //                   });
                                    //                 },
                                    //                 child:  Icon(  Icons.remove_red_eye)),
                                    //             prefixIconConstraints:
                                    //                 BoxConstraints.loose(
                                    //                     Size.fromWidth(10))),
                                    //         keyboardType:
                                    //             TextInputType.visiblePassword,
                                    //         obscureText: changeCPassVisibility,
                                    //       ),
                                    //     )),
                                    //   ),
                                    // ),
                                    // Visibility(
                                    //   visible: isPasswordClicked == true
                                    //       ? true
                                    //       : false,
                                    //   child: SizedBox(
                                    //     width: double.infinity,
                                    //     height: 2,
                                    //     child: Container(
                                    //       color: const Color(0xFF54E28D),
                                    //     ),
                                    //   ),
                                    // )
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 45,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 20.0),
                                            child: TextFormField(
                                              textAlign: TextAlign.center, // Align horizontally
                                              onTap: () {
                                                setState(() {
                                                  isPasswordClicked = true;
                                                  isPhoneClicked = false;
                                                });
                                              },
                                              controller: login_Controller.log_password,
                                              decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color.fromRGBO(160, 160, 160, 0.60),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                border: InputBorder.none,
                                                hintText: AppConstant.HINT_TEXT_PASSWORD,
                                                prefixIcon: Container(
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        changeCPassVisibility = !changeCPassVisibility;
                                                      });
                                                    },
                                                    child: Icon(
                                                      changeCPassVisibility
                                                          ? Icons.visibility_off
                                                          : Icons.remove_red_eye,color: changeCPassVisibility ? Color(0xFF54E28D) : Color(0xFF54E28D),
                                                    ),
                                                  ),
                                                ),
                                                prefixIconConstraints: BoxConstraints.loose(
                                                  Size.fromWidth(120),
                                                ),
                                              ),
                                              keyboardType: TextInputType.visiblePassword,
                                              obscureText: changeCPassVisibility,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isPasswordClicked,
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 2,
                                        child: Container(
                                          color: const Color(0xFF54E28D),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Row(
                                  children: [
                                    Visibility(
                                      visible: true,
                                      child: Checkbox(
                                          value:
                                              login_Controller.isRemember.value,
                                          onChanged: (value) {
                                            setState(() {
                                              login_Controller
                                                  .isRemember.value = value!!;
                                            });
                                          }),
                                    ),
                                    Visibility(
                                      visible: true,
                                      child: Text(AppConstant.REM_ME,
                                          style: GoogleFonts.nunitoSans(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge,
                                              fontSize: AppConstant.SMALL_SIZE,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              color: const Color(0xFF8E8E8E))),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Align(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          child: Bounceable(
                                            onTap: () {
                                              Get.to(ForgotPassword());
                                            },
                                            child: Text(AppConstant.FORGOT_PW,
                                                style: GoogleFonts.nunito(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .displayLarge,
                                                    fontSize: AppConstant
                                                        .EXTRA_MEDIUM_SIZE_16,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    color: MyColor
                                                        .FORGOTPW_TEXT_GREEN)),
                                          )),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //login
                      Padding(
                        padding: EdgeInsets.only(
                            left: AppConstant.LARGE_SIZE,
                            right: AppConstant.LARGE_SIZE,
                            bottom: 25),
                        child: Bounceable(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (EasyLoading.isShow == true) {
                              return;
                            }
                            var result = login_Controller.login();

                            if (result != null) {
                              result.then((value) => {
                                    if (login_Controller.isRemember.value ==
                                        true)
                                      {
                                        AppConstant.save_data("mobile",
                                            value!.userdata.mobile.toString()),
                                        AppConstant.save_data(
                                            "password",
                                            login_Controller.log_password.text
                                                .toString()),
                                      },
                                    login_Controller.log_email.text = "",
                                    login_Controller.log_password.text = "",
                                    // login_Controller.saveFirebasetoken(
                                    //     value!.token.toString(),
                                    //     AppConstant.take_data("fcm")),

                                    util.showSnackBar(
                                        "Alertlogin",
                                        "hello" + value!.userdata!.fullName,
                                        true),
                                    AppConstant.save_data(
                                        "token", value!.token.toString()),
                                    saveUserData("user_data", [
                                      value!.userdata.id.toString(),
                                      value!.token.toString(),
                                      value!.userdata.fullName.toString(),
                                      value!.userdata.mobile.toString(),
                                      value!.userdata.pic.toString(),
                                      value!.userdata.role.toString(),
                                      value!.userdata.deviceId.toString(),
                                      value!.userdata.role.toString()
                                    ]),

                                    Get.offAll(MyHomePage(0, true)),
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
                              child: Text(AppConstant.LOGIN_HEAD_SMALL,
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
                      Bounceable(
                          onTap: () {
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Signup()));
                            Get.to(Signup());
                          },
                          child: Container(
                              child: Center(
                                  child: AppConstant.signup_text(context))))
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
