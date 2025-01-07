// import 'dart:convert';
// import 'dart:io';
//
// import 'package:testingevergreen/models/user_model.dart' as myprofile;
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// // import '../../Utills/utills.dart';
// import '../../Utills3/utills.dart';
// import '../../data/repository/profile_repo.dart';
// import '../dashboard/dahboard_controller.dart';
//
// class ProfileController extends GetxController {
//   final ProfileRepository profileRepository;
//
//   ProfileController({required this.profileRepository});
//
//   Rx<myprofile.User?> myuser = myprofile.User(
//     address: "",
//     email: "",
//     firebaseToken: "",
//     id: '',
//     fullName: '',
//     deviceId: '',
//     mobile: 0,
//     otp: '',
//     otpVerified: 0,
//     pic: '',
//     deletedAt: null,
//     role: '',
//     siteId: [],
//     datetime: '',
//     v: 0,
//   ).obs;
//
//   var user_full_name_controller = TextEditingController();
//   var user_mobile_controller = TextEditingController();
//   var user_address_controller = TextEditingController();
//   var user_email_controller = TextEditingController();
//   RxString _fullname = "".obs;
//
//   RxString get fullname => _fullname;
//
//   RxString _mobile = "".obs;
//
//   RxString get mobile => _mobile;
//
//
//
//   RxString  userPic ="".obs;
//
//   RxString _address = "".obs;
//
//   RxString get address => _address;
//
//   RxString requestStatus = "".obs;
//
//   RxBool atTopToggle = false.obs;
//
//   // late ProfileService profileService;
//   var util = Utills();
//   var _name_profile = "".obs;
//
//   String get name_profile => _name_profile.value.toString();
//
//   var _lastName = "".obs;
//
//   String get lastName => _lastName.value.toString();
//
//   var _userName = "".obs;
//
//   String get userName => _userName.value.toString();
//
//   File? imageFile = null;
//
//   RxBool _hasUesrVideos = false.obs;
//
//   RxBool get hasUesrVideos => _hasUesrVideos;
//
//   RxBool _hasUesrPost = false.obs;
//
//   RxBool get hasUesrPost => _hasUesrPost;
//
//   var _email_profile = "".obs;
//
//   String get email_profile => _email_profile.value.toString();
//
//   var _contact_profile = "".obs;
//
//   String get contact_profile => _contact_profile.value.toString();
//
//   var _subscribe = "".obs;
//
//   String get subscribe => _subscribe.value;
//   var _watch_time = "".obs;
//
//   String get watch_time => _watch_time.value;
//   var _review = "".obs;
//
//   String get review => _review.value;
//   var video_data = false.obs;
//   var _image = "".obs;
//
//   RxString get image => _image;
//
//   RxString _userID = "".obs;
//
//   RxString _dob = "".obs;
//
//   RxString get dob => _dob;
//
//   RxString get userID => _userID;
//
//   RxList _interest = [].obs;
//
//   RxList get interest => _interest;
//
//   RxString _friend_status = "".obs;
//
//   RxString get friend_status => _friend_status;
//
//   RxString _abtMe = "".obs;
//
//   RxString get abtMe => _abtMe;
//
//   RxBool MyprofileAbtUsHide = false.obs;
//   RxBool MyprofileInterestHide = false.obs;
//
//   RxBool HideUnhide = false.obs;
//   RxBool HideUnhideIntrest = false.obs;
//
//   RxBool _nodata = true.obs;
//
//   RxBool get nodata => _nodata;
//
//   RxBool _hasUserReels = true.obs;
//
//   RxBool get hasUserReels => _hasUserReels;
//
//   RxBool _noReelData = true.obs;
//
//   RxBool get noReelData => _noReelData;
//
//   RxBool _loading = true.obs;
//
//   RxBool get loading => _loading;
//
//   RxString profilepicget_key = "".obs;
//   RxString profilepicget_url = "".obs;
//
//   RxBool atTop = true.obs;
//
//   RxBool isLoading = false.obs;
//   RxInt current_page = 1.obs;
//
//   RxBool _hasMoreVideos = true.obs;
//
//   RxBool get hasMoreVideos => _hasMoreVideos;
//
//   RxInt reel_current_page = 1.obs;
//
//   RxInt my_timeline_cpage = 1.obs;
//
//   RxBool _hasMoreMyReels = true.obs;
//
//   RxBool get hasMoreMyReels => _hasMoreMyReels;
//
//   RxBool _hasMoreUserReels = true.obs;
//
//   RxBool get hasMoreUserReels => _hasMoreUserReels;
//
//   RxBool _hasMoreMyVideos = true.obs;
//
//   RxBool get hasMoreMyVideos => _hasMoreMyVideos;
//
//   RxInt myvideo_current_page = 1.obs;
//
//   RxBool _hasMoreTimeline = true.obs;
//
//   RxBool get hasMoreTimeline => _hasMoreTimeline;
//
//   RxBool _hasMoreUserTimeline = true.obs;
//
//   RxBool get hasMoreUserTimeline => _hasMoreUserTimeline;
//
//   RxInt user_timeline_cpage = 1.obs;
//
//   RxInt userReel_current_page = 1.obs;
//
//   RxBool isReelDescriptionVisible = false.obs;
//   RxBool isUserReelDescriptionVisible = false.obs;
//
//   // final EditProfileController editProfileController=Get.find();
//
//   bool validation() {
//     if (_name_profile.value.isEmpty) {
//       util.showSnackBar("Alert", "Please provide name!", false);
//       return false;
//     } else if (_email_profile.value.isEmpty) {
//       util.showSnackBar("Alert", "Please provide email!", false);
//       return false;
//     } else if (_contact_profile.value.isEmpty) {
//       util.showSnackBar("Alert", "Please provide mobile number!", false);
//       return false;
//     } else {
//       return true;
//     }
//   }
//   bool validationEditprofile() {
//     if (user_full_name_controller.text.isEmpty) {
//       util.showSnackBar("Alert", "Please provide name!", false);
//       return false;
//     } else if (user_email_controller.text.isEmpty) {
//       util.showSnackBar("Alert", "Please provide email!", false);
//       return false;
//     } else if (user_mobile_controller.text.isEmpty) {
//       util.showSnackBar("Alert", "Please provide mobile number!", false);
//       return false;
//     } else {
//       return true;
//     }
//   }
//   //get profile
//   Future<myprofile.Usermodel?> getProfile(String token) async {
//     _loading.value = true;
//     debugPrint("profileapi+token ${token}");
//
//     var res = await profileRepository.getProfile("${token}");
//     if (res.statusCode == 200 || res.statusCode == 201) {
//       debugPrint("profileapi+200");
//       final result = myprofile.usermodelFromJson(res.bodyString!);
//       debugPrint("profileapi girja+${result.user.fullName.toString()}");
//       if (result.status == true) {
//         isLoading.value=false;
//
//         _fullname.value = result.user.fullName;
//
//         user_full_name_controller.text=result.user.fullName;
//         user_address_controller.text = result.user.address.toString();
//         user_mobile_controller.text = result.user.mobile.toString();
//         user_email_controller.text=result.user.email.toString();
//         userPic.value=result.user.pic.toString();
//         userPic.refresh();
//         update();
//         debugPrint("profileapi+${result.user.email.toString()}");
//         debugPrint("profileapi+${result.user.mobile.toString()}");
//         debugPrint("profileapi+${result.user.fullName.toString()}");
//
//         debugPrint("profileapipic+${result.user.pic.toString()}");
//
//         // myuser.value = result.user;
//         // myuser.refresh();
//         update();
//
//         return result;
//       }
//
//
//       return result;
//     } else if(res.statusCode==404||res.statusCode==403){
//       isLoading.value=false;
//       _loading.value = false;
//
//       util.showSnackBar("Alert", "${jsonDecode(res.bodyString!)['Message'].toString()}", false);
//       debugPrint("profileapi+failed${res.statusCode}");
//       return null;
//     }
//   }
//   Future<int?> updateProfileDetails(String token) async {
//     debugPrint("updateProfileDetails" + "apicalled");
//
//
//     if (validationEditprofile() == false) {
//       return null;
//     }
//     util.startLoading();
//
//     //debugPrint("njdebug" + interest.toString());
//     Map data = {
//       "full_name": user_full_name_controller.text ?? "",
//       "address": user_address_controller.text ?? "",
//       "email": user_email_controller.text ?? "",
//     };
//     var res = await profileRepository.updateProfile(token, data);
//
//     if (res.statusCode == 200 || res.statusCode == 201) {
//       debugPrint("updateProfileDetails" + "response 200");
//       util.stopLoading();
//       util.showSnackBar("Alert", "Updated successfully!", true);
//
//       //util.showSnackBar("Alert", "${res.body.toString()}", true);
//       var response = jsonDecode(res.bodyString!);
//       if (response != null) {
//         if (response['status'] == true) {
//
//           DashboardController _dashboardController = Get.find();
//           _dashboardController.userName = fullname;
//           // _dashboardController.userName.refresh();
//
//           // util.showSnackBar("Alert", "${response['status'].toString()}", true);
//           //  debugPrint("edit_profile+success from controller");
//           return res.statusCode;
//         }
//       }
//
//       return res.statusCode;
//     } else {
//       debugPrint("updateProfileDetails" + "response failed");
//       util.stopLoading();
//       util.showSnackBar("Alert", "failed to upload!", false);
//       return null;
//     }
//   }
// }
import 'dart:convert';
import 'dart:io';

