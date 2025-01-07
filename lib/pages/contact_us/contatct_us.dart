import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
// import '../../Utills/universal.dart';
// import '../../Utills/utills.dart';
import '../../Utills3/universal.dart';
import '../../Utills3/utills.dart';
import '../../appconstants/appconstants.dart';
import '../../appconstants/mycolor.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import '../profile/profile_controller.dart';
import 'contact_controller.dart';

class ContactUs extends StatefulWidget {
  bool? isLogin;

  ContactUs({Key? key, required this.isLogin}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  ProfileController profileController = Get.find();
  ContactController contactController = Get.find();
  var isLoding = true;
  var util = Utills();

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoding = false;
    });
    // updateData().then((value){
    //   setState(() {
    //     isLoding=false;
    //   });
    //
    // });
  }

  @override
  void dispose() {
    super.dispose();
    profileController.dispose();
    //clearData();
  }

  Future updateData() async {
    if (widget.isLogin == true) {
      await profileController
          .getProfile(AppConstant.take_data("token"))
          .then((value) => {
                contactController.name.text =
                    profileController.name_profile.toString(),
                contactController.mobile.text =
                    profileController.contact_profile.toString(),
                contactController.email.text =
                    profileController.email_profile.toString()
              });
    }
  }

  clearData() {
    contactController.name.text = "";
    contactController.mobile.text = "";
    contactController.email.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus!.unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Column(
            children: [
              backToolbar(
                name: "Contact Us",get_back: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: Get.height,
                    width: Get.width,
                    child: isLoding == true
                        ? AppConstant.getShimmer()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //name
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
                                            child:
                                                AppConstant.contactTextFormField(
                                                    controller:
                                                        contactController.name,
                                                    textAlign: TextAlign.left,
                                                    myfun: () {},
                                                    inputDecoration:
                                                        InputDecoration(
                                                      hintStyle: AppConstant
                                                          .edit_txt_hint(),
                                                      border: InputBorder.none,
                                                      hintText: "Name",
                                                    ),
                                                    textformatter: [
                                                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')), // Allows only letters and spaces
                                                    ],
                                                    // inputFormatters: [
                                                    //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')), // Allows only letters and spaces
                                                    // ],
                                                    textInputType: TextInputType
                                                        .visiblePassword),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //mobile
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

                                            controller: contactController.mobile,
                                            textAlign: TextAlign.left,
                                            onTap: () {
                                              setState(() {});
                                            },
                                            inputFormatters: [
                                              new LengthLimitingTextInputFormatter(
                                                  10),
                                              FilteringTextInputFormatter.allow(RegExp(r"^[0-9]+$"))
                                            ],
                                            decoration: InputDecoration(
                                              hintStyle:
                                                  AppConstant.edit_txt_hint(),
                                              border: InputBorder.none,
                                              hintText: "Mobile",
                                            ),
                                            keyboardType: TextInputType.phone,
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //email
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
                                            controller: contactController.email,
                                            textAlign: TextAlign.left,
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
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //message
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
                                          height: 200,
                                          child: Center(
                                              child: TextFormField(
                                            controller: contactController.message,
                                            textAlign: TextAlign.left,
                                            onTap: () {
                                              setState(() {});
                                            },
                                            decoration: InputDecoration(
                                              hintStyle:
                                                  AppConstant.edit_txt_hint(),
                                              border: InputBorder.none,
                                              hintText: "Message",
                                            ),
                                            keyboardType: TextInputType.multiline,
                                            maxLines: 10,
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                    top: AppConstant.APP_PADDING_83,
                                    left: AppConstant.LARGE_SIZE,
                                    right: AppConstant.LARGE_SIZE,
                                    bottom: AppConstant.SMALL_TEXT_SIZE),
                                child: Bounceable(
                                  onTap: () {
                                    contactController.contactUS(widget.isLogin);
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
                                              fontSize:
                                                  AppConstant.HEADLINE_SIZE_20,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),

                              // Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                              //   Text("Note:",style: GoogleFonts.poppins(
                              //       fontWeight: FontWeight.w600,
                              //       fontSize: 16,
                              //       color: MyColor.LOGIN_TEXT_GREEN
                              //   ),),
                              //   SizedBox(width: 10,),
                              //   Text("your bank details edit 1 time",style: GoogleFonts.poppins(
                              //       fontWeight: FontWeight.w400,
                              //       fontSize: 16,
                              //       color: Color.fromRGBO(149, 149, 149, 0.65)
                              //   ),)
                              // ],)
                            ],
                          ),
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
