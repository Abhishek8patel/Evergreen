// import 'dart:io';
// import 'package:testingevergreen/pages/myhomepage/myhomepage.dart';
// import 'package:testingevergreen/pages/profile/edit_image_model.dart'
//     as editImgRes;
// import 'package:testingevergreen/pages/profile/profile_controller.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../Utills3/endpoints.dart';
// import '../../Utills3/universal.dart';
// import '../../Utills3/utills.dart';
// import '../../appconstants/appconstants.dart';
// import '../../appconstants/mycolor.dart';
// import '../dashboard/dahboard_controller.dart';
// import '../settings/settings.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';
//
// class MyProfile extends StatefulWidget {
//   bool? isLogin = false;
//
//   MyProfile([this.isLogin = false]);
//
//   @override
//   State<MyProfile> createState() => _MyProfile();
// }
//
// class _MyProfile extends State<MyProfile> with SingleTickerProviderStateMixin {
//   _MyProfile() {}
//
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   ProfileController profile_controller = Get.find();
//
//   DashboardController _dashboardController = Get.find();
//   final pageBucket = PageStorageBucket();
//   File? fimage1 = null;
//   File? _image;
//   final util = Utills();
//   var f_sel = "Video";
//   var video_data = true;
//   var isMyProfile = false;
//   var isLogin = false;
//   bool isLiked = true;
//   int likeCount = 10;
//   var user_data = [];
//   var userid = "";
//   var token = "";
//   var userpic = "";
//   ImagePicker picker = ImagePicker();
//   String netwokIMg = "";
//   final PageController listcontroller = PageController();
//   final PageController reellistcontroller = PageController();
//   final PageController timelinelistcontroller = PageController();
//   DashboardController dashboardController = Get.find();
//   choose_image(ImageSource source, String uid) async {
//     final pickedFile = await picker.pickImage(source: source);
//     if (pickedFile != null) {
//       final file = File(pickedFile.path);
//       setState(() async {
//         _image = File(pickedFile.path);
//         fimage1 = File(pickedFile.path);
//         setState(() {
//           _image = File(pickedFile.path);
//           fimage1 = File(pickedFile.path);
//         });
//         _uploadImage(token).then((value) => {
//               if (value != null)
//                 {
//                   setState(() {
//                     debugPrint("imggot" +
//                         "${AppConstant.BASE_URL}/${value.profilePic}");
//                     profile_controller.userPic!.value =
//                         "${AppConstant.BASE_URL}/${value.profilePic}";
//                   }),
//                 }
//             });
//       });
//     }
//   }
//
//   Future<XFile?> compressImage(File file) async {
//     final dir = await getTemporaryDirectory();
//     final targetPath = path.join(dir.absolute.path, "temp.jpg");
//
//     var result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       targetPath,
//       quality: 50, // Adjust quality as needed
//     );
//
//     return result!;
//   }
//
//   Future<editImgRes.EditImgDto?> _uploadImage(String token) async {
//     if (_image == null) {
//       util.showSnackBar("Alert", "No image selected", false);
//       return null;
//     }
//     XFile compressedImage;
//     try {
//       compressedImage = (await compressImage(_image!))!;
//     } catch (e) {
//       util.showSnackBar("Alert", "Image compression failed", false);
//       return null;
//     }
//
//     // util.showSnackBar("Alert", "${token}", true);
//     print('Image upload token: ${token}');
//     final uri =
//         Uri.parse('${AppConstant.BASE_URL}${AppEndPoints.edit_image_upload}');
//     final request = http.MultipartRequest('POST', uri)
//       ..headers['Authorization'] = 'Bearer $token'
//       ..files.add(
//           await http.MultipartFile.fromPath('file', compressedImage!.path));
//
//     final response = await request.send();
//
//     debugPrint('njres:"called}');
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       // Decode the response into a JSON object
//       debugPrint('njres:"200}');
//       final jsonResponse = await response.stream.bytesToString();
//
//       debugPrint('Parsed response nj: $jsonResponse');
//
//       var temp = editImgRes.editImgDtoFromJson(jsonResponse);
//       if (temp.message.isNotEmpty) {
//         util.showSnackBar("Alert", temp.message, true);
//         return temp;
//       }
//
//       return temp;
//     } else {
//       debugPrint('njres:"failed${response.statusCode}}');
//       debugPrint('njres:"failed${response.statusCode}}');
//       util.showSnackBar("Alert", "Someting went wrong!", false);
//       print('Image upload failed: ${response.statusCode}');
//       return null;
//     }
//   }
//
//   Dialog selectImage(BuildContext context) {
//     return Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0)), //this right here
//         child: Container(
//           height: 200.0,
//           width: 200.0,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Select',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Please select image from:',
//                   style: TextStyle(color: Colors.black, fontSize: 14),
//                 ),
//               ),
//               Padding(padding: EdgeInsets.only(top: 20.0)),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MaterialButton(
//                         onPressed: () async {
//                           Navigator.of(context).pop();
//
//                           if (_dashboardController.uid.value.isNotEmpty) {
//                             choose_image(ImageSource.camera,
//                                 _dashboardController.uid.value);
//                           } else {
//                             util.showSnackBar(
//                                 "Alert", "Couldn't fetch user id", false);
//                           }
//                         },
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: Text("CAMERA"),
//                         color: Colors.green,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       MaterialButton(
//                         onPressed: () {
//                           Get.back();
//                           if (_dashboardController.uid.value.isNotEmpty) {
//                             choose_image(ImageSource.gallery,
//                                 _dashboardController.uid.value);
//                           } else {
//                             util.showSnackBar(
//                                 "Alert", "Couldn't fetch user id", false);
//                           }
//                         },
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: Text("GALLERY"),
//                         color: Colors.green,
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ));
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fimage1 = null;
//     AppConstant.getUserData("user_data").then((value) => {
//           if (value != null)
//             {
//               debugPrint("profile:user is not null"),
//               setState(() {
//                 token = value.user_token;
//               }),
//               profile_controller.isLoading.value = true,
//               profile_controller
//                   .getProfile(value.user_token)
//                   .then((newvalue) => {
//                         debugPrint("profile:data is not null"),
//                         if (newvalue != null) debugPrint("profile:called"),
//                         debugPrint("profile:called${newvalue!.user.pic}"),
//                         profile_controller.userPic!.value = newvalue!.user.pic,
//                         profile_controller.userPic!.refresh(),
//                         setState(() {
//                           netwokIMg = newvalue!.user.pic;
//                         }),
//
//                         //loadImage();
//                         profile_controller.isLoading.value = false,
//                       }),
//             }
//           else
//             {
//               debugPrint("profile:user is null"),
//               debugPrint("data is null"),
//             }
//         });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//
//     profile_controller.user_full_name_controller.text = "";
//     profile_controller.user_address_controller.text = "";
//     profile_controller.user_mobile_controller.text = "";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: GestureDetector(
//       onTap: () {
//         FocusManager.instance.primaryFocus!.unfocus();
//       },
//       behavior: HitTestBehavior.opaque,
//       child: RefreshIndicator(
//         onRefresh: () {
//           return Future(() => null);
//         },
//         child: PageStorage(
//           bucket: pageBucket,
//           child: SafeArea(
//               child: Obx(
//             () => profile_controller.isLoading.value == true
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : Column(
//                     children: [
//                       backToolbar(
//                         name: "My Profile",
//                         get_back: true,
//                       ),
//                       Obx(() => profile_controller.isLoading.value == true
//                           ? Center(
//                               child: CircularProgressIndicator(),
//                             )
//                           : Expanded(
//                               child: SingleChildScrollView(
//                                 child: SingleChildScrollView(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       //name
//                                       //first name
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Stack(
//                                             children: [
//                                               InkWell(
//                                                 onTap: () {},
//                                                 child: Container(
//                                                   padding: EdgeInsets.all(3),
//                                                   // Adjust padding to control border thickness
//                                                   decoration: BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     border: Border.all(
//                                                       color: Colors.green,
//                                                       width: 3.0,
//                                                     ),
//                                                   ),
//                                                   child: CircleAvatar(
//                                                       radius: 60,
//                                                       child: Obx(
//                                                         () => InkWell(
//                                                             onTap: () {},
//                                                             child: ClipOval(
//                                                               child:
//                                                                   Image.network(
//                                                                 profile_controller
//                                                                     .userPic!
//                                                                     .value!,
//                                                                 width: 120,
//                                                                 height: 120,
//                                                                 fit: BoxFit.cover,
//                                                                 errorBuilder:
//                                                                     (c, i, e) {
//                                                                   return Image.asset(
//                                                                       "assets/images/profile_icon.png");
//                                                                 },
//                                                               ),
//                                                             )),
//                                                       )),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top: 1,
//                                                 right: 1,
//                                                 child: Container(
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(2.0),
//                                                     child: InkWell(
//                                                       onTap: () {
//                                                         showDialog(
//                                                             context: context,
//                                                             builder: (BuildContext
//                                                                     context) =>
//                                                                 selectImage(
//                                                                     context));
//                                                       },
//                                                       child: Visibility(
//                                                         visible: true,
//                                                         child: Icon(
//                                                           Icons
//                                                               .photo_camera_outlined,
//                                                           color: Colors.black,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                       width: 1,
//                                                       color: Colors.white,
//                                                     ),
//                                                     borderRadius:
//                                                         BorderRadius.all(
//                                                       Radius.circular(60),
//                                                     ),
//                                                     color: Colors.white,
//                                                     boxShadow: [
//                                                       BoxShadow(
//                                                         offset: Offset(2, 4),
//                                                         color: Colors.black
//                                                             .withOpacity(0.3),
//                                                         blurRadius: 3,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               // Badge for user role
//                                               Positioned(
//                                                 bottom: 1,
//                                                 right: 1,
//                                                 left: 1,
//                                                 child: Container(
//                                                     padding: EdgeInsets.all(1),
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.green,
//                                                       // Background color of the badge
//                                                       shape: BoxShape.rectangle,
//                                                     ),
//                                                     child: Obx(
//                                                       () => Center(
//                                                         child: Text(
//                                                           '${dashboardController.user_role.value.toString().capitalizeFirst ?? "No role found"}',
//                                                           // Change this text to the appropriate user role
//                                                           style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 12,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     )),
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             left:
//                                                 AppConstant.APP_NORMAL_PADDING_34,
//                                             right:
//                                                 AppConstant.APP_NORMAL_PADDING_34,
//                                             top: AppConstant
//                                                 .APP_NORMAL_PADDING_26),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(
//                                                   AppConstant.APP_NORMAL_PADDING),
//                                               border: Border.all(
//                                                   color: Colors.green,
//                                                   width: 1.0)),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Container(
//                                                   height: 45,
//                                                   child: Center(
//                                                       child: TextFormField(
//                                                     controller: profile_controller
//                                                         .user_full_name_controller,
//                                                     textAlign: TextAlign.center,
//                                                     onTap: () {
//                                                       setState(() {});
//                                                     },
//                                                     decoration: InputDecoration(
//                                                       hintStyle: AppConstant
//                                                           .edit_txt_hint(),
//                                                       border: InputBorder.none,
//                                                       hintText: "Full Name",
//                                                     ),
//                                                     keyboardType:
//                                                         TextInputType.text,
//                                                   )),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       //last name
//
//                                       //email
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             left:
//                                                 AppConstant.APP_NORMAL_PADDING_34,
//                                             right:
//                                                 AppConstant.APP_NORMAL_PADDING_34,
//                                             top: AppConstant
//                                                 .APP_NORMAL_PADDING_26),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(
//                                                   AppConstant.APP_NORMAL_PADDING),
//                                               border: Border.all(
//                                                   color: Colors.green,
//                                                   width: 1.0)),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Container(
//                                                   height: 45,
//                                                   child: Center(
//                                                       child: TextFormField(
//                                                     controller: profile_controller
//                                                         .user_email_controller,
//                                                     textAlign: TextAlign.center,
//                                                     onTap: () {
//                                                       setState(() {});
//                                                     },
//                                                     inputFormatters: [
//                                                       new LengthLimitingTextInputFormatter(
//                                                           10),
//                                                     ],
//                                                     enabled: false,
//                                                     decoration: InputDecoration(
//                                                       hintStyle: AppConstant
//                                                           .edit_txt_hint(),
//                                                       border: InputBorder.none,
//                                                       hintText: "Email",
//                                                     ),
//                                                     keyboardType: TextInputType
//                                                         .visiblePassword,
//                                                   )),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       //mobile
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             left:
//                                                 AppConstant.APP_NORMAL_PADDING_34,
//                                             right:
//                                                 AppConstant.APP_NORMAL_PADDING_34,
//                                             top: AppConstant
//                                                 .APP_NORMAL_PADDING_26),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(
//                                                   AppConstant.APP_NORMAL_PADDING),
//                                               border: Border.all(
//                                                   color: Colors.green,
//                                                   width: 1.0)),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Container(
//                                                   height: 45,
//                                                   child: Center(
//                                                       child: TextFormField(
//                                                     controller: profile_controller
//                                                         .user_mobile_controller,
//                                                     textAlign: TextAlign.center,
//                                                     onTap: () {
//                                                       setState(() {});
//                                                     },
//                                                     inputFormatters: [
//                                                       new LengthLimitingTextInputFormatter(
//                                                           10),
//                                                     ],
//                                                     enabled: false,
//                                                     decoration: InputDecoration(
//                                                       hintStyle: AppConstant
//                                                           .edit_txt_hint(),
//                                                       border: InputBorder.none,
//                                                       hintText: "Mobile",
//                                                     ),
//                                                     keyboardType: TextInputType
//                                                         .visiblePassword,
//                                                   )),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       //addresss
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             left:
//                                                 AppConstant.APP_NORMAL_PADDING_34,
//                                             right:
//                                                 AppConstant.APP_NORMAL_PADDING_34,
//                                             top: AppConstant
//                                                 .APP_NORMAL_PADDING_26),
//                                         child: Container(
//                                           height: 200,
//                                           decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(
//                                                   AppConstant.APP_NORMAL_PADDING),
//                                               border: Border.all(
//                                                   color: Colors.green,
//                                                   width: 1.0)),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Container(
//                                                   height: 45,
//                                                   child: Center(
//                                                       child: TextFormField(
//                                                     textAlign: TextAlign.center,
//                                                     onTap: () {},
//                                                     controller: profile_controller
//                                                         .user_address_controller,
//                                                     decoration: InputDecoration(
//                                                       hintStyle: AppConstant
//                                                           .edit_txt_hint(),
//                                                       border: InputBorder.none,
//                                                       hintText: "Address",
//                                                     ),
//                                                     keyboardType:
//                                                         TextInputType.text,
//                                                   )),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//
//                                       // Padding(
//                                       //   padding: EdgeInsets.only(
//                                       //       left: AppConstant.APP_NORMAL_PADDING_34,
//                                       //       right: AppConstant.APP_NORMAL_PADDING_34,
//                                       //       top: AppConstant.APP_NORMAL_PADDING_26),
//                                       //   child: Center(
//                                       //     child: Container(
//                                       //       alignment: Alignment.center,
//                                       //       height: 60,
//                                       //       decoration: BoxDecoration(
//                                       //         border: Border.all(
//                                       //             color: MyColor.OUTLINE_COLOR_POST, width: 1),
//                                       //         borderRadius: BorderRadius.circular(10),
//                                       //       ),
//                                       //       child: DropdownButtonFormField<String>(
//                                       //         autofocus: true,
//                                       //         isDense: true,
//                                       //         isExpanded: true,
//                                       //         decoration: new InputDecoration.collapsed(
//                                       //             fillColor: Colors.white,
//                                       //             filled: true,
//                                       //             hintText: "",
//                                       //             hintStyle: TextStyle(
//                                       //                 fontWeight: FontWeight.w600, fontSize: 12)),
//                                       //         hint: Align(
//                                       //             alignment: Alignment.center,
//                                       //             child: Text("Select Category*",
//                                       //                 style: TextStyle(fontSize: 20))),
//                                       //         items: categories_data,
//                                       //         onChanged: (String? value) {
//                                       //           setState(() {
//                                       //             selected_category = value!;
//                                       //             //  util.showSnackBar("alert", value.toString(), true);
//                                       //             // postController.category_id=postController.category_id;
//                                       //             _dashboardController.getAllCategoryies().then(
//                                       //                 (category) => {
//                                       //
//                                       //                     });
//                                       //             // postController.getCategoryIdByName(value).then((value) => {
//                                       //             //   util.showSnackBar("Alert", value!.id,true),
//                                       //             //   selected_category=value!.id,
//                                       //             //
//                                       //             // });
//                                       //           });
//                                       //         },
//                                       //       ),
//                                       //     ),
//                                       //   ),
//                                       // ),
//
//                                       //submit
//                                       Visibility(
//                                           visible: false,
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 top: AppConstant
//                                                     .APP_NORMAL_PADDING,
//                                                 left: AppConstant.LARGE_SIZE,
//                                                 right: AppConstant.LARGE_SIZE,
//                                                 bottom:
//                                                     AppConstant.SMALL_TEXT_SIZE),
//                                             child: Bounceable(
//                                               onTap: () {},
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   gradient:
//                                                       AppConstant.BUTTON_COLOR,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                 ),
//                                                 margin:
//                                                     const EdgeInsets.all(8.00),
//                                                 width: AppConstant.BUTTON_WIDTH,
//                                                 height: AppConstant.BUTTON_HIGHT,
//                                                 child: Center(
//                                                   child:
//                                                   Text(AppConstant.SUBMIT,
//                                                       style: GoogleFonts
//                                                           .imFellEnglish(
//                                                               textStyle: Theme.of(
//                                                                       context)
//                                                                   .textTheme
//                                                                   .displayLarge,
//                                                               fontSize: AppConstant
//                                                                   .HEADLINE_SIZE_20,
//                                                               fontWeight:
//                                                                   FontWeight.w400,
//                                                               fontStyle: FontStyle
//                                                                   .normal,
//                                                               color:
//                                                                   Colors.white)),
//                                                 ),
//                                               ),
//                                             ),
//                                           )),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ))
//                     ],
//                   ),
//           )),
//         ),
//       ),
//     ));
//   }
// }
// import 'dart:io';
// import 'package:testingevergreen/Testing.dart';
// import 'package:testingevergreen/pages/profile/edit_image_model.dart'
//     as editImgRes;
// import 'package:testingevergreen/pages/profile/profile_controller.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../Utills3/endpoints.dart';
// import '../../Utills3/universal.dart';
// import '../../Utills3/utills.dart';
// import '../../appconstants/appconstants.dart';
// import '../../main.dart';
// import '../dashboard/dahboard_controller.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';
//
// class MyProfile extends StatefulWidget {
//   bool? isLogin = false;
//
//   MyProfile([this.isLogin = false]);
//
//   @override
//   State<MyProfile> createState() => _MyProfile();
// }
//
// class _MyProfile extends State<MyProfile> with SingleTickerProviderStateMixin {
//   _MyProfile();
//
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   ProfileController profile_controller = Get.find();
//   DashboardController _dashboardController = Get.find();
//
//   final pageBucket = PageStorageBucket();
//   File? fimage1 = null;
//   File? _image;
//   final util = Utills();
//   var f_sel = "Video";
//   var video_data = true;
//   var isMyProfile = false;
//   var isLogin = false;
//   bool isLiked = true;
//   int likeCount = 10;
//   var user_data = [];
//   var userid = "";
//   var token = "";
//   var userpic = "";
//   ImagePicker picker = ImagePicker();
//   String netwokIMg = "";
//   final PageController listcontroller = PageController();
//   final PageController reellistcontroller = PageController();
//   final PageController timelinelistcontroller = PageController();
//   DashboardController dashboardController = Get.find();
//
//   // RxBool isUploading = false.obs;
//
//   choose_image(ImageSource source, String uid) async {
//     final pickedFile = await picker.pickImage(source: source);
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//         fimage1 = File(pickedFile.path);
//       });
//
//       // Show progress indicator during upload
//       profile_controller.isUploading.value = true;
//
//       try {
//         var result = await _uploadImage(token);
//         if (result != null) {
//           profile_controller.userPic!.value =
//               "${AppConstant.BASE_URL}/${result.profilePic}";
//           profile_controller.userPic!.refresh();
//           util.showSnackBar("Success", "Profile photo updated!", true);
//         }
//       } catch (e) {
//         util.showSnackBar("Error", "Image upload failed", false);
//       } finally {
//         // Hide progress indicator after upload
//         profile_controller.isUploading.value = false;
//       }
//     } else {
//       util.showSnackBar("Alert", "No image selected", false);
//     }
//   }
//
//   Future<XFile?> compressImage(File file) async {
//     final dir = await getTemporaryDirectory();
//     final targetPath = path.join(dir.absolute.path, "temp.jpg");
//
//     var result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       targetPath,
//       quality: 50,
//     );
//
//     return result!;
//   }
//
//   Future<editImgRes.EditImgDto?> _uploadImage(String token) async {
//     if (_image == null) {
//       util.showSnackBar("Alert", "No image selected", false);
//       return null;
//     }
//
//     XFile compressedImage;
//     try {
//       compressedImage = (await compressImage(_image!))!;
//     } catch (e) {
//       util.showSnackBar("Alert", "Image compression failed", false);
//       return null;
//     }
//
//     final uri =
//         Uri.parse('${AppConstant.BASE_URL}${AppEndPoints.edit_image_upload}');
//     final request = http.MultipartRequest('POST', uri)
//       ..headers['Authorization'] = 'Bearer $token'
//       ..files
//           .add(await http.MultipartFile.fromPath('file', compressedImage.path));
//
//     try {
//       final response = await request.send();
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final jsonResponse = await response.stream.bytesToString();
//         var temp = editImgRes.editImgDtoFromJson(jsonResponse);
//
//         if (temp.message.isNotEmpty) {
//           return temp;
//         }
//       } else {
//         util.showSnackBar("Error", "Image upload failed", false);
//       }
//     } catch (e) {
//       util.showSnackBar("Error", "Something went wrong!", false);
//     }
//     return null;
//   }
//   Future<Uint8List?> _fetchImage(String profilePic) async {
//     try {
//       final response = await http.get(Uri.parse(profilePic));
//       if (response.statusCode == 200) {
//
//           return response.bodyBytes;
//
//       } else {
//         throw Exception("Failed to load image");
//       }
//     } catch (e) {
//       print("Error fetching image: $e");
//     }return null;
//   }
//   Dialog selectImage(BuildContext context) {
//     return Dialog(
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//         child: Container(
//           height: 200.0,
//           width: 200.0,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Select',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Please select image from:',
//                   style: TextStyle(color: Colors.black, fontSize: 14),
//                 ),
//               ),
//               Padding(padding: EdgeInsets.only(top: 20.0)),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MaterialButton(
//                         onPressed: () async {
//                           Navigator.of(context).pop();
//                           if (_dashboardController.uid.value.isNotEmpty) {
//                             choose_image(ImageSource.camera,
//                                 _dashboardController.uid.value);
//                           } else {
//                             util.showSnackBar(
//                                 "Alert", "Couldn't fetch user id", false);
//                           }
//                         },
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: Text("CAMERA"),
//                         color: Colors.green,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       MaterialButton(
//                         onPressed: () {
//                           Get.back();
//                           if (_dashboardController.uid.value.isNotEmpty) {
//                             choose_image(ImageSource.gallery,
//                                 _dashboardController.uid.value);
//                           } else {
//                             util.showSnackBar(
//                                 "Alert", "Couldn't fetch user id", false);
//                           }
//                         },
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: Text("GALLERY"),
//                         color: Colors.green,
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ));
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fimage1 = null;
//
//     AppConstant.getUserData("user_data").then((value) {
//       if (value != null) {
//         setState(() {
//           token = value.user_token;
//         });
//         profile_controller.isLoading.value = true;
//         profile_controller.getProfile(value.user_token).then((newvalue) {
//           if (newvalue != null) {
//             profile_controller.userPic!.value = newvalue!.user.pic;
//             profile_controller.userPic!.refresh();
//             setState(() {
//               netwokIMg = newvalue!.user.pic;
//             });
//             profile_controller.isLoading.value = false;
//           }
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     profile_controller.user_full_name_controller.text = "";
//     profile_controller.user_address_controller.text = "";
//     profile_controller.user_mobile_controller.text = "";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: GestureDetector(
//       onTap: () {
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       behavior: HitTestBehavior.opaque,
//       child: RefreshIndicator(
//         onRefresh: () {
//           return Future(() => null);
//         },
//         child: PageStorage(
//           bucket: pageBucket,
//           child: SafeArea(
//               child: Obx(
//             () => profile_controller.isLoading.value
//                 ? const Center(child: CircularProgressIndicator())
//                 : Column(
//                     children: [
//                       backToolbar(
//                         name: "My Profile",
//                         get_back: true,
//                       ),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               FutureBuilder(
//                                 future: fetchUserData(),
//                                 builder: (context, snapshot) {
//
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.waiting) {
//                                     return const Center(
//                                         child: CircularProgressIndicator(
//                                           color: Colors.green,
//                                         ));
//                                   } else if (snapshot.hasError) {
//                                     return const Center(
//                                       child: Text(
//                                         "Error loading profile data",
//                                         style: TextStyle(color: Colors.red),
//                                       ),
//                                     );
//                                   } else if (!snapshot.hasData ||
//                                       snapshot.data == null) {
//                                     return const Center(
//                                       child: Text(
//                                         "No profile data available",
//                                         style: TextStyle(color: Colors.grey),
//                                       ),
//                                     );
//                                   } else {
//                                     final userData =
//                                         snapshot.data as Map<String, dynamic>;
//                                     final profilePic = userData["pic"] ??
//                                         "assets/images/profile_icon.png";
//
//                                     print("ishwar:logger: ${profilePic}");
//
//                                     return Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Stack(
//                                           children: [
//                                             Container(
//                                               padding: EdgeInsets.all(3),
//                                               decoration: BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                                 border: Border.all(
//                                                     color: Colors.green,
//                                                     width: 3.0),
//                                               ),
//                                               child:
//                                               SizedBox(
//                                                 height: 140,
//                                                 width: 140,
//                                                 child:
//                                                 // Image.network(
//                                                 //   "$profilePic?timestamp=${DateTime.now().millisecondsSinceEpoch}",
//                                                 //   key: UniqueKey(),
//                                                 //   headers: {
//                                                 //     "Cache-Control": "no-cache, no-store, must-revalidate",
//                                                 //     "Pragma": "no-cache",
//                                                 //     "Expires": "0",
//                                                 //   },
//                                                 //   loadingBuilder: (context, child, loadingProgress) {
//                                                 //     if (loadingProgress == null) {
//                                                 //       return child; // Show image when loading is done
//                                                 //     } else {
//                                                 //       return Center(
//                                                 //         child: CircularProgressIndicator(
//                                                 //           value: loadingProgress.expectedTotalBytes != null
//                                                 //               ? loadingProgress.cumulativeBytesLoaded /
//                                                 //               (loadingProgress.expectedTotalBytes ?? 1)
//                                                 //               : null,
//                                                 //         ),
//                                                 //       );
//                                                 //     }
//                                                 //   },
//                                                 //   errorBuilder: (context, error, stackTrace) {
//                                                 //     return Image.asset(
//                                                 //       "assets/images/profile_icon.png", // Fallback image
//                                                 //       width: 120,
//                                                 //       height: 120,
//                                                 //       fit: BoxFit.cover,
//                                                 //     );
//                                                 //   },
//                                                 // )
//                                                FutureBuilder(
//                                                   future: _fetchImage(profilePic),
//                                                   builder: (context, snapshot) {
//                                                     return snapshot.data != null ? Image.memory(
//                                                    snapshot.data!
//
//
//                                                     ):Center(child: CircularProgressIndicator(),);
//                                                   }
//                                                 )
//
//                                               ),
//                                               // child: CircleAvatar(
//                                               //   radius: 60,
//                                               //   backgroundColor:
//                                               //       Colors.transparent,
//                                               //   child: ClipOval(
//                                               //     child: Image.network(
//                                               //       profilePic,
//                                               //       width: 120,
//                                               //       height: 120,
//                                               //       fit: BoxFit.cover,
//                                               //       errorBuilder: (context,
//                                               //           error, stackTrace) {
//                                               //
//                                               //         print("ishwar:logger: error $error");
//                                               //
//                                               //         return Image.asset(
//                                               //           "assets/images/profile_icon.png",
//                                               //           width: 120,
//                                               //           height: 120,
//                                               //           fit: BoxFit.cover,
//                                               //         );
//                                               //       },
//                                               //     ),
//                                               //   ),
//                                               // ),
//                                             ),
//                                             Positioned(
//                                               top: 1,
//                                               right: 1,
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       width: 1,
//                                                       color: Colors.white),
//                                                   borderRadius:
//                                                       BorderRadius.circular(60),
//                                                   color: Colors.white,
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                       offset: Offset(2, 4),
//                                                       color: Colors.black
//                                                           .withOpacity(0.3),
//                                                       blurRadius: 3,
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: InkWell(
//                                                     onTap: () {
//                                                       showDialog(
//                                                         context: context,
//                                                         builder: (BuildContext
//                                                                 context) =>
//                                                             selectImage(
//                                                                 context),
//                                                       );
//                                                     },
//                                                     child: Icon(
//                                                       Icons
//                                                           .photo_camera_outlined,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//
//                                             Positioned(
//                                               child: Container(color: Colors.red, child: Text("${profilePic.toString().split('/').last}", style: TextStyle(color: Colors.white),)),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     );
//                                   }
//                                 },
//                               ),
//                               SizedBox(
//                                 height: 15,
//                               ),
//                               Column(
//                                 children: [
//                                   // Full Name
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal:
//                                           AppConstant.APP_NORMAL_PADDING_34,
//                                       vertical: 8.0, // Reduced vertical padding
//                                     ),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(
//                                             AppConstant.APP_NORMAL_PADDING),
//                                         border: Border.all(
//                                             color: Colors.green, width: 1.0),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: TextFormField(
//                                           controller: profile_controller
//                                               .user_full_name_controller,
//                                           textAlign: TextAlign.center,
//                                           onTap: () {
//                                             setState(() {});
//                                           },
//                                           decoration: InputDecoration(
//                                             hintStyle:
//                                                 AppConstant.edit_txt_hint(),
//                                             border: InputBorder.none,
//                                             hintText: "Full Name",
//                                           ),
//                                           keyboardType: TextInputType.text,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   // Email
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal:
//                                           AppConstant.APP_NORMAL_PADDING_34,
//                                       vertical: 8.0, // Reduced vertical padding
//                                     ),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(
//                                             AppConstant.APP_NORMAL_PADDING),
//                                         border: Border.all(
//                                             color: Colors.green, width: 1.0),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: TextFormField(
//                                           controller: profile_controller
//                                               .user_email_controller,
//                                           textAlign: TextAlign.center,
//                                           onTap: () {
//                                             setState(() {});
//                                           },
//                                           inputFormatters: [
//                                             LengthLimitingTextInputFormatter(10)
//                                           ],
//                                           enabled: false,
//                                           decoration: InputDecoration(
//                                             hintStyle:
//                                                 AppConstant.edit_txt_hint(),
//                                             border: InputBorder.none,
//                                             hintText: "Email",
//                                           ),
//                                           keyboardType:
//                                               TextInputType.visiblePassword,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   // Mobile
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal:
//                                           AppConstant.APP_NORMAL_PADDING_34,
//                                       vertical: 8.0, // Reduced vertical padding
//                                     ),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(
//                                             AppConstant.APP_NORMAL_PADDING),
//                                         border: Border.all(
//                                             color: Colors.green, width: 1.0),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: TextFormField(
//                                           controller: profile_controller
//                                               .user_mobile_controller,
//                                           textAlign: TextAlign.center,
//                                           onTap: () {
//                                             setState(() {});
//                                           },
//                                           inputFormatters: [
//                                             LengthLimitingTextInputFormatter(10)
//                                           ],
//                                           enabled: false,
//                                           decoration: InputDecoration(
//                                             hintStyle:
//                                                 AppConstant.edit_txt_hint(),
//                                             border: InputBorder.none,
//                                             hintText: "Mobile",
//                                           ),
//                                           keyboardType:
//                                               TextInputType.visiblePassword,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   // Address
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal:
//                                           AppConstant.APP_NORMAL_PADDING_34,
//                                       vertical: 8.0, // Reduced vertical padding
//                                     ),
//                                     child: Container(
//                                       height: 200,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(
//                                             AppConstant.APP_NORMAL_PADDING),
//                                         border: Border.all(
//                                             color: Colors.green, width: 1.0),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: TextFormField(
//                                           controller: profile_controller
//                                               .user_address_controller,
//                                           textAlign: TextAlign.center,
//                                           onTap: () {},
//                                           decoration: InputDecoration(
//                                             hintStyle:
//                                                 AppConstant.edit_txt_hint(),
//                                             border: InputBorder.none,
//                                             hintText: "Address",
//                                           ),
//                                           keyboardType: TextInputType.text,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   // Submit Button
//                                   Container(
//                                     child: Visibility(
//                                       visible: true,
//                                       // Set to true to show the button
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             top: AppConstant.APP_NORMAL_PADDING,
//                                             left: AppConstant.LARGE_SIZE,
//                                             right: AppConstant.LARGE_SIZE,
//                                             bottom:
//                                                 AppConstant.SMALL_TEXT_SIZE),
//                                         child: Bounceable(
//                                           onTap: () {
//                                             // Submit button action
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         Testing()));
//                                             print("Submit button tapped");
//                                             // You can perform any action here, such as form validation or data submission
//                                           },
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color: Colors.black,
//                                               gradient:
//                                                   AppConstant.BUTTON_COLOR,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                             ),
//                                             margin: const EdgeInsets.all(8.0),
//                                             width: AppConstant.BUTTON_WIDTH,
//                                             height: AppConstant.BUTTON_HIGHT,
//                                             child: Center(
//                                               child: Text(
//                                                 AppConstant.SUBMIT,
//                                                 style:
//                                                     GoogleFonts.imFellEnglish(
//                                                   textStyle: Theme.of(context)
//                                                       .textTheme
//                                                       .displayLarge,
//                                                   fontSize: AppConstant
//                                                       .HEADLINE_SIZE_20,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontStyle: FontStyle.normal,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//           )),
//         ),
//       ),
//     ));
//   }
// }