import 'package:testingevergreen/models/user_model.dart' as myprofile;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// import '../../Utills/utills.dart';
import '../../Utills3/utills.dart';
import '../../data/repository/profile_repo.dart';
import '../dashboard/dahboard_controller.dart';

class ProfileController extends GetxController {
  final ProfileRepository profileRepository;

  ProfileController({required this.profileRepository});

  Rx<myprofile.User?> myuser = myprofile.User(
    address: "",
    email: "",
    firebaseToken: "",
    id: '',
    fullName: '',
    deviceId: '',
    mobile: 0,
    otp: '',
    otpVerified: 0,
    pic: '',
    deletedAt: null,
    role: '',
    siteId: [],
    datetime: '',
    v: 0,
  ).obs;

  var user_full_name_controller = TextEditingController();
  var user_mobile_controller = TextEditingController();
  var user_address_controller = TextEditingController();
  var user_email_controller = TextEditingController();
  RxString _fullname = "".obs;

  // RxString get fullname => _fullname;
  var fullname = ''.obs;

  RxString _mobile = "".obs;

  RxString get mobile => _mobile;


  RxBool isUploading = false.obs;
  RxString  userPic ="".obs;

  RxString _address = "".obs;

  RxString get address => _address;

  RxString requestStatus = "".obs;

