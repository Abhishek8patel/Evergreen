// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_html/flutter_html.dart';
// // import '../../../Utills/universal.dart';
// // import '../../../Utills/utills.dart';
// import '../../../Utills3/universal.dart';
// import '../../../Utills3/utills.dart';
// import '../../../appconstants/appconstants.dart';
// import '../setting_controller.dart';
//
// class About extends StatefulWidget {
//   var index = 0;
//   var titleName;
//
//   About(int _index) {
//     this.index = _index;
//     this.titleName;
//   }
//
//   @override
//   State<About> createState() => _AboutState(this.index , this.titleName);
// }
//
// class _AboutState extends State<About> {
//   final SettingController settingController = Get.find();
//
//   final util = Utills();
//   var index = 0;
//
//
//   _AboutState(int _index, String? titleName) {
//     this.index = _index;
//     //this.namepass =titleName;
//   }
//
//   @override
//   void initState() {
//
//     super.initState();
//     if (this.index == 1) {
//       settingController.getaboutus("getPrivacyPolicy");
//     } else if (this.index == 0) {
//       settingController.getaboutus("getAboutUs");
//     } else {
//       settingController.getaboutus("getTermsConditions");
//     }
//
//     // util.showSnackBar("Alert", settingController.mydata.toString(), true);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             backToolbar(
//               name: "About Us",get_back: true,
//             ),
//
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     // Container(
//                     //   child: Center(
//                     //     child: Column(
//                     //       mainAxisAlignment: MainAxisAlignment.start,
//                     //       children: [
//                     //         Row(
//                     //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //           crossAxisAlignment: CrossAxisAlignment.center,
//                     //           children: [
//                     //             Bounceable(
//                     //               onTap: () {
//                     //
//                     //                 Get.back();
//                     //               },
//                     //               child: Visibility(
//                     //                 visible: true,
//                     //                 maintainSize: true,
//                     //                 maintainState: true,
//                     //                 maintainSemantics: true,
//                     //                 maintainAnimation: true,
//                     //                 child: Bounceable(
//                     //                   onTap: (){
//                     //
//                     //                     Get.back();
//                     //                   },
//                     //                   child: Container(
//                     //                     width: MediaQuery.of(context).size.width / 3,
//                     //                     alignment: Alignment.centerLeft,
//                     //                     child: Padding(
//                     //                       padding: EdgeInsets.only(top: 10),
//                     //                       child: Bounceable(
//                     //                         onTap: () {
//                     //
//                     //                           Get.back();
//                     //                         },
//                     //                         child: Container(
//                     //                           width: 70,
//                     //                           height: 40,
//                     //                           child: Image.asset(
//                     //                             "assets/images/back_btn.png",
//                     //                             scale: 1,
//                     //                           ),
//                     //                         ),
//                     //                       ),
//                     //                     ),
//                     //                   ),
//                     //                 ),
//                     //               ),
//                     //             ),
//                     //             Container(
//                     //               alignment: Alignment.center,
//                     //               width: MediaQuery.of(context).size.width / 3,
//                     //               child: Padding(
//                     //                 padding: const EdgeInsets.only(top: 15.0),
//                     //                 child: Container(
//                     //                     height: 30,
//                     //                     child: Center(
//                     //                       child: AppConstant.HEADLINE_TEXT(
//                     //                           index == 2
//                     //                               ? "Privacy Policy"
//                     //                               : index == 1
//                     //                                   ? "About US"
//                     //                                   : "T&C",
//                     //                           context),
//                     //                     )),
//                     //               ),
//                     //             ),
//                     //             Flexible(
//                     //               child: Visibility(
//                     //                 visible: false,
//                     //                 maintainAnimation: true,
//                     //                 maintainSemantics: true,
//                     //                 maintainState: true,
//                     //                 maintainSize: true,
//                     //                 child: Container(
//                     //                   width: MediaQuery.of(context).size.width / 3,
//                     //                   alignment: Alignment.centerRight,
//                     //                   child: Padding(
//                     //                       padding: EdgeInsets.only(top: 0, right: 10),
//                     //                       child: Icon(Icons.notifications)),
//                     //                 ),
//                     //               ),
//                     //             )
//                     //           ],
//                     //         ),
//                     //         SizedBox(
//                     //           height: 8,
//                     //         ),
//                     //         SizedBox(
//                     //           child: Container(
//                     //             height: 2,
//                     //             decoration:
//                     //                 BoxDecoration(color: Colors.grey, boxShadow: [
//                     //               BoxShadow(
//                     //                 offset: Offset(2, 4),
//                     //                 color: Colors.black.withOpacity(
//                     //                   0.3,
//                     //                 ),
//                     //                 blurRadius: 3,
//                     //               ),
//                     //             ]),
//                     //           ),
//                     //         )
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ),
//
//
//                     // Padding(
//                     //   padding: const EdgeInsets.all(10),
//                     //   child: InkWell(
//                     //     onTap: () {},
//                     //     child: Row(
//                     //       mainAxisAlignment: MainAxisAlignment.start,
//                     //       children: [
//                     //         Bounceable(
//                     //           onTap: () {
//                     //            // util.showSnackBar("Alert", "clicked", true);
//                     //           // Get.back();
//                     //            debugPrint("clicked");
//                     //           // Get.to(MyHomePage());
//                     //            Navigator.pop(context);
//                     //           },
//                     //           child: Padding(
//                     //             padding: const EdgeInsets.only(left:20.0),
//                     //             child: Image.asset("assets/images/back_btn.png",scale: 1,),
//                     //           ),
//                     //         ),
//                     //         SizedBox(width: MediaQuery.of(context).size.width/4,),
//                     //         Container(),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ),
//                     SizedBox(
//                       height: AppConstant.APP_EXTRA_LARGE_PADDING,
//                     ),
//                     Container(
//                       width: 200,
//                       child: Align(
//                           alignment: Alignment.center,
//                           child: index == 0
//                               ? Image.asset("assets/images/tobuu_logo.png")
//                               : index == 1
//                               ? Image.asset("assets/images/tobuu_logo.png")
//                               : Image.asset("assets/images/tobuu_logo.png")),
//                     ),
//                     Center(
//                       child: Container(
//
//
//                         padding: EdgeInsets.all(AppConstant.LARGE_SIZE),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//
//                             SizedBox(
//                               height: AppConstant.SMALL_TEXT_SIZE,
//                             ),
//                             Padding(
//                                 padding: EdgeInsets.all(
//                                   AppConstant.APP_NORMAL_PADDING,
//                                 ),
//                                 child: Flex(direction: Axis.vertical, children: [
//                                   Container(
//                                     width: 800,
//                                     child: Obx(() => Html(
//                                         data: settingController.mydata.value
//                                             .toString())),
//                                   ),
//                                 ])),
//                             SizedBox(
//                               height: AppConstant.LARGE_SIZE,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../Utills3/universal.dart';
import '../../../Utills3/utills.dart';
import '../../../appconstants/appconstants.dart';
import '../setting_controller.dart';

class About extends StatefulWidget {
  final int index;
  final String titleName;

  About(this.index, this.titleName);

  @override
  State<About> createState() => _AboutState(index, titleName);
}

class _AboutState extends State<About> {
  final SettingController settingController = Get.find();
  final util = Utills();
  final int index;
  final String titleName;

  _AboutState(this.index, this.titleName);

  @override
  void initState() {
    super.initState();
    if (index == 1) {
      settingController.getaboutus("getPrivacyPolicy");
    } else if (index == 0) {
      settingController.getaboutus("getAboutUs");
    } else {
      settingController.getaboutus("getTermsConditions");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            backToolbar(
              name: titleName,
              get_back: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppConstant.APP_EXTRA_LARGE_PADDING,
                    ),
                    Container(
                      width: 200,
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset("assets/images/tobuu_logo.png"),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(AppConstant.LARGE_SIZE),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: AppConstant.SMALL_TEXT_SIZE,
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                AppConstant.APP_NORMAL_PADDING,
                              ),
                              child: Obx(() => Html(
                                  data: settingController.mydata.value.toString())),
                            ),
                            SizedBox(
                              height: AppConstant.LARGE_SIZE,
                            ),
                          ],
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
    );
  }
}

