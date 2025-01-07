import 'package:testingevergreen/pages/login/login.dart';
import 'package:testingevergreen/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../../Utills/utills.dart';
import '../../Utills3/utills.dart';
import '../../appconstants/appconstants.dart';
import '../../appconstants/mycolor.dart';

import '../myhomepage/myhomepage.dart';
import '../signup/signup_controller.dart';
import 'otp_controller.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class Otp extends StatefulWidget {
  bool? isForgetpw;
  String? mobile_no;
  String? from;
  String? otp;

  Otp(bool _isForgetPW, String _mobile, String _from, String? _otp) {
    this.isForgetpw = _isForgetPW;
    this.mobile_no = _mobile;
    this.from = _from;
    this.otp = _otp;
  }

  @override
  State<Otp> createState() =>
      _OtpState(this.isForgetpw!, this.mobile_no!, this.from!);
}

class _OtpState extends State<Otp> {
  bool? isForgetpw;
  String? mobile_no;
  String? from;

  _OtpState(bool _isForgetPW, String _mobile, String _from) {
    this.isForgetpw = _isForgetPW;
    this.mobile_no = _mobile;
    this.from = _from;
  }

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
  OtpController otpController = Get.find();
  SignupController reg_controller = Get.find();

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
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (this.isForgetpw == false) {
      setState(() {
        isOTPPage = true;
        userMobile = this.mobile_no.toString();
        if (mounted) {
          if (from == "signup") {
            //showDialog(context: context, builder: (context)=>AccountCreatedDialog(context));
          }
        }
        //call otp api
      });
    } else {
      userMobile = this.mobile_no.toString();
    }
  }

  Dialog AccountCreatedDialog(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 472.0,
          width: 372.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(13),
                        topRight: Radius.circular(13)),
                  ),
                  child: Center(
                    child: Text(
                      'Success',
                      style: GoogleFonts.aladin(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: AppConstant.HEADLINE_SIZE_50,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: MyColor.LOGIN_TEXT_GREEN),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  child: Divider(
                    color: Colors.grey,
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 59,
                width: 69,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //
                    // BoxShadow
                  ],
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/right.png")),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 48.00, right: 48.00, top: 48.00),
                child: Text(
                  '${AppConstant.HINT_TEXT_SUCCESS}',
                  style: GoogleFonts.aladin(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: AppConstant.HEADLINE_SIZE_25,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: MyColor.LOGIN_TEXT_GREEN),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20.0)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.offAll(MyHomePage(0));
                        },
                        child: Container(
                          width: 110,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: MyColor.LOGIN_TEXT_GREEN, width: 0.5)),
                          child: Center(
                            child: Text("OK",
                                style: TextStyle(
                                  color: MyColor.LOGIN_TEXT_GREEN,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
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
                                Get.back();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Image.asset(
                                  "assets/images/back_btn.png",
                                  scale: 1,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                            ),
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
                          child: Text(AppConstant.OTP_HEAD,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  textStyle:
                                      Theme.of(context).textTheme.displayLarge,
                                  fontSize: AppConstant.HEADLINE_SIZE_20,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  color: MyColor.LOGIN_TEXT_GREEN)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.00, top: 1.00),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Text("$userMobile",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                  textStyle:
                                      Theme.of(context).textTheme.displayLarge,
                                  fontSize: AppConstant.HEADLINE_SIZE_20,
                                  fontWeight: FontWeight.w700,
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

                          //otp
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
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                        controller: otpController.otp,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Color.fromRGBO(
                                                  160, 160, 160, 0.60),
                                              fontWeight: FontWeight.w400),
                                          border: InputBorder.none,
                                          hintText: AppConstant.HINT_TEXT_OTP,
                                        ),
                                        keyboardType: TextInputType.number,
                                        obscureText: isVisible ? true : false,
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
                          //enter new password
                          Visibility(
                            visible: !isOTPPage,
                            child: Padding(
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                          controller: otpController.password,
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                                fontSize: 16.0,
                                                color: Color.fromRGBO(
                                                    160, 160, 160, 0.60),
                                                fontWeight: FontWeight.w400),
                                            border: InputBorder.none,
                                            hintText:
                                                AppConstant.HINT_TEXT_PASS,
                                          ),
                                          keyboardType: TextInputType.text,
                                          obscureText: isVisible ? true : false,
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
                          //enter new confirm password
                          Visibility(
                            visible: !isOTPPage,
                            child: Padding(
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                              otpController.con_password,
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                                fontSize: 16.0,
                                                color: Color.fromRGBO(
                                                    160, 160, 160, 0.60),
                                                fontWeight: FontWeight.w400),
                                            border: InputBorder.none,
                                            hintText: AppConstant
                                                .HINT_TEXT_NEW_CON_PASSWORD,
                                          ),
                                          keyboardType: TextInputType.text,
                                          obscureText: isVisible ? true : false,
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

                          Visibility(
                            visible: isOTPPage,
                            child: Align(
                              alignment: Alignment.center,
                              child: Bounceable(
                                onTap: () {
                                  otpController.resendOtp(this.userMobile);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Text(AppConstant.RESEND,
                                              style: GoogleFonts.homenaje(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge,
                                                  fontSize: AppConstant
                                                      .HEADLINE_SIZE_20,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  color: MyColor
                                                      .LOGIN_TEXT_GREEN)),
                                        ),
                                      ))
                                    ],
                                  ),
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
                    Visibility(
                      visible: widget.otp == null ? false : true,
                      child: Center(
                        child: Text(
                            "Your OTP is: ${widget.otp ?? "No otp found!!"}"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: AppConstant.LARGE_SIZE,
                          right: AppConstant.LARGE_SIZE,
                          bottom: AppConstant.SMALL_TEXT_SIZE),
                      child: Bounceable(
                        onTap: () {
                          if (this.isForgetpw == true) //from forget password
                          {
                            otpController.mobile.text =
                                this.mobile_no.toString();

                            otpController.changePassword(
                                this.mobile_no.toString(),
                                otpController.otp.text,
                                otpController.con_password.text);
                          } else if (this.isForgetpw ==
                              false) //grom registration
                          {
                            debugPrint("otpveri" + reg_controller.mobile.text);

                            debugPrint("otpveri" + otpController.otp.text);

                            otpController
                                .verifyOtp(
                                    userMobile.trim(), otpController.otp.text)
                                .then((value) => {
                                      if (value!.status == true)
                                        {
                                          saveUserData("user_data", [
                                            value!.user.id.toString(),
                                            "",
                                            value!.user.fullName.toString(),
                                            value!.user.mobile.toString(),
                                            value!.user.pic.toString(),
                                            value!.user.role.toString(),
                                            value!.user.deviceId.toString()
                                          ]),

                                          // AppConstant.save_data("userid", value!.user!.id.toString()),
                                          Get.offAll(Login(
                                            from: "signup",
                                          ))
                                        }
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
                            child: Text(AppConstant.SUBMIT_BUTTON_TEXT,
                                style: GoogleFonts.imFellEnglish(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                    fontSize: AppConstant.HEADLINE_SIZE_20,
                                    fontWeight: FontWeight.w400,
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