  RxBool atTopToggle = false.obs;

  // late ProfileService profileService;
  var util = Utills();
  var _name_profile = "".obs;

  String get name_profile => _name_profile.value.toString();

  var _lastName = "".obs;

  String get lastName => _lastName.value.toString();

  var _userName = "".obs;

  String get userName => _userName.value.toString();

  File? imageFile = null;

  RxBool _hasUesrVideos = false.obs;

  RxBool get hasUesrVideos => _hasUesrVideos;

  RxBool _hasUesrPost = false.obs;

  RxBool get hasUesrPost => _hasUesrPost;

  var _email_profile = "".obs;

  String get email_profile => _email_profile.value.toString();

  var _contact_profile = "".obs;

  String get contact_profile => _contact_profile.value.toString();

  var _subscribe = "".obs;

  String get subscribe => _subscribe.value;
  var _watch_time = "".obs;

  String get watch_time => _watch_time.value;
  var _review = "".obs;

  String get review => _review.value;
  var video_data = false.obs;
  var _image = "".obs;

  RxString get image => _image;

  RxString _userID = "".obs;

  RxString _dob = "".obs;

  RxString get dob => _dob;

  RxString get userID => _userID;

  RxList _interest = [].obs;

  RxList get interest => _interest;

  RxString _friend_status = "".obs;

