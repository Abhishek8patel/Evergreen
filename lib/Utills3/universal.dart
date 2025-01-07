// // import '../../../Utills3/utills.dart';
// import 'dart:convert';
//
// import 'package:testingevergreen/Utills3/utills.dart';
// import 'package:testingevergreen/appconstants/mycolor.dart';
// import 'package:testingevergreen/pages/SE/se_controller.dart';
// import 'package:testingevergreen/pages/SE/se_controller/form_on_controller.dart';
// import 'package:testingevergreen/pages/SE/se_edit_controller/se_edit_fromone_controller.dart';
// import 'package:testingevergreen/pages/SV/svController/sv_form_one_controller.dart';
// import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
// import 'package:testingevergreen/pages/notification/notification.dart';
// import 'package:testingevergreen/pages/profile/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import '../appconstants/appconstants.dart';
// import '../getXNetworkManager.dart';
// import '../pages/myhomepage/myhomepage.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../pages/profile/profile_controller.dart';
//
// class TopToolbar extends StatefulWidget {
//   var current_index = 0;
//   var isLogin = false;
//   var userpic = "";
//
//   TopToolbar(int current_index, bool isLogin, String userpic) {
//     this.current_index = current_index;
//     this.isLogin = isLogin;
//     this.userpic = userpic;
//   }
//
//   @override
//   State<TopToolbar> createState() => _TopToolbarState(this.userpic);
// }
//
// class _TopToolbarState extends State<TopToolbar> {
//   var userpic = "";
//   String? _userName = null;
//
//   _TopToolbarState(String userpic) {
//     this.userpic = userpic;
//   }
//
//   final util = Utills();
//   var mylist = [];
//   TextEditingController _filterController = TextEditingController();
//   String _searchText = "";
//   final _networkManager = Get.find<GetXNetworkManager>();
//   DashboardController _dashboardController = Get.find();
//   ProfileController _profileController = Get.find();
//   ProfileController profile_controller = Get.find();
//   SvFormOneController svFormOneController = Get.find();
//   @override
//   void initState() {
//     super.initState();
//     debugPrint("userpic:" + widget.userpic.toString());
//     //UniServices.init();
//
//     AppConstant.getUserData("user_data").then((value) => {
//           if (value != null)
//             {
//               setState(() {
//                 profileController.fullname.value;
//                 profileController.user_full_name_controller.value;
//                 _userName = value.user_name.toString();
//                 debugPrint("myimg" + value.user_pic.toString());
//               })
//             }
//         });
//   }
//
//   ProfileController profileController = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Row(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(left: 10),
//                 child: Bounceable(
//                   onTap: () {
//                     debugPrint("userimg:${userpic}");
//                     // _networkManager.currentIndex.value = 0;
//                     //
//                     // Get.offAll(() => MyHomePage(0));
//                     //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(0)));
//                     Get.to(() => MyProfile());
//                   },
//                   child: Container(
//                     width: 35,
//                     height: 35,
//                     child: Hero(
//                       tag: "hero_tag",
//                       child: Container(
//                           padding: EdgeInsets.all(2), // Border width
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: Colors.blue, // Border color
//                               width: 2.0, // Border width
//                             ),
//                           ),
//                           child: Obx(
//                             () => ClipOval(
//                               child: SizedBox.fromSize(
//                                 size: Size.fromRadius(16),
//                                 // Adjusted to fit within the outer container
//                                 child:
//                                 // Image.network(
//                                 //             _dashboardController.userpic.value,
//                                 //             fit: BoxFit.cover) ==
//                                 //         null
//                                 //     ? Image.asset(
//                                 //         'assets/images/testimg.png',
//                                 //         fit: BoxFit.cover,
//                                 //         errorBuilder: (c, i, e) {
//                                 //           return Image.asset(
//                                 //               'assets/images/testimg.png');
//                                 //         },
//                                 //       )
//                                 //     : Image.network(
//                                 //         _dashboardController.userpic.value,
//                                 //         fit: BoxFit.cover),
//                                 Image.network(
//                                   profile_controller
//                                       .userPic!
//                                       .value!,
//                                   width: 120,
//                                   height: 120,
//                                   fit: BoxFit.cover,
//                                   errorBuilder:
//                                       (c, i, e) {
//                                     return Image.asset(
//                                         "assets/images/profile_icon.png");
//                                   },
//                                 ),
//                               ),
//                             ),
//                           )),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               Container(
//                 child:
//                     // Obx (
//                     //       ()=>
//
//                     Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'Hello,',
//                         style: GoogleFonts.roboto(
//                           textStyle: Theme.of(context).textTheme.displayLarge,
//                           fontSize: AppConstant.HEADLINE_SIZE_20,
//                           fontWeight: FontWeight.w800,
//                           fontStyle: FontStyle.normal,
//                           color: Colors.black,
//                         ),
//                       ),
//                       TextSpan(
//                         text:
//                           //  "    ${${svFormOneController.svsiteList.value[i].sites[0].reportSubmit?.fullName ?? "Not updated"}"
//                           // .capitalizeFirst! ?? "Not updated"}",
//                             // '${profileController.fullname.value.isNotEmpty ? profileController.fullname.value.capitalizeFirst : "User".capitalizeFirst}',
//                             '${profileController.fullname.value.isNotEmpty ? profileController.fullname.value.capitalizeFirst : "${_dashboardController.userName}".capitalizeFirst}',
//                         // '${(_userName)}',
//                         // '${(_dashboardController.userName)}',
//                         // '${(profileController.user_full_name_controller.value)}',
//                             //.capitalizeFirst ?? "User".capitalizeFirst}',
//                         style: GoogleFonts.roboto(
//                           textStyle: Theme.of(context).textTheme.displayLarge,
//                           fontSize: AppConstant.HEADLINE_SIZE_20,
//                           fontWeight: FontWeight.w800,
//                           fontStyle: FontStyle.normal,
//                           color: Colors.green,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//               //  ),
//             ],
//           ),
//           Visibility(
//             visible: true,
//             child: Container(
//               child: Stack(children: [
//                 Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Color.fromRGBO(0, 0, 0, 0.03)),
//                     width: 40,
//                     height: 40,
//                     child: Container(
//                       width: 26,
//                       height: 26,
//                       padding: EdgeInsets.all(8),
//                       // Border width
//                       decoration: BoxDecoration(shape: BoxShape.circle),
//                       child: ClipOval(
//                         child: SizedBox.fromSize(
//                             size: Size.fromRadius(24),
//                             // Image radius
//                             child: Stack(children: [
//                               ShaderMask(
//                                   shaderCallback: (Rect bounds) {
//                                     return LinearGradient(
//                                       colors: [
//                                         MyColor.NOTI_COLOR1,
//                                         MyColor.NOTI_COLOR2
//                                       ],
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                     ).createShader(bounds);
//                                   },
//                                   child: InkWell(
//                                       onTap: () {
//                                         Get.to(() => MyNotification());
//                                       },
//                                       child: Icon(Icons.notifications,
//                                           color: Colors.white))),
//                               new Positioned(
//                                 // draw a red marble
//                                 top: 1.0,
//                                 right: 2.0,
//                                 child: Obx(() => Visibility(
//                                       visible: true,
//                                       child: Visibility(
//                                         visible: _dashboardController
//                                             .newNotification.value,
//                                         child: new Icon(Icons.brightness_1,
//                                             size: 9.0, color: Colors.redAccent),
//                                       ),
//                                     )),
//                               )
//                             ])),
//                       ),
//                     )),
//               ]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class NjDots extends StatefulWidget {
//   NjDots();
//
//   @override
//   State<NjDots> createState() => _NjDots();
// }
//
// class _NjDots extends State<NjDots> {
//   SEController svcontroller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 100,
//         child: Obx(
//           () => Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 5),
//                 width: 20,
//                 height: 20,
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: svcontroller!.currentIndex.value == 0
//                         ? Colors.red
//                         : Colors.transparent,
//                     border: Border.all(color: Colors.red)),
//               ),
//               Container(
//                 width: 20,
//                 height: 20,
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: svcontroller!.currentIndex.value == 1
//                         ? Colors.red
//                         : Colors.transparent,
//                     border: Border.all(color: Colors.red)),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 5),
//                 width: 20,
//                 height: 20,
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: svcontroller!.currentIndex.value == 2
//                         ? Colors.red
//                         : Colors.transparent,
//                     border: Border.all(color: Colors.red)),
//               )
//             ],
//           ),
//         ));
//   }
// }
//
// class backToolbar extends StatefulWidget {
//   final String? name;
//   final bool? toHomePage;
//   final bool? get_back;
//   final FontWeight? fontWeight;
//   final Color? color;
//   final double? fontSize;
//
//   backToolbar({
//     Key? key,
//     required this.name,
//     this.toHomePage = false,
//     this.get_back = false,
//     this.fontWeight = FontWeight.w700,
//     this.color = Colors.green,
//     this.fontSize = 20.0,
//   }) : super(key: key);
//
//   @override
//   State<backToolbar> createState() => _backToolbarState();
// }
//
// class _backToolbarState extends State<backToolbar> {
//   FormOnController formOnController = Get.find();
//   SvFormOneController svFormOneController = Get.find();
//   SeEditFormOneController seEditFormOneController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.only(top: 10, bottom: 10),
//       child: Stack(
//         children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Bounceable(
//               onTap: () {
//                 if (widget.toHomePage == true) {
//                   Get.offAll(() => MyHomePage(0));
//                   Future.delayed(Duration(milliseconds: 500), () {
//                     clearSeData();
//                     clearSvData();
//                   });
//                 } else if (widget.get_back == true) {
//                   Navigator.of(context).pop();
//                   Future.delayed(Duration(milliseconds: 500), () {
//                     clearSeData();
//                     clearSvData();
//                   });
//                   // Get.back();
//                 } else {
//                   Navigator.of(context).pop();
//                   Future.delayed(Duration(milliseconds: 500), () {
//                     clearSeData();
//                     clearSvData();
//                   });
//                 }
//               },
//               child: Container(
//                 margin: EdgeInsets.only(left: 20),
//                 width: 44,
//                 height: 44,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                 ),
//                 child: Image.asset(
//                   "assets/images/back_btn.png",
//                   scale: 1.0,
//                 ),
//               ),
//             ),
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 10.0, left: 30),
//               child: Text(
//                 "${widget.name ?? "Unknown"}",
//                 style: TextStyle(
//                   fontWeight: widget.fontWeight!,
//                   fontSize: widget.fontSize!,
//                   color: widget.color!,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void clearSeData() async {
//     formOnController.currentPage.value = 0;
//     formOnController.clearSelections();
//     seEditFormOneController.clearSelections();
//     seEditFormOneController.currentPage.value = 0;
//   }
//
//   void clearSvData() {
//     svFormOneController.currentPage.value = 0;
//     svFormOneController.clearSelections();
//     svFormOneController.clearSelections();
//     svFormOneController.currentPage.value = 0;
//   }
// }
//
// class ThanksPage extends StatefulWidget {
//   const ThanksPage({Key? key}) : super(key: key);
//
//   @override
//   State<ThanksPage> createState() => _ThanksPageState();
// }
//
// class _ThanksPageState extends State<ThanksPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Center(
//           child: Container(
//             child: Image.asset("assets/images/nodata.jpg"),
//           ),
//         ),
//         Center(
//           child: Text("${AppConstant.THANKS_MSG}"),
//         ),
//         Padding(
//           padding: EdgeInsets.only(
//               left: AppConstant.LARGE_SIZE,
//               right: AppConstant.LARGE_SIZE,
//               bottom: 25),
//           child: Bounceable(
//             onTap: () {},
//             child: AppConstant.getButton(
//                 AppConstant.getRoboto(FontWeight.w800, 20, Colors.white),
//                 "tank",
//                 AppConstant.BUTTON_WIDTH,
//                 AppConstant.BUTTON_HIGHT),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class BounceableButton extends StatelessWidget {
//   final VoidCallback onTap;
//   final String text;
//   final double width;
//   final double height;
//   final Gradient gradient;
//   final double borderRadius;
//   final double fontSize;
//   final FontWeight fontWeight;
//   final Color textColor;
//
//   const BounceableButton({
//     Key? key,
//     required this.onTap,
//     required this.text,
//     required this.width,
//     required this.height,
//     required this.gradient,
//     required this.borderRadius,
//     required this.fontSize,
//     required this.fontWeight,
//     required this.textColor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Bounceable(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//         onTap();
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: gradient,
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//         margin: const EdgeInsets.all(8.0),
//         width: width,
//         height: height,
//         child: Center(
//           child: Text(
//             text,
//             style: GoogleFonts.roboto(
//               textStyle: Theme.of(context).textTheme.displayLarge,
//               fontSize: fontSize,
//               fontWeight: fontWeight,
//               fontStyle: FontStyle.normal,
//               color: textColor,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:testingevergreen/Utills3/utills.dart';
import 'package:testingevergreen/appconstants/mycolor.dart';
import 'package:testingevergreen/main.dart';
import 'package:testingevergreen/pages/SE/se_controller.dart';
import 'package:testingevergreen/pages/SE/se_controller/form_on_controller.dart';
import 'package:testingevergreen/pages/SE/se_edit_controller/se_edit_fromone_controller.dart';
import 'package:testingevergreen/pages/SV/svController/sv_form_one_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:testingevergreen/pages/notification/notification.dart';
import 'package:testingevergreen/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import '../appconstants/appconstants.dart';
import '../getXNetworkManager.dart';
import '../pages/myhomepage/myhomepage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../pages/profile/profile_controller.dart';

