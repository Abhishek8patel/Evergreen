import 'package:testingevergreen/pages/myhomepage/myhomepage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

// import '../../Utills/universal.dart';
// import '../../Utills/utills.dart';
import '../../Utills3/universal.dart';
import '../../Utills3/utills.dart';
import '../../appconstants/appconstants.dart';
import '../../appconstants/mycolor.dart';
import '../settings/setting_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final util = Utills();
  SettingController settingController = Get.find();
  String? _errorText;

  bool? isNewPasswordVisible = true;
  bool? isConfirmPasswordVisible = true;
  bool? isOldPasswordVisible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    settingController.error_text.value = "";
  }

  _validateInput(String value) {
    // Regular expression to match the required criteria
    final RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*]).{8,}$');

    if (!regex.hasMatch(value)) {
      setState(() {
        _errorText =
            'Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be at least 8 characters long.';
      });
    } else {
      setState(() {
        _errorText = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                backToolbar(
                  name: "Change Password",
                  get_back: true,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //pw

                        Center(
                          child: Image.asset(
                            "assets/images/logo_small1.png",
                            scale: 1,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            top: AppConstant.APP_NORMAL_PADDING_34,
                            left: AppConstant.APP_NORMAL_PADDING_34,
                            right: AppConstant.APP_NORMAL_PADDING_34,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppConstant.APP_NORMAL_PADDING),
                                border: Border.all(
                                    color: MyColor.LOGIN_TEXT_OUTLINE,
                                    width: 1.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 45,
                                    child: Center(
                                        child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: settingController.password,
                                      onTap: () {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        hintStyle: AppConstant.edit_txt_hint(),
                                        border: InputBorder.none,
                                        hintText: "Confirm Password",
                                        prefixIcon: InkWell(
                                            onTap: () {
                                              setState(() {
                                                isNewPasswordVisible =
                                                    !isNewPasswordVisible!;
                                              });
                                            },
                                            child: Icon(
                                                isNewPasswordVisible == true
                                                    ? Icons.remove_red_eye
                                                    : Icons.visibility_off,
                                                color:
                                                    isNewPasswordVisible == true
                                                        ? Colors.green
                                                        : Colors.green)),
                                      ),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: isNewPasswordVisible!,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //confirm password
                        Padding(
                          padding: EdgeInsets.only(
                              left: AppConstant.APP_NORMAL_PADDING_34,
                              right: AppConstant.APP_NORMAL_PADDING_34,
                              top: AppConstant.APP_NORMAL_PADDING_26),
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
                                      controller: settingController.cpassword,
                                      onTap: () {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 16.0,
                                            color: Color.fromRGBO(
                                                160, 160, 160, 0.60),
                                            fontWeight: FontWeight.w400),
                                        border: InputBorder.none,
                                        hintText: "Confirm New Password",
                                        prefixIcon: InkWell(
                                            onTap: () {
                                              setState(() {
                                                isConfirmPasswordVisible =
                                                    !isConfirmPasswordVisible!;
                                              });
                                            },
                                            child: Icon(
                                                isConfirmPasswordVisible == true
                                                    ? Icons.remove_red_eye
                                                    : Icons.visibility_off,
                                                color:
                                                    isConfirmPasswordVisible ==
                                                            true
                                                        ? Colors.green
                                                        : Colors.green)),
                                      ),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: isConfirmPasswordVisible!,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //submit
                        Padding(
                          padding: EdgeInsets.only(
                              top: AppConstant.HEADLINE_SIZE_20,
                              left: AppConstant.LARGE_SIZE,
                              right: AppConstant.LARGE_SIZE,
                              bottom: AppConstant.SMALL_TEXT_SIZE),
                          child: Bounceable(
                            onTap: () {
                              setState(() {
                                /*

                           if (!regex
                              .hasMatch(settingController.old_password.text)) {
                            _errorText =
                            'Old Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be at least 8 characters long.';
                            debugPrint("has error");
                            util.showSnackBar("Alert", _errorText!, false);
                          }

                           */
                                debugPrint("Clicked");

                                final RegExp regex = RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*]).{8,}$');
                                if (!regex.hasMatch(
                                    settingController.password.text)) {
                                  setState(() {
                                    _errorText =
                                        'Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be at least 8 characters long.';
                                    debugPrint("has error");
                                    util.showSnackBar(
                                        "Alert", _errorText!, false);
                                  });
                                } else {
                                  setState(() {
                                    _errorText = null;
                                    debugPrint("has no error");
                                  });
                                }
                                if (!regex.hasMatch(
                                    settingController.cpassword.text)) {
                                  setState(() {
                                    _errorText =
                                        'Confirm Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be at least 8 characters long.';
                                    debugPrint("has error");
                                    util.showSnackBar(
                                        "Alert", _errorText!, false);
                                  });
                                } else {
                                  setState(() {
                                    _errorText = null;
                                    debugPrint("has no error");
                                    //
                                    AppConstant.getUserData("user_data")
                                        .then((value) => {
                                              if (value != null)
                                                {
                                                  if (value
                                                      .user_token.isNotEmpty)
                                                    {
                                                      settingController
                                                          .changePassword(
                                                              value.user_token)
                                                          .then((value) => {
                                                                if (value !=
                                                                    null)
                                                                  {
                                                                    util.showSnackBar(
                                                                        "Alert",
                                                                        value!,
                                                                        true),
                                                                    settingController
                                                                        .password
                                                                        .text = "",
                                                                    settingController
                                                                        .cpassword
                                                                        .text = "",
                                                                    Get.offAll(() =>
                                                                        MyHomePage(
                                                                            0))
                                                                  }
                                                              })
                                                    }
                                                }
                                            });
                                  });
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
                                child: Text("Update",
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
