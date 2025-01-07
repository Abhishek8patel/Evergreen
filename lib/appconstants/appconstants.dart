import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:testingevergreen/pages/myhomepage/myhomepage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:testingevergreen/pages/login/login.dart';
import 'package:testingevergreen/pages/signup/signup.dart';
import 'package:testingevergreen/pages/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_storage/get_storage.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../pages/SV/svmodels/getSvReportDTO.dart';
import 'mycolor.dart';
import 'package:testingevergreen/pages/SV/svmodels/getSvReportDTO.dart'
    as svReportDTO;

class AppConstant {
  static LinearGradient Form_Btn_Gredient(Color color_one, Color color_two) {
    return LinearGradient(
      colors: [color_one, color_two],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }

  static Color Form_btn_color_one = Color(0xff25BF63);
  static Color Form_btn_color_two = Color(0xff11592E);

  static final String THANKS_MSG =
      "Thanks Your Verification successfully Completed and updated to admin.";

  static njDebug({required String TAG, required String msg}) {
    debugPrint(TAG + "$msg}");
  }

  static Future showloading() {
    return Get.defaultDialog(
        title: "",
        barrierDismissible: true,
        content: Center(
          child: SpinKitFadingCircle(
            color: Colors.green,
            size: 50.0,
          ),
        ));
  }

  Future<void> enable_full_screen() {
    return SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> disable_full_screen() {
    return SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  static TextStyle getRoboto(
      FontWeight fontWeight, double fontSize, Color color) {
    return GoogleFonts.roboto(
        fontWeight: fontWeight, fontSize: fontSize, color: color);
  }

  static TextStyle getPopins(
      FontWeight fontWeight, double fontSize, Color color) {
    return GoogleFonts.poppins(
        fontWeight: fontWeight, fontSize: fontSize, color: color);
  }

  static InkWell getButton(
      TextStyle style, String title, double width, double height,
      [VoidCallback? onTap]) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: AppConstant.BUTTON_COLOR,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(8.00),
        width: width,
        height: height,
        child: Center(child: Text(title, style: style)),
      ),
    );
  }