//........................................
import 'package:testingevergreen/pages/profile/edit_image_model.dart'
    as editImgRes;
import 'package:testingevergreen/pages/profile/profile_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Utills3/endpoints.dart';
import '../../Utills3/universal.dart';
import '../../Utills3/utills.dart';
import '../../appconstants/appconstants.dart';
import '../../main.dart';

// import '../dashboard/dahboard_controller.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class TopToolbar extends StatefulWidget {
  var current_index = 0;
  var isLogin = false;
  var userpic = "";

  TopToolbar(int current_index, bool isLogin, String userpic) {
    this.current_index = current_index;
    this.isLogin = isLogin;
    this.userpic = userpic;
  }

  @override
  State<TopToolbar> createState() => _TopToolbarState(this.userpic);
}

class _TopToolbarState extends State<TopToolbar> {
  var userpic = "";
  String? _userName = null;

  _TopToolbarState(String userpic) {
    this.userpic = userpic;
  }

  final util = Utills();
  var mylist = [];
  TextEditingController _filterController = TextEditingController();
  String _searchText = "";
  final _networkManager = Get.find<GetXNetworkManager>();
  DashboardController _dashboardController = Get.find();
  ProfileController _profileController = Get.find();
  ProfileController profile_controller = Get.find();
  SvFormOneController svFormOneController = Get.find();

