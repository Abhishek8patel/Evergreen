import 'package:testingevergreen/pages/login/login.dart';
import 'package:testingevergreen/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../../Utills/utills.dart';
import '../../Utills3/utills.dart';
import '../../appconstants/appconstants.dart';
import '../../appconstants/mycolor.dart';


import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forgot_pw_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var notVerified = true;
  var util = Utills();
  var loginData = [];
  var user_data = [];
  var isPhoneClicked = false;
  var isPasswordClicked = false;
  var userMobile = "+911234567890";
  var userPassword = "";
  var isVisible = false;

  var isOTPPage = false;

  LoginController login_Controller = Get.find();
  ForgotPasswordController forgotPasswordController = Get.find();

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
            child: Container(
              child: Obx(() {
                if (login_Controller.isLoading.value == true)
                  return const Center(child: CircularProgressIndicator());
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Bounceable(
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(shape: BoxShape.circle),
                                  child: Image.asset(
                                    "assets/images/back_btn.png", ),
                                ),
                              ),
                            ),
                            SizedBox(width: MediaQuery
                                .of(context)
                                .size
                                .width / 4,),
                            Container(),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 264,
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
                                    'assets/images/evergreen_logo.png',
                                    height: 264,
                                    width: 264,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppConstant.APP_NORMAL_PADDING,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.00, top: 1.00),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Text("Forgot Password",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.abrilFatface(
                                  textStyle:
                                  Theme
                                      .of(context)
                                      .textTheme
                                      .displayLarge,
                                  fontSize: AppConstant.HEADLINE_SIZE_20,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  color: MyColor.LOGIN_TEXT_GREEN)),
                        ),
                      ),
                    ),

                    //mobile
                    Container(
                      padding: EdgeInsets.all(AppConstant.LARGE_SIZE),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          SizedBox(
                            height: AppConstant.LARGE_SIZE,
                          ),

                          //enter new confirm password
                          Visibility(
                            visible: !isOTPPage,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: AppConstant.APP_NORMAL_PADDING,
                                  right: AppConstant.APP_NORMAL_PADDING,
                                  top: AppConstant.APP_NORMAL_PADDING
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppConstant.APP_NORMAL_PADDING),
                                    border: Border.all(
                                        color: MyColor.LOGIN_TEXT_OUTLINE,
                                        width: 1.0)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                              ],


                                              textAlign: TextAlign.center,
                                              onTap: () {
                                                setState(() {
                                                  isPasswordClicked = true;
                                                  isPhoneClicked = false;
                                                });
                                              },
                                              controller:
                                              forgotPasswordController.mobile,
                                              decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Color.fromRGBO(
                                                        160, 160, 160, 0.60),
                                                    fontWeight: FontWeight
                                                        .w400),
                                                border: InputBorder.none,
                                                hintText:
                                                AppConstant
                                                    .TEXT_ENTER_MOBILE_NUMBER,

                                              ),
                                              keyboardType:
                                              TextInputType.number,
                                              obscureText: isVisible
                                                  ? true
                                                  : false,
                                            )),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isPasswordClicked == true
                                          ? true
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



                            forgotPasswordController.forgotPassword().then((value) => {

                            });

                          // if (EasyLoading.isShow == true) {
                          //   return;
                          // }
                          // var result = forgotPasswordController
                          //     .forgotPassword();
                          //
                          // if (result != null) {
                          //   result.then((value) =>
                          //   {
                          //
                          //
                          //     //Get.offAll(MyHomePage())
                          //   });
                          // }
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
                            child: Text(AppConstant.FORGOT_BUTTON_TEXT,
                                style: GoogleFonts.roboto(
                                    textStyle: Theme
                                        .of(context)
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

                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}