  static InkWell getTapButton(TextStyle style, String title, double width,
      double height, VoidCallback? onTap,
      {BorderRadiusGeometry? borderRadius}) {
    return InkWell(
      onTap: onTap ?? null,
      child: Container(
        decoration: BoxDecoration(
          gradient: AppConstant.BUTTON_COLOR,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(8.00),
        width: width,
        height: height,
        child: Center(child: Text(title, style: style)),
      ),
    );
  }

  static void showCustomDialog(String title, BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${title}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();

                  // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  static Future<UserModel?> getUserData(key) async {
    final sp = await SharedPreferences.getInstance();
    var user_data = [];
    UserModel? userModel = null;

    user_data = sp.getStringList(key) ?? [];
    if (!user_data.isEmpty) {
      return userModel = UserModel(
          user_id: user_data[0].toString(),
          user_token: user_data[1].toString(),
          user_name: user_data[2].toString(),
          user_mobile: user_data[3].toString(),
          user_pic: user_data[4].toString(),
          user_role: user_data[5].toString(),
          user_deviceID: user_data[6].toString());
    } else {
      return null;
    }
  }

  static Future<svReportDTO.Product?> getSElistData(key) async {
    final sp = await SharedPreferences.getInstance();
    var user_data = "";
    svReportDTO.Product? temp = null;

    user_data = sp.getString(key)!;
    if (!user_data.isEmpty) {
      temp = jsonDecode(user_data);
      return temp;
    } else {
      return null;
    }
  }

  static final String POST_JOB_HEAD = "Post on Job";

  static final String MOBILE_ERROR = "Please fill valid mobile number.";
  static final String PASSWORD_ERROR = "Please fill valid password.";
  static final String COUNTRY_ERROR = "Please select country.";
  static final String OTP_ERROR = "OTP didn't match.";
  static final String BLANK_ERROR = "OTP didn't match.";
  static final String FETCH_MOBILE = "Couldn't fetch mobile number.";

  static final String TEXT_HEAD_OTP = "OTP";
  static final String TEXT_CON_NEW_PASSWORD = "Confirm New Password";
  static final String REM_ME = "Remember Me ?";
  static final String FORGOT_PW = "Forgot Password ?";
  static final String RESEND = "Resend?";
  static final String EMAIL_ADD = "Email Address";
  static final String PASSWORD = "Password";

  static final String TEXT_NEW_PASSWORD = "New Password";
  static final String TEXT_CONTACT_NUMBER = "Contact Number";
  static final double APP_PADDING_83 = 83.00;
  static final double APP_NORMAL_PADDING = 8.00;
  static final double APP_NORMAL_PADDING_26 = 26.00;
  static final double APP_NORMAL_PADDING_34 = 34.00;
  static final double APP_LARGE_PADDING = 14.00;
  static final double APP_EXTRA_LARGE_PADDING = 24.00;

  static final double SMALL_TEXT_SIZE = 8.00;
  static final double MEDIUM_TEXT_SIZE = 10.00;
  static final double LOCATION_TEXT_SIZE = 12.00;
  static final double SMALL_SIZE = 14.00;
  static final double EXTRA_MEDIUM_SIZE = 16.00;
  static final double EXTRA_MEDIUM_SIZE_16 = 16.00;

  static final double MEDIUM_SIZE = 20.00;
  static final double HEADLINE_SIZE = 20.00;
  static final double HEADLINE_SIZE_18 = 18.95;
  static final double HEADLINE_SIZE_20 = 20.00;
  static final double HEADLINE_SIZE_22 = 22.00;
  static final double HEADLINE_SIZE_10 = 10.00;
  static final double HEADLINE_SIZE_15 = 15.00;
  static final double HEADLINE_SIZE_16 = 16.00;
  static final double HEADLINE_SIZE_12 = 12.00;
  static final double HEADLINE_SIZE_11 = 11.00;
  static final double HEADLINE_SIZE_14 = 14.00;
  static final double HEADLINE_SIZE_17 = 17.161;

  static final double LARGE_SIZE = 28.00;

  static final double LARGE_SIZE_22 = 22.00;
  static final double HEADLINE_SIZE_50 = 50.00;
  static final double HEADLINE_SIZE_25 = 25.00;

  static final double TEXT_HEAD_WIDTH = 270;
  static final double TEXT_HEAD_HIGHT = 41;

  static final String ERROR_NEW_PASSWORD = "Please enter valid new password.";
  static final String ERROR_CONFIRM_NEW_PASSWORD =
      "Please enter valid confirm new password.";
  static final String ERROR_PASSWORD_MATCH = "Password didn't match";
  static final String ERROR_EMAIL = "Please enter valid email address.";

  static final String LOGIN_HEAD = "LOGIN";
  static final String LOGIN_HEAD_SMALL = "Login";
  static final String UPDATE_HEAD_SMALL = "Update";

  static final String Button_Text_Attendance = "Attendance";
  static final String Button_Text_View = "View";
  static final String OTP_HEAD =
      "We Sent verification code to your registered mobile number";

  static final String MOBILE_HEAD = "Please enter your Mobile number";

  static final String SUBMIT_BUTTON_TEXT = "SUBMIT";
  static final String FORGOT_BUTTON_TEXT = "Forgot";
  static final String PROFILE_HEAD = "My Profile";
  static final String SIGNUP_NAME = "Signup";
  static final String FORGOT_PASSWORD_HEAD = "Forgot Password";

  static final String REGISTER = "Register";

  static final String SUBMIT = "SUBMIT";
  static final String UPDATE = "Update";
  static final String CHAT = "Chat";
  static final String CHATLIST = "Chat List";

  static final String HINT_TEXT_FULL_NAME = "Full Name";

  static final String HINT_TEXT_FIRST_NAME = "First Name";

  static final String HINT_TEXT_LAST_NAME = "Last Name";

  static final String HINT_TEXT_EMAIL = "Email";
  static final String HINT_TEXT_MOBILE = "Mobile";
  static final String HINT_TEXT_SUCCESS =
      "Thanks \n Your account has been created successfully";

  static final String TEXT_SHARE_EXP = "Share your experience with us";

  static final String DEFAULT_BACKEND_IMG =
      "https://tobuu-private-buckets.s3.ap-south-1.amazonaws.com/defult_profile/defult_pic.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAZI2LH354OWUE72TX%2F20240212%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20240212T104943Z&X-Amz-Expires=900&X-Amz-Signature=d4e1bacbcba6088c1cb85f1d5df0077cac07851eb577e754a64cf2dd5f6139de&X-Amz-SignedHeaders=host&x-id=GetObject";

  static final String TEXT_HOORAY =
      "Job Completed Success fully. Now you can able to give review and rating to Freelancer.";

  static final String TEXT_LOGIN =
      " You need to login/signup for access more feature.";

  static final String HIRE_SUCCESS =
      "Job Completed Success fully.Now you can able to give review and rating to Freelancer.";

  static final String HINT_TEXT_NAME = "Enter Your Full Name";

  static final String LOGIN_EMAIL_TEXT = "Enter Your Number";

  static final String HINT_TEXT_PASSWORD = "Enter Your Password";

  static final String HINT_CALENDAR_NORMAL_DAY_MOR =
      "Enter Normal Day Morning Price";

  static final String HINT_CALENDAR_SPECIAL_DAY_PRICE =
      "Enter Special Day Price";

  static final String HINT_CALENDAR_NORMAL_DAY_EVE =
      "Enter Normal Day Evening Price";

  static final String HINT_TEXT_USERNAME = "Username(max:20)";
  static final String HINT_TEXT_MOBILE_NO = "Mobile Number";

  static final String HINT_TEXT_ADDRESS = "Address";
  static final String HINT_TEXT_EMAIL_SIGNUP = "Email";
  static final String HINT_TEXT_DOB = "DOB";
  static final String HINT_TEXT_PASSWORD_SIGNUP = "Password";
  static final String HINT_TEXT_CONFIRM_PASSWORD_SIGNUP = "Confirm Password";

  static final String LOGIN_HEAD_TEXT_PASSWORD = "Enter Your Password";
  static final String HINT_TEXT_OTP = "Enter OTP";
  static final String HINT_TEXT_PASS = "Enter New Password";
  static final String HINT_TEXT_CON_PASSWORD = "Enter New Confirm Password";
  static final String HINT_TEXT_NEW_CON_PASSWORD = "Enter New Confirm Password";
  static final String HINT_TEXT_CONTACT_NUMBER = "Enter Your Contact Number";

  static final String TEXT_PASS = "New Password";
  static final String TEXT_CON_PASSWORD = "Confirm New Password";
  static final String TEXT_OTP = "Otp";
  static final String TEXT_MOBILE_NUMBER = "Mobile Number";
  static final String TEXT_ENTER_MOBILE_NUMBER = "Enter Mobile Number";
  static final String TEXT_NAME = "Full Name";
  static final String TEXT_MOBILE = "Enter Your Mobile";
  static final String TEXT_PASSWORD = "Enter Your Password";
  static final String TEXT_OTP_MESSSAGE =
      "Enter your OTP received on your registerd number";
  static final String TEXT_OTP_HEAD = "Enter OTP";
  static final String TEXT_EMAIL = "Email";
  static final String TEXT_HEAD_CHANGE_PW = "Change Password";
  static final String TEXT_HEAD_NOTIFICATION = "Notification";

  static const String APP_NAME = "Tobuu";

  static final String BASE_URL = "https://app.evergreenion.com";

  static final String LOGOUT_ENDPOINT = "/api/logout/";

  static final String REG_ENDPOINT = "/api/webservice/registration";
  static final String LOG_ENDPOINT = "/api/webservice/login";
  static final String OTP_ENDPOINT = "/api/webservice/verifyotp";
  static final String LOGIN_ENDPOINT = "/api/webservice/login/";
  static final String GET_PROFILE_ENDPOINT = "/api/webservice/profile/";

  static final String FORGOT_PW_ENDPOINT = "/api/webservice/forget_password";
  static final String CREATE_PW_ENDPOINT = "/api/webservice/forgot_password";
  static final String RESEND_OTP_ENDPOINT = "/api/webservice/resendotp";
  static final String CHANGE_PW_ENDPOINT = "/api/webservice/change_password";

  static final String UPDATE_PROFILE_ENDPOINT =
      "/api/webservice/update_profile";
  static final String ALLPOST_ENDPOINT = "/api/webservice/allpost";
  static final String MYPOST_ENDPOINT = "/api/webservice/mypost/";
  static final String NEWS_ENDPOINT = "/api/webservice/news";
  static final String CHATLIST_ENDPOINT = "/api/webservice/chatlist/";
  static final String CHATMSG_ENDPOINT = "/api/webservice/chatmessage/";
  static final String POST_ENDPOINT = "/api/webservice/post";
  static final String POST_FILTER = "/api/webservice/fillter";

  static final String POST_VERIFY = "/api/webservice/verifyotp";
  static final String POST_RESENDOTP = "/api/webservice/resendotp";
  static final String POST_FORGET_PASSWORD = "/api/webservice/forget_password";
  static final String TEXT_HEAD_CREATE_PASSWORD = "Create Password";

  static final Gradient BUTTON_COLOR = LinearGradient(colors: [
    MyColor.BUTTON_GRADIENT_START_COLOR,
    MyColor.BUTTON_GRADIENT_END_COLOR,
    MyColor.BUTTON_GRADIENT_START_COLOR,
  ], begin: Alignment.centerLeft, end: Alignment.centerRight);

  static final Gradient BUTTON_COLOR_SELFIE = LinearGradient(colors: [
    MyColor.BUTTON_GRADIENT_ATTENDANCE_START_COLOR,
    MyColor.BUTTON_GRADIENT_ATTENDANCE_MIDDLE_COLOR,
    MyColor.BUTTON_GRADIENT_ATTENDANCE_START_COLOR,
  ], begin: Alignment.centerLeft, end: Alignment.centerRight);

  static final Gradient BUTTON_DISABLE_COLOR = LinearGradient(colors: [
    MyColor.BUTTON_DISABLE_GRADIENT_START_COLOR,
    MyColor.BUTTON_DISABLE_GRADIENT_END_COLOR,
  ], begin: Alignment.centerLeft, end: Alignment.centerRight);

  static final Gradient BUTTON_COLOR_TRANSPARENT = LinearGradient(colors: [
    MyColor.BUTTON_GRADIENT_TRANSPARENT_COLOR,
    MyColor.BUTTON_GRADIENT_TRANSPARENT_COLOR,
  ], begin: Alignment.centerLeft, end: Alignment.centerRight);

  static final Gradient SETTING_BUTTON_COLOR = LinearGradient(colors: [
    MyColor.SETTING_GRADIENT_START_COLOR,
    MyColor.SETTING_GRADIENT_END_COLOR,
  ], begin: Alignment.centerLeft, end: Alignment.centerRight);

  static final Gradient Notification_gradient = LinearGradient(colors: [
    Color.fromRGBO(186, 247, 255, 1),
    Color.fromRGBO(139, 167, 241, 0.29)
  ], begin: Alignment.topLeft, end: Alignment.topRight);

  static final Gradient LOGOUT_SETTING_BUTTON_COLOR = LinearGradient(colors: [
    MyColor.LOGOUT_BUTTON_GRADIENT_START_COLOR,
    MyColor.LOGOUT_BUTTON_GRADIENT_END_COLOR,
  ], begin: Alignment.centerLeft, end: Alignment.centerRight);

  static final Gradient Book_BG = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xff0faac0), Color(0x7affffff)],
  );

  static TextStyle home_text_headline(double font_Size) {
    return TextStyle(
        fontFamily: 'Humanst521',
        fontSize: font_Size,
        fontWeight: FontWeight.w400,
        color: MyColor.LOGIN_TEXT_GREEN);
  }

  static String dummy_comment() {
    String str =
        "lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries";

    return str;
  }

  static String capitalizeTitle(String s) =>
      s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : '';

  static String capitalizeWords(String s) {
    List<String> words = s.split(' ');
    List<String> capitalizedWords = words.map((word) {
      if (word.isNotEmpty) {
        return '${word[0].toUpperCase()}${word.substring(1)}';
      } else {
        return '';
      }
    }).toList();
    return capitalizedWords.join(' ');
  }

  static TextStyle home_text_latestwork_title(double font_Size) {
    return GoogleFonts.portLligatSans(
        fontWeight: FontWeight.w400,
        fontSize: font_Size,
        color: MyColor.LOGIN_TEXT_GREEN);
  }

  static TextStyle home_text_latestwork_description(double font_Size) {
    return GoogleFonts.poppins(
        fontWeight: FontWeight.w400, fontSize: font_Size, color: Colors.black);
  }

  static TextStyle edit_txt_hint() {
    return TextStyle(
        fontFamily: 'Nunito',
        fontSize: 16.0,
        color: Color.fromRGBO(160, 160, 160, 0.60),
        fontWeight: FontWeight.w400);
  }

  static final Gradient paitent_1_bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(137, 62, 156, 1), Color.fromRGBO(248, 43, 115, 1)],
  );

  static final Gradient paitent_2_bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(84, 138, 216, 1), Color.fromRGBO(138, 75, 211, 1)],
  );

  static final Gradient paitent_3_bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(211, 150, 70, 1), Color.fromRGBO(204, 204, 205, 1)],
  );

  static final Gradient paitent_4_bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(243, 62, 98, 1), Color.fromRGBO(247, 147, 52, 1)],
  );

  static final Gradient paitent_5_bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(214, 35, 234, 1), Color.fromRGBO(204, 204, 204, 1)],
  );

  static final double BUTTON_WIDTH = 295.00;
  static final double BUTTON_HIGHT = 53.00;

  static final double BUTTON_DAHBOARD_WIDTH = 100.00;
  static final double BUTTON_DAHBOARD_HIGHT = 40.00;
  static final double BUTTON_WIDTH_72 = 72.00;
  static final double BUTTON_HIGHT_36 = 36.00;

  static final double BUTTON_WIDTH_110 = 110.00;
  static final double BUTTON_HIGHT_40 = 40.00;

  static final double BUTTON_WIDTH_144 = 144.00;

  static final double BUTTON_WIDTH_68 = 68.00;
  static final double BUTTON_HIGHT_25 = 25.00;

  static final EDITTEXT_BOX_WIDTH = 329.00;
  static final double EDITTEXT_BOX_HIGHT = 45; //design 70 too big

  static final Gradient bg_test = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color.fromRGBO(255, 255, 255, 1),
        Color.fromRGBO(114, 196, 255, 0.69)
      ]);

  static String REZORPAY_KEY = "rzp_live_bKYgA63uPKBIza";
  static String REZORPAY_SECRETKEY = "IVqACqQw7SIMOCIvQd7Isxf8";

  // static Future delete_video(timeLineController, util, _dashboardController, i,
  //     String from, ProfileController profileController) {
  //   return Get.bottomSheet(StatefulBuilder(
  //     builder: (context, setState) {
  //       return Container(
  //         height: 200,
  //         width: double.maxFinite,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(20), topRight: Radius.circular(20)),
  //         ),
  //         child: Padding(
  //           padding: EdgeInsets.all(10),
  //           child: Column(
  //             children: [
  //               SizedBox(height: 20),
  //               Text(
  //                 "Delete",
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.w600),
  //               ),
  //               SizedBox(height: 20),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       debugPrint("reelid" +
  //                           profileController.mylistOfReels.value[i].id
  //                               .toString());
  //                       _dashboardController
  //                           .deletereel(
  //                             AppConstant.take_data("token"),
  //                             "${profileController.mylistOfReels.value[i].id}",
  //                           )
  //                           .then((value) => {
  //                                 Navigator.of(context).pop()
  //                               });
  //                     },
  //                     style: ButtonStyle(
  //                         shape:
  //                             MaterialStateProperty.all<RoundedRectangleBorder>(
  //                                 RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(10))),
  //                         backgroundColor:
  //                             MaterialStateProperty.all<Color>(Colors.green)),
  //                     child: Text(
  //                       "Delete",
  //                       style: TextStyle(
  //                           fontSize: 20, fontWeight: FontWeight.w800),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   ),
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(20))));
  // }

  static final String TITLE_TEXT_PROFILE = "Profile";
  static final String TITLE_TEXT_MY_PROFILE = "My Profile";
  static final String TITLE_TEXT_CHANGE_PASSWORD = "Change Password";
  static final String TITLE_TEXT_NOTIFICATION = "Notification";
  static final String TITLE_TEXT_VIDEO = "Video";
  static final String TITLE_TEXT_APPOINTEMNT = "Appointment";
  static final String TITLE_TEXT_PRESCRIPTION = "Prescription";
  static final String TITLE_TEXT_PAY_HISTORY = "Payment History";

  static final String TITLE_TEXT_ABOUTUS = "About Us";

  static final String TITLE_TEXT_PRIVACYPOLICY = "Privacy Policy";

  static signup_text(BuildContext? context) {
    return Container(
      height: 25,
      width: 238,
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account?",
              style: GoogleFonts.nunito(
                  textStyle: Theme.of(context!).textTheme.displayLarge,
                  fontSize: AppConstant.EXTRA_MEDIUM_SIZE,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  color: MyColor.DONTHAVEAC_TEXT_GREEN)),
          Text(" Sign up",
              style: GoogleFonts.nunito(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: AppConstant.EXTRA_MEDIUM_SIZE,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  color: MyColor.DONTHAVEAC_TEXT_GREEN))
        ],
      )),
    );
  }

  static lgoin_text(BuildContext? context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 25,
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already Have Account?",
              style: GoogleFonts.nunito(
                  textStyle: Theme.of(context!).textTheme.displayLarge,
                  fontSize: AppConstant.EXTRA_MEDIUM_SIZE_16,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  color: MyColor.LOGIN_TEXT_GREEN)),
          Text(
            " Sign In",
            style: GoogleFonts.nunito(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: AppConstant.EXTRA_MEDIUM_SIZE_16,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: MyColor.LOGIN_TEXT_GREEN),
          )
        ],
      )),
    );
  }

  static List<BoxShadow> shadow_bottom() {
    return [
      BoxShadow(
        color: Colors.grey,
        offset: Offset(0, 5), // Only y-offset for bottom shadow
        blurRadius: 10.0,
        spreadRadius: 2.0,
      ),
    ];
  }

  static shadow() {
    return BoxDecoration(
      color: Colors.blue,
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
    );
  }

  static Shimmer getShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10, // Number of shimmer items
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(),
            title: Container(
              height: 20,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 10,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  static Shimmer getShimmerForVideo() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10, // Number of shimmer items
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromRGBO(255, 255, 255, 1),
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
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //top toolbar
                Bounceable(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(left: 25, right: 25, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle),
                                width: 40,
                                height: 40,
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  width: 38,
                                  height: 38,
                                  padding: EdgeInsets.all(2),
                                  // Border width
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(52),
// Image radius
                                      child: Image.network(
                                        '',
                                        fit: BoxFit.fitHeight,
                                        errorBuilder:
                                            (context, error, stacktrace) =>
                                                SvgPicture.asset(
                                          'assets/images/person_black.svg',
                                          semanticsLabel: 'My SVG Image',
                                          height: 30,
                                          width: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "test",
                                  style: AppConstant.home_text_latestwork_title(
                                      17.00),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 19,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: const Offset(
                                              2.0,
                                              2.0,
                                            ),
                                            blurRadius: 1.0,
                                            spreadRadius: 1.0,
                                          ), //BoxShadow
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: const Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            spreadRadius: 0.0,
                                          ), //
                                          // BoxShadow
                                        ],
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            "test",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    43, 102, 57, 1),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "test",
                                      style: TextStyle(
                                          color: Color.fromRGBO(43, 102, 57, 1),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        //option

                        Bounceable(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/images/option_dots.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 27,
                ),
                //video
                Container(
                    margin: EdgeInsets.all(5),
                    width: 336,
                    height: 388,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage("")),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey),
                    child: Container()),
                //Video(
                // "${_dashboardController.allTrendingVideosList.value[i].videoUrl}")

                SizedBox(
                  height: 20,
                ),
                //description
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "test",
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                //boottom toolbar
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: MyColor.LOGIN_TEXT_GREEN,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text("test")
                        ],
                      ),
                      Bounceable(
                        onTap: () {
                          // videoHomeController.videoLikeDislike(_dashboardController.allTrendingVideosList.value[i].id,_dashboardController.allTrendingVideosList.value[i]. )
                        },
                        child: Bounceable(
                          onTap: () {
                            // util.showSnackBar("Alert", "clicked", true);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              LikeButton(
                                onTap: (isLiked) async {
                                  return !isLiked;
                                },
                                size: 25,
                                isLiked: false,
                                likeCount: 10,

                                //     Icon(
                                //   checkLikeStatus(i) == false ? CupertinoIcons.heart : CupertinoIcons.heart_solid,
                                //   color: _dashboardController.allTimeline.value[i].likeStatus == "No" ? MyColor.LOGIN_TEXT_GREEN : Colors.green,
                                // ),
                                likeBuilder: (isLiked) {
                                  final color = Colors.green;

                                  return Icon(
                                      isLiked == true
                                          ? CupertinoIcons.heart_solid
                                          : CupertinoIcons.heart,
                                      color: isLiked == true
                                          ? MyColor.LOGIN_TEXT_GREEN
                                          : Colors.green);
                                },
                              ),
                              SizedBox(
                                width: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Bounceable(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.message,
                              color: MyColor.LOGIN_TEXT_GREEN,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text("test"),
                            SizedBox(
                              width: 15,
                            ),
                            Bounceable(
                              onTap: () async {
                                // util.showSnackBar("Alert", "Clicked", true);
                              },
                              child: Icon(
                                Icons.share,
                                color: MyColor.LOGIN_TEXT_GREEN,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Bounceable(
                        onTap: () {},
                        child: Container(
                          width: 70,
                          height: 23,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromRGBO(87, 138, 72, 1),
                                  Color.fromRGBO(50, 105, 66, 1)
                                ]),
                            color: Color.fromRGBO(255, 255, 255, 1),
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
                          ),
                          child: Center(
                            child: Text(
                              "yes",
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  static whiteShadow() {
    return BoxDecoration(
      color: Colors.white,
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
    );
  }

  static OpenSans(BuildContext? context, Color color) {
    return GoogleFonts.nunitoSans(
        textStyle: Theme.of(context!).textTheme.displayLarge,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: color);
  }

  static Lextendnew(BuildContext? context, Color color, double? size,
      [FontWeight? fontWeight]) {
    return GoogleFonts.lexend(
        textStyle: Theme.of(context!).textTheme.displayLarge,
        fontSize: size == null ? 10 : size,
        fontWeight: fontWeight ?? FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: color);
  }

  static TitleFont(BuildContext? context, [FontWeight? fontWeight]) {
    return GoogleFonts.poppins(
        textStyle: Theme.of(context!).textTheme.displayLarge,
        fontSize: 20,
        fontWeight: fontWeight ?? FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: Colors.green);
  }

  static setting_text(String text, BuildContext context) => GoogleFonts.roboto(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: AppConstant.EXTRA_MEDIUM_SIZE_16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: MyColor.LOGIN_TEXT_GREEN);

  static Dashboard_text(String text, BuildContext context, double size) =>
      GoogleFonts.roboto(
          textStyle: Theme.of(context).textTheme.displayLarge,
          fontSize: size,
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.normal,
          color: Colors.white);

  static HEADLINE_TEXT(String text, context) => GradientText(
        text,
        style: AppConstant.TitleFont(context),
        gradient: LinearGradient(colors: [
          MyColor.HEADLINE_TEXT_GRADIENT_START_COLOR,
          MyColor.HEADLINE_TEXT_GRADIENT_END_COLOR,
        ], begin: Alignment.centerLeft, end: Alignment.centerRight),
      );

  static List<BoxShadow> list_shadow_on() {
    return [
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
      )
    ];
  }

  static List<BoxShadow> list_shadow_off() {
    return [
      BoxShadow(
        color: Colors.grey,
        offset: const Offset(
          0.0,
          0.0,
        ),
        blurRadius: 0.0,
        spreadRadius: 0.0,
      ), //BoxShadow
      BoxShadow(
        color: Colors.white,
        offset: const Offset(0.0, 0.0),
        blurRadius: 0.0,
        spreadRadius: 0.0,
      ), //
// BoxShadow
    ];
  }

  static setData(String key, dynamic value) => GetStorage().write(key, value);

  static String? getString(String key) => GetStorage().read(key);

  static void removeData(String key) => GetStorage().remove(key);

  static void save_data(String key, String val) async {
    await AppConstant.setData(key, val);
  }

  static String take_data(String key) {
    return AppConstant.getString(key).toString();
  }

  static Future<String> initDeviceId() async {
    String deviceId = "";
    AndroidBuildVersion? androidBuildVersion;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return deviceId = androidInfo.id!; // Unique ID for Android
      AppConstant.save_data("deviceId", deviceId);
      androidBuildVersion = androidInfo.version;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return deviceId = iosInfo.identifierForVendor!; // Unique ID for iOS
    } else {
      return deviceId = 'Unsupported Platform';
    }
  }

  static Dialog loginDialog(BuildContext context, [bool? isCancelable]) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: SingleChildScrollView(
          child: Container(
            width: 372.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        left: 30, right: 10, bottom: 10, top: 10),
                    child: InkWell(
                      onTap: () {
                        debugPrint("login clicked");
                        Get.to(() => Login());
                        // Get.back();
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.cancel,
                          color: Colors.green,
                        ),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: 175,
                  width: 173,
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.asset(
                    "assets/images/login_icon.png",
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 48.00, right: 48.00, top: 48.00),
                  child: Text(
                    '${AppConstant.TEXT_LOGIN}',
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
                            Navigator.pop(context);
                            Get.to(Login());
                          },
                          child: Container(
                            width: 110,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: MyColor.LOGIN_TEXT_GREEN,
                                    width: 0.5)),
                            child: Center(
                              child: Text("Login",
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
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Get.to(Signup());
                            Get.back();
                          },
                          child: Container(
                            width: 110,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: MyColor.LOGIN_TEXT_GREEN,
                                    width: 0.5)),
                            child: Center(
                              child: Text("Signup",
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
                    )),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ));
  }

  static Container ThanksVerification(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Align(
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/otp_verification.png"))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Thanks",
                style: AppConstant.getPopins(FontWeight.w700,
                    AppConstant.HEADLINE_SIZE_20, Colors.black),
              ),
              Center(
                child: Container(
                  width: 330,
                  child: Text(
                    "Your Verification successfully Completed and updated to admin.",
                    style: AppConstant.getPopins(FontWeight.w400,
                        AppConstant.HEADLINE_SIZE_20, Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: AppConstant.getTapButton(
                AppConstant.getRoboto(FontWeight.w800, 20, Colors.white),
                "Ok",
                121,
                53, () {
              Get.offAll(MyHomePage(0));
            }, borderRadius: BorderRadius.circular(30)),
          )
        ],
      ),
    );
  }

  static TextFormField contactTextFormField(
      {required TextEditingController controller,
      required TextAlign textAlign,
      required Function() myfun,
      required TextInputType textInputType,
      required InputDecoration inputDecoration,
      List<TextInputFormatter>? textformatter}) {
    return TextFormField(
      controller: controller,
      textAlign: textAlign,
      onTap: myfun,
      keyboardType: TextInputType.text,
      decoration: inputDecoration,
      inputFormatters: textformatter,
    );
  }

  static final String dummy_text =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book";
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
