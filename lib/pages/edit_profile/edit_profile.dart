import 'package:testingevergreen/pages/dashboard/dashboard.dart';
import 'package:testingevergreen/pages/myhomepage/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// import '../../Utills/universal.dart';
// import '../../Utills/utills.dart';
import '../../Utills3/universal.dart';
import '../../Utills3/utills.dart';
import '../../appconstants/appconstants.dart';
import '../../appconstants/mycolor.dart';
import '../dashboard/dahboard_controller.dart';
import '../profile/profile_controller.dart';
import 'edit_pro_controller.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final util = Utills();
  EditProfileController editProfileController = Get.find();
  ProfileController profileController = Get.find();

  DateTime selectedDate = DateTime.now();
  var _selected_date = "";
  var _selected_month = "";
  var _selected_year = "";
  var profileLoading = false;
  late String? _userToken;

  DashboardController _dashboardController = Get.find();

  var selected_category = "";
  var categories_data = [""].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Expanded(child: Text(value)),
    );
  }).toList();

  var finaloptions = [];

  @override
  void initState() {
    super.initState();

    profileLoading = true;
    if (mounted) {
      AppConstant.getUserData("user_data").then((value) => {
            if (value != null)
              {
                debugPrint("usertokenn:${value.user_token}"),
                profileController.getProfile(value.user_token).then((value) => {
                      value!.user!.fullName!,
                      editProfileController.first_name.text =
                          value!.user!.fullName!,
                      debugPrint("fullName:${value!.user.fullName}"),
                      editProfileController.email.text = value!.user!.email!,
                      editProfileController.mobile.text =
                          value!.user!.mobile!.toString(),
                      editProfileController.address.text =
                          value!.user!.address!,
                    }),

                setState(() {
                  _userToken = value.user_token!.toString();
                }),
                // util.showSnackBar("Alert", value.user_token, true)
                editProfileController.user_token.value =
                    value!.user_token!.toString(),
                profileController.myuser.value!.mobile.toString(),
                editProfileController.mobile.text =
                    profileController.myuser.value!.mobile.toString(),
                editProfileController.first_name.text =
                    profileController.myuser.value!.fullName.toString(),
                editProfileController.address.text =
                    profileController.myuser.value!.address.toString(),
                editProfileController.email.text =
                    profileController.myuser.value!.email.toString()
              }
            else
              {
                // util.showSnackBar("Alert", "sorry", false)
              }
          });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              backToolbar(
                name: "Edit Profile",
                get_back: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // name
                        Visibility(
                          visible: false,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: AppConstant.APP_NORMAL_PADDING_34,
                              right: AppConstant.APP_NORMAL_PADDING_34,
                              top: AppConstant.APP_NORMAL_PADDING_26,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppConstant.APP_NORMAL_PADDING),
                                border: Border.all(
                                    color: MyColor.LOGIN_TEXT_OUTLINE,
                                    width: 1.0),
                              ),
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
                                            setState(() {});
                                          },
                                          decoration: InputDecoration(
                                            hintStyle:
                                                AppConstant.edit_txt_hint(),
                                            border: InputBorder.none,
                                            hintText: "Name",
                                          ),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // username
                        Visibility(
                          visible: false,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: AppConstant.APP_NORMAL_PADDING_34,
                              right: AppConstant.APP_NORMAL_PADDING_34,
                              top: AppConstant.APP_NORMAL_PADDING_26,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppConstant.APP_NORMAL_PADDING),
                                border: Border.all(
                                    color: MyColor.LOGIN_TEXT_OUTLINE,
                                    width: 1.0),
                              ),
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
                                            setState(() {});
                                          },
                                          decoration: InputDecoration(
                                            hintStyle:
                                                AppConstant.edit_txt_hint(),
                                            border: InputBorder.none,
                                            hintText: "Username",
                                          ),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // mobile number
                        Visibility(
                          visible: false,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: AppConstant.APP_NORMAL_PADDING_34,
                              right: AppConstant.APP_NORMAL_PADDING_34,
                              top: AppConstant.APP_NORMAL_PADDING_26,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppConstant.APP_NORMAL_PADDING),
                                border: Border.all(
                                    color: MyColor.LOGIN_TEXT_OUTLINE,
                                    width: 1.0),
                              ),
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
                                            setState(() {});
                                          },
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                10),
                                          ],
                                          decoration: InputDecoration(
                                            hintStyle:
                                                AppConstant.edit_txt_hint(),
                                            border: InputBorder.none,
                                            hintText: "Mobile Number",
                                          ),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // first name
                        Padding(
                          padding: EdgeInsets.only(
                            left: AppConstant.APP_NORMAL_PADDING_34,
                            right: AppConstant.APP_NORMAL_PADDING_34,
                            top: AppConstant.APP_NORMAL_PADDING_26,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  AppConstant.APP_NORMAL_PADDING),
                              border: Border.all(
                                  color: MyColor.LOGIN_TEXT_OUTLINE,
                                  width: 1.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 45,
                                    child: Center(
                                      child: TextFormField(
                                        controller: profileController
                                            .user_full_name_controller,
                                        textAlign: TextAlign.center,
                                        onTap: () {
                                          setState(() {});
                                        },
                                        decoration: InputDecoration(
                                          hintStyle:
                                              AppConstant.edit_txt_hint(),
                                          border: InputBorder.none,
                                          hintText: "Full Name",
                                        ),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[a-zA-Z\s]')),
                                          // FilteringTextInputFormatter.allow(RegExp(r'~(?![0-9]\x{FE0F}\x{20E3}|\x{2139})[\pL\pN]+~')),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // last name
                        // interest list
                        // email
                        Padding(
                          padding: EdgeInsets.only(
                            left: AppConstant.APP_NORMAL_PADDING_34,
                            right: AppConstant.APP_NORMAL_PADDING_34,
                            top: AppConstant.APP_NORMAL_PADDING_26,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  AppConstant.APP_NORMAL_PADDING),
                              border: Border.all(
                                  color: MyColor.LOGIN_TEXT_OUTLINE,
                                  width: 1.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 45,
                                    child: Center(
                                      child: TextFormField(
                                        controller: profileController
                                            .user_email_controller,
                                        textAlign: TextAlign.center,
                                        onTap: () {
                                          setState(() {});
                                        },
                                        decoration: InputDecoration(
                                          hintStyle:
                                              AppConstant.edit_txt_hint(),
                                          border: InputBorder.none,
                                          hintText: "Email",
                                        ),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        inputFormatters: [],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // mobile
                        Padding(
                          padding: EdgeInsets.only(
                            left: AppConstant.APP_NORMAL_PADDING_34,
                            right: AppConstant.APP_NORMAL_PADDING_34,
                            top: AppConstant.APP_NORMAL_PADDING_26,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  AppConstant.APP_NORMAL_PADDING),
                              border: Border.all(
                                  color: MyColor.LOGIN_TEXT_OUTLINE,
                                  width: 1.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 45,
                                    child: Center(
                                      child: TextFormField(
                                        controller: profileController
                                            .user_mobile_controller,
                                        textAlign: TextAlign.center,
                                        onTap: () {
                                          setState(() {});
                                        },
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                        enabled: false,
                                        decoration: InputDecoration(
                                          hintStyle:
                                              AppConstant.edit_txt_hint(),
                                          border: InputBorder.none,
                                          hintText: "Mobile",
                                        ),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // address
                        Padding(
                          padding: EdgeInsets.only(
                            left: AppConstant.APP_NORMAL_PADDING_34,
                            right: AppConstant.APP_NORMAL_PADDING_34,
                            top: AppConstant.APP_NORMAL_PADDING_26,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  AppConstant.APP_NORMAL_PADDING),
                              border: Border.all(
                                  color: MyColor.LOGIN_TEXT_OUTLINE,
                                  width: 1.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 45,
                                    child: Center(
                                      child: TextFormField(
                                        controller: profileController
                                            .user_address_controller,
                                        textAlign: TextAlign.center,
                                        onTap: () {},
                                        decoration: InputDecoration(
                                          hintStyle:
                                              AppConstant.edit_txt_hint(),
                                          border: InputBorder.none,
                                          hintText: "Address",
                                        ),
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // submit
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppConstant.APP_NORMAL_PADDING,
                            left: AppConstant.LARGE_SIZE,
                            right: AppConstant.LARGE_SIZE,
                            bottom: AppConstant.SMALL_TEXT_SIZE,
                          ),
                          child: Bounceable(
                            onTap: () {
                              profileController
                                  .updateProfileDetails(
                                      _dashboardController.user_token.value)
                                  .then((value) => {
                                        if (value == 200)
                                          {Get.to(MyHomePage(0))}
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
                                child: Text(AppConstant.SUBMIT,
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
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