import 'dart:io';
import 'package:testingevergreen/Testing.dart';
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
import '../dashboard/dahboard_controller.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class MyProfile extends StatefulWidget {
  bool? isLogin = false;

  MyProfile([this.isLogin = false]);

  @override
  State<MyProfile> createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile> with SingleTickerProviderStateMixin {
  _MyProfile();

  late AnimationController _controller;
  late Animation<double> _animation;

  ProfileController profile_controller = Get.find();
  DashboardController _dashboardController = Get.find();

  final pageBucket = PageStorageBucket();
  File? fimage1 = null;
  File? _image;
  final util = Utills();
  var f_sel = "Video";
  var video_data = true;
  var isMyProfile = false;
  var isLogin = false;
  bool isLiked = true;
  int likeCount = 10;
  var user_data = [];
  var userid = "";
  var token = "";
  var userpic = "";
  ImagePicker picker = ImagePicker();
  String netwokIMg = "";
  final PageController listcontroller = PageController();
  final PageController reellistcontroller = PageController();
  final PageController timelinelistcontroller = PageController();
  DashboardController dashboardController = Get.find();

  // RxBool isUploading = false.obs;

  choose_image(ImageSource source, String uid) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        fimage1 = File(pickedFile.path);
      });

      // Show progress indicator during upload
      profile_controller.isUploading.value = true;

      try {
        var result = await _uploadImage(token);
        if (result != null) {
          profile_controller.userPic!.value =
              "${AppConstant.BASE_URL}/${result.profilePic}";
          profile_controller.userPic!.refresh();
          util.showSnackBar("Success", "Profile photo updated!", true);
        }
      } catch (e) {
        util.showSnackBar("Error", "Image upload failed", false);
      } finally {
        // Hide progress indicator after upload
        profile_controller.isUploading.value = false;
      }
    } else {
      util.showSnackBar("Alert", "No image selected", false);
    }
  }

  Future<XFile?> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = path.join(dir.absolute.path, "temp.jpg");

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50,
    );

    return result!;
  }

  Future<editImgRes.EditImgDto?> _uploadImage(String token) async {
    if (_image == null) {
      util.showSnackBar("Alert", "No image selected", false);
      return null;
    }

    XFile compressedImage;
    try {
      compressedImage = (await compressImage(_image!))!;
    } catch (e) {
      util.showSnackBar("Alert", "Image compression failed", false);
      return null;
    }

    final uri =
        Uri.parse('${AppConstant.BASE_URL}${AppEndPoints.edit_image_upload}');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..files
          .add(await http.MultipartFile.fromPath('file', compressedImage.path));

    try {
      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = await response.stream.bytesToString();
        var temp = editImgRes.editImgDtoFromJson(jsonResponse);

        if (temp.message.isNotEmpty) {
          return temp;
        }
      } else {
        util.showSnackBar("Error", "Image upload failed", false);
      }
    } catch (e) {
      util.showSnackBar("Error", "Something went wrong!", false);
    }
    return null;
  }

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

  Dialog selectImage(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Container(
          height: 200.0,
          width: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Select',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Please select image from:',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          if (_dashboardController.uid.value.isNotEmpty) {
                            choose_image(ImageSource.camera,
                                _dashboardController.uid.value);
                          } else {
                            util.showSnackBar(
                                "Alert", "Couldn't fetch user id", false);
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text("CAMERA"),
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Get.back();
                          if (_dashboardController.uid.value.isNotEmpty) {
                            choose_image(ImageSource.gallery,
                                _dashboardController.uid.value);
                          } else {
                            util.showSnackBar(
                                "Alert", "Couldn't fetch user id", false);
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text("GALLERY"),
                        color: Colors.green,
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    fimage1 = null;

    AppConstant.getUserData("user_data").then((value) {
      if (value != null) {
        setState(() {
          token = value.user_token;
        });
        profile_controller.isLoading.value = true;
        profile_controller.getProfile(value.user_token).then((newvalue) {
          if (newvalue != null) {
            profile_controller.userPic!.value = newvalue!.user.pic;
            profile_controller.userPic!.refresh();
            setState(() {
              netwokIMg = newvalue!.user.pic;
            });
            profile_controller.isLoading.value = false;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    profile_controller.user_full_name_controller.text = "";
    profile_controller.user_address_controller.text = "";
    profile_controller.user_mobile_controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: RefreshIndicator(
        onRefresh: () {
          return Future(() => null);
        },
        child: PageStorage(
          bucket: pageBucket,
          child: SafeArea(
              child: Obx(
            () => profile_controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      backToolbar(
                        name: "My Profile",
                        get_back: true,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                future: fetchUserData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.green,
                                    ));
                                  } else if (snapshot.hasError) {
                                    return const Center(
                                      child: Text(
                                        "Error loading profile data",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    );
                                  } else if (!snapshot.hasData ||
                                      snapshot.data == null) {
                                    return const Center(
                                      child: Text(
                                        "No profile data available",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    );
                                  } else {
                                    final userData =
                                        snapshot.data as Map<String, dynamic>;
                                    final profilePic = userData["pic"] ??
                                        "assets/images/profile_icon.png";


                                    print("ishwar:logger: ${profilePic}");

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.green,
                                                    width: 3.0),
                                              ),
                                              child:
                                              // CircleAvatar(
                                              //   radius: 60,
                                              //   backgroundColor:
                                              //       Colors.transparent,
                                              //   child: ClipOval(
                                              //       child: Container(
                                              //         height: 140,
                                              //             width: 140,
                                              //         child: FutureBuilder(
                                              //           future: _fetchImage(profilePic),
                                              //           builder: (context, snapshot) {
                                              //             if (snapshot.connectionState == ConnectionState.waiting) {
                                              //               return const Center(
                                              //                 child: CircularProgressIndicator(),
                                              //               );
                                              //             } else if (snapshot.hasError) {
                                              //               return const Center(
                                              //                 child: Text(
                                              //                   "Error loading image",
                                              //                   style: TextStyle(color: Colors.red),
                                              //                 ),
                                              //               );
                                              //             } else if (snapshot.data == null) {
                                              //               return const Center(
                                              //                 child: Text(
                                              //                   "No image data available",
                                              //                   style: TextStyle(color: Colors.grey),
                                              //                 ),
                                              //               );
                                              //             } else {
                                              //               return SizedBox(
                                              //                 width: 120,
                                              //                 height: 120,
                                              //                 child: ClipOval(
                                              //                   child:  snapshot.data != null ? Image.memory(
                                              //                     snapshot.data!,
                                              //                     width: 120,
                                              //                     height: 120,
                                              //                     fit: BoxFit.cover, // Ensures the image fills the space
                                              //                   ):Center(child: CircularProgressIndicator(),),
                                              //                 ),
                                              //               );
                                              //             }
                                              //           },
                                              //         ),
                                              //       )
                                                    // Image.network(
                                                    //   profilePic,
                                                    //   width: 120,
                                                    //   height: 120,
                                                    //   fit: BoxFit.cover,
                                                    //   errorBuilder: (context,
                                                    //       error, stackTrace) {
                                                    //     print(
                                                    //         "ishwar:logger: error $error");
                                                    //
                                                    //     return Image.asset(
                                                    //       "assets/images/profile_icon.png",
                                                    //       width: 120,
                                                    //       height: 120,
                                                    //       fit: BoxFit.cover,
                                                    //     );
                                                    //   },
                                                    // ),
                                                   // ),
                                              //),
                                              CircleAvatar(
                                                radius: 60,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: ClipOval(
                                                      child: Container(
                                                        height: 140,
                                                            width: 140,
                                                child: SizedBox(
                                                    height: 140,
                                                    width: 140,
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
                                            ),),),
                                            Positioned(
                                              top: 1,
                                              right: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(2, 4),
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      blurRadius: 3,
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            selectImage(
                                                                context),
                                                      );
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .photo_camera_outlined,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 1,
                                              right: 1,
                                              left: 1,
                                              child: Container(
                                                  padding: EdgeInsets.all(1),
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    // Background color of the badge
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  child: Obx(
                                                        () => Center(
                                                      child: Text(
                                                        '${dashboardController.user_role.value.toString().capitalizeFirst ?? "No role found"}',
                                                        // Change this text to the appropriate user role
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            // Positioned(
                                            //   child: Container(
                                            //       color: Colors.red,
                                            //       child: Text(
                                            //         "${profilePic.toString().split('/').last}",
                                            //         style: TextStyle(
                                            //             color: Colors.white),
                                            //       )),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Column(
                                children: [
                                  // Full Name
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          AppConstant.APP_NORMAL_PADDING_34,
                                      vertical: 8.0, // Reduced vertical padding
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppConstant.APP_NORMAL_PADDING),
                                        border: Border.all(
                                            color: Colors.green, width: 1.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: profile_controller
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
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Email
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          AppConstant.APP_NORMAL_PADDING_34,
                                      vertical: 8.0, // Reduced vertical padding
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppConstant.APP_NORMAL_PADDING),
                                        border: Border.all(
                                            color: Colors.green, width: 1.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: profile_controller
                                              .user_email_controller,
                                          textAlign: TextAlign.center,
                                          onTap: () {
                                            setState(() {});
                                          },
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10)
                                          ],
                                          enabled: false,
                                          decoration: InputDecoration(
                                            hintStyle:
                                                AppConstant.edit_txt_hint(),
                                            border: InputBorder.none,
                                            hintText: "Email",
                                          ),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Mobile
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          AppConstant.APP_NORMAL_PADDING_34,
                                      vertical: 8.0, // Reduced vertical padding
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppConstant.APP_NORMAL_PADDING),
                                        border: Border.all(
                                            color: Colors.green, width: 1.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: profile_controller
                                              .user_mobile_controller,
                                          textAlign: TextAlign.center,
                                          onTap: () {
                                            setState(() {});
                                          },
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10)
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
                                  // Address
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          AppConstant.APP_NORMAL_PADDING_34,
                                      vertical: 8.0, // Reduced vertical padding
                                    ),
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppConstant.APP_NORMAL_PADDING),
                                        border: Border.all(
                                            color: Colors.green, width: 1.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: profile_controller
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
                                  // Submit Button
                                  // Container(
                                  //   child: Visibility(
                                  //     visible: true,
                                  //     // Set to true to show the button
                                  //     child: Padding(
                                  //       padding: EdgeInsets.only(
                                  //           top: AppConstant.APP_NORMAL_PADDING,
                                  //           left: AppConstant.LARGE_SIZE,
                                  //           right: AppConstant.LARGE_SIZE,
                                  //           bottom:
                                  //               AppConstant.SMALL_TEXT_SIZE),
                                  //       child: Bounceable(
                                  //         onTap: () {
                                  //           // Submit button action
                                  //           // Navigator.push(
                                  //           //     context,
                                  //           //     MaterialPageRoute(
                                  //           //         builder: (context) =>
                                  //           //             Testing()));
                                  //           print("Submit button tapped");
                                  //           // You can perform any action here, such as form validation or data submission
                                  //         },
                                  //         child: Container(
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.black,
                                  //             gradient:
                                  //                 AppConstant.BUTTON_COLOR,
                                  //             borderRadius:
                                  //                 BorderRadius.circular(10),
                                  //           ),
                                  //           margin: const EdgeInsets.all(8.0),
                                  //           width: AppConstant.BUTTON_WIDTH,
                                  //           height: AppConstant.BUTTON_HIGHT,
                                  //           child: Center(
                                  //             child: Text(
                                  //               AppConstant.SUBMIT,
                                  //               style:
                                  //                   GoogleFonts.imFellEnglish(
                                  //                 textStyle: Theme.of(context)
                                  //                     .textTheme
                                  //                     .displayLarge,
                                  //                 fontSize: AppConstant
                                  //                     .HEADLINE_SIZE_20,
                                  //                 fontWeight: FontWeight.w400,
                                  //                 fontStyle: FontStyle.normal,
                                  //                 color: Colors.black,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          )),
        ),
      ),
    ));
  }
}