  @override
  void initState() {
    super.initState();
    debugPrint("userpic:" + widget.userpic.toString());
    //UniServices.init();

    AppConstant.getUserData("user_data").then((value) => {
          if (value != null)
            {
              setState(() {
                profileController.fullname.value;
                profileController.user_full_name_controller.value;
                _userName = value.user_name.toString();
                debugPrint("myimg" + value.user_pic.toString());
              })
            }
        });
  }

  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          FutureBuilder(
            future: fetchUserData(),
            builder: (context, snapshot) {
              // Loading state
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              // Error state
              if (snapshot.hasError || snapshot.data == null) {
                return Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/default_image.png'),
                      ),
                    ),
                    SizedBox(width: 30),
                    Text(
                      "Hello, User",
                      style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: AppConstant.HEADLINE_SIZE_20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              }

              // Data loaded successfully
              final userData = snapshot.data as Map<String, dynamic>;
              final profilePic =
                  userData["pic"] ?? "assets/images/default_image.png";

              Future<Uint8List?> _fetchImage(String profilePic) async {
                try {
                  final response = await http.get(Uri.parse(profilePic));
                  if (response.statusCode == 200) {
                    return response.bodyBytes;
                  } else {
                    throw Exception("Failed to load image");
                  }
                } catch (e) {
                  print("Error fetching image: $e");
                }
                return null;
              }

              return Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Bounceable(
                      onTap: () {
                        debugPrint("User Image URL: $profilePic");
                        Get.to(() => MyProfile());
                      },
                      child:
                      // Container(
                      //   width: 40,
                      //   height: 40,
                      //   child: Hero(
                      //     tag: "hero_tag",
                      //     child: CircleAvatar(
                      //       radius: 15,
                      //       backgroundColor: Colors.green,
                      //       child: ClipOval(
                      //         child: profilePic.startsWith("http")
                      //             ? Image.network(
                      //                 profilePic,
                      //                 fit: BoxFit.cover,
                      //                 width: 35,
                      //                 height: 35,
                      //               )
                      //             : Image.asset(
                      //                 'assets/images/default_image.png',
                      //                 fit: BoxFit.cover,
                      //                 width: 40,
                      //                 height: 40,
                      //               ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      CircleAvatar(
                       // radius: 60,
                        backgroundColor:
                        Colors.transparent,
                        child: ClipOval(
                          child: Container(
                            height: 40,
                            width: 40,
                            child: SizedBox(
                                height: 40,
                                width: 40,
                                child: FutureBuilder(
                                    future: _fetchImage(profilePic),
                                    builder: (context, snapshot) {
                                      return snapshot.data != null ? Image.memory(
                                        snapshot.data!, fit: BoxFit.cover,
                                      ):Center(child: CircularProgressIndicator(),);
                                    }
                                )
                            ),
                          ),
                        ),),
                    ),
                  ),
                  SizedBox(width: 20),
                  // Text.rich(
                  //   TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: 'Hello, ',
                  //         style: GoogleFonts.roboto(
                  //           textStyle: Theme.of(context).textTheme.displayLarge,
                  //           fontSize: AppConstant.HEADLINE_SIZE_20,
                  //           fontWeight: FontWeight.w800,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //       TextSpan(
                  //         text: userData['full_name'] ?? 'User',
                  //         style: GoogleFonts.roboto(
                  //           textStyle: Theme.of(context).textTheme.displayLarge,
                  //           fontSize: AppConstant.HEADLINE_SIZE_20,
                  //           fontWeight: FontWeight.w800,
                  //           color: Colors.green,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  //   overflow: TextOverflow.ellipsis, // Handle text overflow
                  //   maxLines: 1,
                  // ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hello, ',
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: AppConstant.HEADLINE_SIZE_20,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: userData['full_name'] ?? 'User',
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: AppConstant.HEADLINE_SIZE_20,
                            fontWeight: FontWeight.w800,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis, // Handles text overflow
                    maxLines: 1, // Ensures the text is confined to a single line
                  ),

                ],
              );
            },
          ),
          Visibility(
            visible: true,
            child: Container(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(0, 0, 0, 0.03),
                    ),
                    width: 40,
                    height: 40,
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(24),
                        child: Stack(
                          children: [
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    MyColor.NOTI_COLOR1,
                                    MyColor.NOTI_COLOR2
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds);
                              },
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => MyNotification());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.notifications,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 1.0,
                              right: 2.0,
                              child: Obx(
                                () => Visibility(
                                  visible: _dashboardController
                                      .newNotification.value,
                                  child: Icon(
                                    Icons.brightness_1,
                                    size: 9.0,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}

class NjDots extends StatefulWidget {
  NjDots();

  @override
  State<NjDots> createState() => _NjDots();
}

class _NjDots extends State<NjDots> {
  SEController svcontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: svcontroller!.currentIndex.value == 0
                        ? Colors.red
                        : Colors.transparent,
                    border: Border.all(color: Colors.red)),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: svcontroller!.currentIndex.value == 1
                        ? Colors.red
                        : Colors.transparent,
                    border: Border.all(color: Colors.red)),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: svcontroller!.currentIndex.value == 2
                        ? Colors.red
                        : Colors.transparent,
                    border: Border.all(color: Colors.red)),
              )
            ],
          ),
        ));
  }
}