  RxString get friend_status => _friend_status;

  RxString _abtMe = "".obs;

  RxString get abtMe => _abtMe;

  RxBool MyprofileAbtUsHide = false.obs;
  RxBool MyprofileInterestHide = false.obs;

  RxBool HideUnhide = false.obs;
  RxBool HideUnhideIntrest = false.obs;

  RxBool _nodata = true.obs;

  RxBool get nodata => _nodata;

  RxBool _hasUserReels = true.obs;

  RxBool get hasUserReels => _hasUserReels;

  RxBool _noReelData = true.obs;

  RxBool get noReelData => _noReelData;

  RxBool _loading = true.obs;

  RxBool get loading => _loading;

  RxString profilepicget_key = "".obs;
  RxString profilepicget_url = "".obs;

  RxBool atTop = true.obs;

  RxBool isLoading = false.obs;
  RxInt current_page = 1.obs;

  RxBool _hasMoreVideos = true.obs;

  RxBool get hasMoreVideos => _hasMoreVideos;

  RxInt reel_current_page = 1.obs;

  RxInt my_timeline_cpage = 1.obs;

  RxBool _hasMoreMyReels = true.obs;

  RxBool get hasMoreMyReels => _hasMoreMyReels;

  RxBool _hasMoreUserReels = true.obs;

  RxBool get hasMoreUserReels => _hasMoreUserReels;

  RxBool _hasMoreMyVideos = true.obs;

  RxBool get hasMoreMyVideos => _hasMoreMyVideos;

  RxInt myvideo_current_page = 1.obs;

  RxBool _hasMoreTimeline = true.obs;

  RxBool get hasMoreTimeline => _hasMoreTimeline;

  RxBool _hasMoreUserTimeline = true.obs;

  RxBool get hasMoreUserTimeline => _hasMoreUserTimeline;

  RxInt user_timeline_cpage = 1.obs;

  RxInt userReel_current_page = 1.obs;

  RxBool isReelDescriptionVisible = false.obs;
  RxBool isUserReelDescriptionVisible = false.obs;

  // final EditProfileController editProfileController=Get.find();

