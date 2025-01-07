import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// import '../../Utills/endpoints.dart';
import '../../Utills3/endpoints.dart';
import '../apiclient/apiclient.dart';
class ProfileRepository extends GetxService {
  final ApiClient apiclient;

  ProfileRepository({required this.apiclient});

  Future<Response> getProfile(String token) async {
    return apiclient.getProfile("${AppEndPoints.get_pro}", token);
  }

  Future<Response> getProfileUser(String token, String userID) async {
    return apiclient.getProfileUser("/api/user/getUserView/$userID", token);
  }

  Future<Response> getProfileReview(String token, String userID) async {
    return apiclient.getProfileReview("/api/user/getReview/$userID/1", token);
  }


  //
  Future<Response> getUrlImageUpload(String token) async {
    return apiclient.getUrlImageUpload("/api/user/getProfilePicUploadUrlS3", token);
  }

  Future<Response> imageUploadKey(String token,String profilePicKey) async {
    return apiclient.imageUploadKey("/api/user/profilePicKey", token,profilePicKey);
  }

  Future<Response> uploadimage(
      String token,
      String profilePicKey

      ) async {
    return apiclient.uploadImage(
        "/api/user/profilePicKey", token, profilePicKey);
  }






  Future<Response> getMyVideos(String token,String? page) async {
    return apiclient.getMyVideos("/api/video/getMyVideos/$page", token);
  }

  Future<Response> getMyReels(String token,String? page) async {
    return apiclient.getMyReels("/api/reel/getMyReels/$page", token);
  }


  Future<Response> getUserReels(String token,String userID,String? page) async {
    return apiclient.getUserReels("/api/reel/getUserReels/$userID/$page", token);
  }

  Future<Response> addFriendRequst(String token,String friend_id) async {
    return apiclient.addFriendRequest("/api/myfriend/Sendfriendrequest", token,friend_id);
  }



  Future<Response> getUserVideos(String token, String userID,String page) async {
    return apiclient.getUserVideos("/api/video/getUserVideos/$userID/$page", token);
  }

  Future<Response> getUserTimeline(String token, String userID,String? page) async {
    debugPrint("getUserTimeline"+userID);
    return apiclient.getUserTimeline("/api/timeline/getUserTimeline/$userID/$page", token);
  }

  Future<Response> getMyTimeline(String token,String? page) async {
    return apiclient.getMyTimeline("/api/timeline/getMyTimeline/$page", token);
  }

  Future<Response> updateProfile(String token, Map body) async {
    return apiclient.updateProfile(AppEndPoints.update_profile, token, body);
  }

  // Future<Response> changePassword(Map body) async {
  //   return apiclient.changePassword("/api/user/ChangePassword", body);
  // }

  // Future<Response> changeProfilePic(File? pic, String token) async {
  //   return apiclient.updateProfilePic(AppEndPoints.changeProfilePic, pic, token);
  // }

  // Future<Response> getImageUploadkey(String token) async {
  //   return await apiclient.getImageUploadkey(AppEndPoints.getImageUploadKey, token);
  // }


  // Future<Response> updateBankDetails(
  //     String token,
  //     String name,
  //     String bname,
  //     String acno,
  //     String ifsc,
  //     String branchNO,
  //     ) async {
  //   return apiclient.uploadBankDetails(AppEndPoints.uploadbankDetails, token,
  //       name, bname, acno, ifsc, branchNO);
  // }
  //
  // Future<Response> getBankDetails(
  //     String token,
  //     ) async {
  //   return apiclient.getBankDetails(
  //     AppEndPoints.bankDetails,
  //     token,
  //   );
  // }

  Future<Response> contact_us(
      String token,
      String name,
      String email,
      String mobile,
      String message,
      ) async {
    return apiclient.ContactUS(
        AppEndPoints.contact_us, token, name, email, mobile, message);
  }

//api/user/ChangePassword

// Future<Response> updateProfileImage(Map body) async {
//   return apiclient.updateProfileImage("/api/profileimage_upadte", body);
// }
}