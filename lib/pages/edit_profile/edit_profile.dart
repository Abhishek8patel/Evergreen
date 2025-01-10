import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testingevergreen/pages/dashboard/dashboard.dart';
import 'package:testingevergreen/pages/myhomepage/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:io';
import 'package:testingevergreen/Testing.dart';
import 'package:testingevergreen/pages/profile/edit_image_model.dart'
as editImgRes;
import 'package:testingevergreen/pages/profile/profile_controller.dart';
import '../../Utills3/endpoints.dart';
import '../../Utills3/universal.dart';
import '../../Utills3/utills.dart';
import '../../appconstants/appconstants.dart';
import '../../main.dart';
import '../dashboard/dahboard_controller.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import '../../appconstants/mycolor.dart';
import 'edit_pro_controller.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final util = Utills();
  EditProfileController editProfileController = Get.find();
  ProfileController profileController = Get.find();
  DashboardController dashboardController = Get.find();
  ProfileController profile_controller = Get.find();
  DashboardController _dashboardController = Get.find();

  final pageBucket = PageStorageBucket();
  File? fimage1 = null;
  File? _image;
  // final util = Utills();
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
  // DashboardController dashboardController = Get.find();

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

  DateTime selectedDate = DateTime.now();
  var _selected_date = "";
  var _selected_month = "";
  var _selected_year = "";
  var profileLoading = false;
  late String? _userToken;

  // DashboardController _dashboardController = Get.find();

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
    //............... Add for me according to image show in show of edit profile page..................
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

//..................................

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
  // @override
  // void initState() {
  //
  // }

  @override
  void dispose() {
    super.dispose();
    profile_controller.user_full_name_controller.text = "";
    profile_controller.user_address_controller.text = "";
    profile_controller.user_mobile_controller.text = "";
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
  // @override
  // void dispose() {
  //   super.dispose();
  // }

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
                        //Text("Abhishek"),
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
                                        child: CircleAvatar(
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
                                                // showDialog(
                                                //   context: context,
                                                //   builder: (BuildContext context) => selectImage(context, _dashboardController),
                                                // );
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
                                        inputFormatters: [FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z\s.0-9@]')),],
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
                                        inputFormatters: [FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z\s.0-9/-]')),],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // submit
                        const SizedBox(height: 20),
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