  bool validation() {
    if (_name_profile.value.isEmpty) {
      util.showSnackBar("Alert", "Please provide name!", false);
      return false;
    } else if (_email_profile.value.isEmpty) {
      util.showSnackBar("Alert", "Please provide email!", false);
      return false;
    } else if (_contact_profile.value.isEmpty) {
      util.showSnackBar("Alert", "Please provide mobile number!", false);
      return false;
    } else {
      return true;
    }
  }
  bool validationEditprofile() {
    if (user_full_name_controller.text.isEmpty) {
      util.showSnackBar("Alert", "Please provide name!", false);
      return false;
    } else if (user_email_controller.text.isEmpty) {
      util.showSnackBar("Alert", "Please provide email!", false);
      return false;
    } else if (user_mobile_controller.text.isEmpty) {
      util.showSnackBar("Alert", "Please provide mobile number!", false);
      return false;
    } else {
      return true;
    }
  }
  //get profile
  Future<myprofile.Usermodel?> getProfile(String token) async {
    _loading.value = true;
    debugPrint("profileapi+token ${token}");

    var res = await profileRepository.getProfile("${token}");
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("profileapi+200");
      final result = myprofile.usermodelFromJson(res.bodyString!);
      debugPrint("profileapi girja+${result.user.fullName.toString()}");
      if (result.status == true) {
        isLoading.value=false;

        _fullname.value = result.user.fullName;

        user_full_name_controller.text=result.user.fullName;
        user_address_controller.text = result.user.address.toString();
        user_mobile_controller.text = result.user.mobile.toString();
        user_email_controller.text=result.user.email.toString();
        userPic.value=result.user.pic.toString();
        userPic.refresh();
        update();
        debugPrint("profileapi+${result.user.email.toString()}");
        debugPrint("profileapi+${result.user.mobile.toString()}");
        debugPrint("profileapi+${result.user.fullName.toString()}");

        debugPrint("profileapipic+${result.user.pic.toString()}");
        userPic.refresh();
        // myuser.value = result.user;
        // myuser.refresh();
        update();
        return result;
      }
      return result;
    } else if(res.statusCode==404||res.statusCode==403){
      isLoading.value=false;
      _loading.value = false;

      util.showSnackBar("Alert", "${jsonDecode(res.bodyString!)['Message'].toString()}", false);
      debugPrint("profileapi+failed${res.statusCode}");
      return null;
    }
  }
  // Future<int?> updateProfileDetails(String token) async {
  //   debugPrint("updateProfileDetails" + "apicalled");
  //
  //
  //   if (validationEditprofile() == false) {
  //     return null;
  //   }
  //   util.startLoading();
  //
  //   //debugPrint("njdebug" + interest.toString());
  //   Map data = {
  //     "full_name": user_full_name_controller.text ?? "",
  //     "address": user_address_controller.text ?? "",
  //     "email": user_email_controller.text ?? "",
  //   };
  //   var res = await profileRepository.updateProfile(token, data);
  //
  //   if (res.statusCode == 200 || res.statusCode == 201) {
  //     debugPrint("updateProfileDetails" + "response 200");
  //     util.stopLoading();
  //     util.showSnackBar("Alert", "Updated successfully!", true);
  //
  //     //util.showSnackBar("Alert", "${res.body.toString()}", true);
  //     var response = jsonDecode(res.bodyString!);
  //     if (response != null) {
  //       if (response['status'] == true) {
  //
  //         DashboardController _dashboardController = Get.find();
  //         _dashboardController.userName = fullname;
  //         _dashboardController.userName.refresh();
  //
  //         // util.showSnackBar("Alert", "${response['status'].toString()}", true);
  //         //  debugPrint("edit_profile+success from controller");
  //         return res.statusCode;
  //       }
  //     }
  //
  //     return res.statusCode;
  //   } else {
  //     debugPrint("updateProfileDetails" + "response failed");
  //     util.stopLoading();
  //     util.showSnackBar("Alert", "failed to upload!", false);
  //     return null;
  //   }
  // }
  Future<int?> updateProfileDetails(String token) async {
    debugPrint("updateProfileDetails" + "apicalled");

    if (validationEditprofile() == false) {
      return null;
    }
    util.startLoading();

    Map data = {
      "full_name": user_full_name_controller.text ?? "",
      "address": user_address_controller.text ?? "",
      "email": user_email_controller.text ?? "",
    };
    var res = await profileRepository.updateProfile(token, data);

    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("updateProfileDetails" + "response 200");
      util.stopLoading();
      util.showSnackBar("Alert", "Updated successfully!", true);

      var response = jsonDecode(res.bodyString!);
      if (response != null && response['status'] == true) {
        DashboardController _dashboardController = Get.find();
        _dashboardController.userName.value = user_full_name_controller.text; // Update value
        _dashboardController.userName.refresh();
        return res.statusCode;
      }

      return res.statusCode;
    } else {
      debugPrint("updateProfileDetails" + "response failed");
      util.stopLoading();
      util.showSnackBar("Alert", "failed to upload!", false);
      return null;
    }
  }

}