class backToolbar extends StatefulWidget {
  final String? name;
  final bool? toHomePage;
  final bool? get_back;
  final FontWeight? fontWeight;
  final Color? color;
  final double? fontSize;

  backToolbar({
    Key? key,
    required this.name,
    this.toHomePage = false,
    this.get_back = false,
    this.fontWeight = FontWeight.w700,
    this.color = Colors.green,
    this.fontSize = 20.0,
  }) : super(key: key);

  @override
  State<backToolbar> createState() => _backToolbarState();
}

class _backToolbarState extends State<backToolbar> {
  FormOnController formOnController = Get.find();
  SvFormOneController svFormOneController = Get.find();
  SeEditFormOneController seEditFormOneController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Bounceable(
              onTap: () {
                if (widget.toHomePage == true) {
                  Get.offAll(() => MyHomePage(0));
                  Future.delayed(Duration(milliseconds: 500), () {
                    clearSeData();
                    clearSvData();
                  });
                } else if (widget.get_back == true) {
                  Navigator.of(context).pop();
                  Future.delayed(Duration(milliseconds: 500), () {
                    clearSeData();
                    clearSvData();
                  });
                  // Get.back();
                } else {
                  Navigator.of(context).pop();
                  Future.delayed(Duration(milliseconds: 500), () {
                    clearSeData();
                    clearSvData();
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 20),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "assets/images/back_btn.png",
                  scale: 1.0,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 30),
              child: Text(
                "${widget.name ?? "Unknown"}",
                style: TextStyle(
                  fontWeight: widget.fontWeight!,
                  fontSize: widget.fontSize!,
                  color: widget.color!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void clearSeData() async {
    formOnController.currentPage.value = 0;
    formOnController.clearSelections();
    seEditFormOneController.clearSelections();
    seEditFormOneController.currentPage.value = 0;
  }

  void clearSvData() {
    svFormOneController.currentPage.value = 0;
    svFormOneController.clearSelections();
    svFormOneController.clearSelections();
    svFormOneController.currentPage.value = 0;
  }
}

class ThanksPage extends StatefulWidget {
  const ThanksPage({Key? key}) : super(key: key);

  @override
  State<ThanksPage> createState() => _ThanksPageState();
}

class _ThanksPageState extends State<ThanksPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: Container(
            child: Image.asset("assets/images/nodata.jpg"),
          ),
        ),
        Center(
          child: Text("${AppConstant.THANKS_MSG}"),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: AppConstant.LARGE_SIZE,
              right: AppConstant.LARGE_SIZE,
              bottom: 25),
          child: Bounceable(
            onTap: () {},
            child: AppConstant.getButton(
                AppConstant.getRoboto(FontWeight.w800, 20, Colors.white),
                "tank",
                AppConstant.BUTTON_WIDTH,
                AppConstant.BUTTON_HIGHT),
          ),
        ),
      ],
    );
  }
}

class BounceableButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  final double height;
  final Gradient gradient;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;

  const BounceableButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.width,
    required this.height,
    required this.gradient,
    required this.borderRadius,
    required this.fontSize,
    required this.fontWeight,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        FocusScope.of(context).unfocus();
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        margin: const EdgeInsets.all(8.0),
        width: width,
        height: height,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.displayLarge,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: FontStyle.normal,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
// FutureBuilder(
// future: fetchUserData(),
// builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.waiting) {
// // Show a loading indicator while waiting for the future
// return CircularProgressIndicator(color: Colors.green,);
// } else if (snapshot.hasError) {
// // Handle errors gracefully
// return Text(
// "Error loading data",
// style: TextStyle(color: Colors.red),
// );
// } else if (!snapshot.hasData || snapshot.data == null) {
// // Handle null or missing data
// return Text(
// "No user data available",
// style: TextStyle(color: Colors.grey),
// );
// } else {
// // Extract user data from the snapshot
// final userData = snapshot.data as Map<String, dynamic>;
// final profilePic = userData['pic'] ??
// "https://example.com/default_image.png"; // Fallback URL
// final fullName = userData['full_name'] ?? "User";
//
// return Row(
// children: [
// Container(
// margin: EdgeInsets.only(left: 10),
// child: Bounceable(
// onTap: () {
// debugPrint("User image URL: $profilePic");
// Get.to(() => MyProfile());
// },
// child: Container(
// width: 35,
// height: 35,
// child: Hero(
// tag: "hero_tag",
// child: Container(
// padding: EdgeInsets.all(2),
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// border: Border.all(
// color: Colors.blue,
// width: 2.0,
// ),
// ),
// child: ClipOval(
// child: Image.network(
// profilePic,
// fit: BoxFit.cover,
// width: 35,
// height: 35,
// errorBuilder: (context, error, stackTrace) {
// return Image.asset(
// "assets/images/profile_icon.png",
// fit: BoxFit.cover,
// width: 35,
// height: 35,
// );
// },
// ),
// ),
// ),
// ),
// ),
// ),
// ),
// SizedBox(width: 30),
// Container(
// child: Text.rich(
// TextSpan(
// children: [
// TextSpan(
// text: 'Hello, ',
// style: GoogleFonts.roboto(
// textStyle: Theme.of(context).textTheme.bodyLarge,
// fontSize: 20,
// fontWeight: FontWeight.w800,
// color: Colors.black,
// ),
// ),
// TextSpan(
// text: fullName,
// style: GoogleFonts.roboto(
// textStyle: Theme.of(context).textTheme.bodyLarge,
// fontSize: 20,
// fontWeight: FontWeight.w800,
// color: Colors.green,
// ),
// ),
// ],
// ),
// ),
// ),
// ],
// );
// }
// },
// ),
