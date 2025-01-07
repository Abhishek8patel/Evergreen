// import 'package:testingevergreen/Utills/universal.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:testingevergreen/pages/SV/svController/clentEmailController.dart';
import 'package:testingevergreen/pages/SV/svmodels/clientMailDto.dart';
import 'package:testingevergreen/pages/SV/svmodels/clientMailDto.dart';
import 'package:testingevergreen/pages/SV/svmodels/clientMailDto.dart';
import 'package:testingevergreen/pages/SV/svmodels/clientMailDto.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
// import '../../Utills/universal.dart';
// import '../../Utills/utills.dart';
import '../../Utills3/universal.dart';
import '../../Utills3/utills.dart';
import 'svmodels/clientMailDto.dart';

class VerificationOTP extends StatefulWidget {
  final String id;
  final String email;

  VerificationOTP({required this.id, required this.email});

  @override
  State<VerificationOTP> createState() => _VerificationOTPState();
}

class _VerificationOTPState extends State<VerificationOTP> {
  TextEditingController _otpController = TextEditingController();
  final util = Utills();
  ClientEmailController clientEmailController = Get.find();
  DashboardController dashboardController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        backToolbar(name: "Otp"),
        SizedBox(height: 150),
        Center(
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Image.asset("assets/images/otp_client.png"))),
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Please enter OTP of your client',
              style: AppConstant.getRoboto(FontWeight.w700,
                  AppConstant.HEADLINE_SIZE_20, Color(0xff25BD62)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    activeColor: Colors.blue,
                    selectedColor: Colors.blue,
                    inactiveColor: Colors.green,
                    fieldOuterPadding: EdgeInsets.symmetric(horizontal: 1),
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (value) {
                    // Handle completed OTP input
                    print("Completed: $value");
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {});
                  },
                  beforeTextPaste: (text) {
                    // Prevent pasting
                    return false;
                  },
                ),
                SizedBox(height: 20),
                AppConstant.getTapButton(
                    AppConstant.getRoboto(FontWeight.w800,
                        AppConstant.HEADLINE_SIZE_20, Colors.white),
                    "Submit",
                    121,
                    53, () {
                  if (dashboardController.user_token.value.isEmpty) {
                    util.showSnackBar('Alert', "Couldn't get token!!", false);
                  } else if (widget.id.isEmpty) {
                    util.showSnackBar('Alert', "Couldn't get id!", false);
                  } else if (_otpController.text.isEmpty) {
                    util.showSnackBar(
                        'Alert', "PLease enter otp value!", false);
                  } else {
                    clientEmailController
                        .verifyOTP(dashboardController.user_token.value,
                            widget.id, _otpController.text)
                        .then((value) => {
                              if (value!.status == true)
                                {
                                  Get.dialog(
                                      AppConstant.ThanksVerification(context))
                                }
                            });
                  }

                  //Get.dialog(AppConstant.ThanksVerification(context));
                  print("Entered OTP: ${_otpController.text}");
                  debugPrint("njdebug:${widget.email} ${widget.id}");
                  //util.showSnackBar("Alert", "${_otpController.text}", true);
                }, borderRadius: BorderRadius.circular(30))
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
