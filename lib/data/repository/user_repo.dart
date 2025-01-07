import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../Utills/endpoints.dart';
import '../../Utills3/endpoints.dart';
import '../apiclient/apiclient.dart';



class UserRepo extends GetxService {
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getAllCategories() async {
    return await apiClient.getAllCategories("/api/category");
  }
  Future<Response> getChatList(String token) async {
    return apiClient.getChatList("/api/chat/1",token);
  }

  Future<Response> getAllCategoriesNew() async {
    return await apiClient.getAllCategoriesNew("/GetAllCategoriesAdmin");
  }
  Future<Response> getTrandingVid(String token,String? category_id,[String? current_page="1",String? search=""]) async {
    return await apiClient.getTrendingVideos("/api/video/getPaginatedVideos/$current_page",token,category_id,search);
  }

  Future<Response> deleteVid(String token,String? video_id,) async {
    return await apiClient.deleteVideo("/api/video/deleteVideo",token,video_id!);
  }

  Future<Response> deleteReel(String token,String? reel_id,) async {
    return await apiClient.deleteReel("/api/reel/deleteReel",token,reel_id!);
  }


  Future<Response> getUserlist(String token,[String? current_page="1",String? name=""]) async {
    return await apiClient.getUserList("/api/user/getAllUsersWebsite",token,name,current_page);
  }


  Future<Response> getTrandingReels(String token,String? category_id,[String? current_page="1",String? search=""]) async {
    debugPrint("videodebug current_page"+"${current_page}");
    return await apiClient.getTrendingReels("/api/reel/getPaginatedReel/$current_page",token,category_id,search);
  }
  Future<Response> getTrendingJobs(String token,String? category_id,[String? current_page="1",String? search]) async {
    return await apiClient.getTrendingJobs("/api/job/getPaginatedJob/$current_page",token,category_id,search);
  }

  Future<Response> getTrendingTimeline(String token,String? category_id,[String? current_page="1",String? search]) async {
    return await apiClient
        .getTrendingTimeline("/api/timeline/getPaginatedTimeline/$current_page",token,category_id,search);
  }



  Future<Response> updateWatchTime(String token,String time) async {
    return apiClient.UpdateWatchTime("/api/user/updateUserWatchTime",time,token);
  }
  //api/user/updateUserWatchTime
  Future<Response> getAppliedJobsList(String token,String? category_id,) async {
    return apiClient.getMyAllAppliedJobsList("/api/job/getAppliedJobs",token,category_id);
  }
  Future<Response> postResport(String token,String report_type,String type_id,String title,String description) async {
    return apiClient.reportPost("/api/comman/report",token,report_type,type_id,title,description);
  }
  //api/comman/report

  Future<Response> getMyAllJobsPostedList(String token,String? category_id,[String? current_page="1"]) async {
    return apiClient.getMyAllJobsPostedList("/api/job/getMyJobs/$current_page",token,category_id);
  }

  Future<Response> getHireList(String token) async {
    return await apiClient.getHireList("/api/user/getHireList", token);
  }


  Future<Response> getMyWorkList(String token) async {
    return await apiClient.getMyWorkList("/api/user/getHireByMe", token);
  }




  Future<Response> updateHireStatus(String token,String _id,String status) async {
    return await apiClient.updateHireStatus("/api/user/updateHireStatus", token, _id,status);
  }

  Future<Response> getVideoUploadKey(String token) async {
    return await apiClient.getVideoUploadkey("/api/video/getVideoUploadUrlS3", token);
  }

  Future<Response> getReelUploadKey(String token) async {
    return await apiClient.getReelUploadkey("/api/reel/getReelsUploadUrlS3", token);
  }

  //api/video/getVideoUploadUrlS3



  Future<Response> addReview(String token,String review_id,String review_no,String des,String hire_list_id) async {
    return await apiClient.addReview("/api/user/addReview", token, review_id, review_no, des, hire_list_id);
  }


  Future<Response> createHire(String token,String hire_id,String amount,String calendar_id) async {
    return await apiClient.createHire("/api/user/createHire", token,hire_id,amount,calendar_id);
  }
  Future<Response> getNotificationsList(String token) async {
    return await apiClient.getNotificationsList("/api/user/NotificationList", token);
  }

  Future<Response> getTimeLineList(String token) async {
    return await apiClient.getTimeLineList(
        "/api/timeline/getPaginatedTimeline/1", token);
  }




  Future<Response> videoLikeDislike(
      String token, String videoID, String count) async {
    return apiClient.videoLikeDeslike(
        "/api/video/updateVideoLike", token, videoID, count);
  }

  Future<Response> videoCountUp(
      String token, String videoID, ) async {
    return apiClient.videoCountUp(
        "/api/video/ViewCountAdd", token, videoID);
  }


  Future<Response> reelCountUp(
      String token, String reel_id, ) async {
    return apiClient.reelCountUp(
        "/api/reel/ViewCountAdd", token, reel_id);
  }
  Future<Response> timelineCountUp(
      String token, String timelineID, ) async {
    return apiClient.timelineCountUp(
        "/api/timeline/ViewCountAdd", token, timelineID);
  }


  //api/video/updateVideoViewCount

  Future<Response> reelLikeDislike(
      String token, String reelID, String count) async {
    return apiClient.reelLikeDeslike(
        "/api/reel/updateReelLike", token, reelID, count);
  }

  Future<Response> timelineLikeDislike(
      String token, String post_timeline_id, String count) async {
    return apiClient.timelinelLikeDeslike(
        "/api/timeline/updatePostTimelineLike", token, post_timeline_id, count);
  }

  Future<Response> addVideoComments(
      String token, String videoID, String comment) async {
    return apiClient.addVideoComments(
        "/api/video/addVideoComment", token, videoID, comment);
  }

  Future<Response> addReelComments(
      String token, String reel_id, String comment) async {
    return apiClient.addReelComments(
        "/api/reel/addReelComment", token, reel_id, comment);
  }

  Future<Response> addTimeLineComments(
      String token, String timelineID, String comment) async {
    return apiClient.addTimelineComments(
        "/api/timeline/addTimelineComment", token, timelineID, comment);
  }


  // Future<Response> addTimelineComments(
  //     String token, String timeline_id, String comment) async {
  //   return apiClient.addTimelineComments(
  //       "/api/timeline/addTimelineComment", token, timeline_id, comment);
  // }

  Future<Response> getVideoAllComments(
      String videoID,String? token
      ) async {
    return apiClient
        .getVideoAllComments("/api/video/getVideoComments/$videoID",token!);
  }

  Future<Response> getReelAllComments(
      String reelID
      ) async {
    return apiClient.getReelAllComments("/api/reel/getReelComments/$reelID");
  }

  Future<Response> getTimelineComments(
      String timelineID,String? token
      ) async {
    return apiClient.getTimelineAllComments("/api/timeline/getTimelineComments/$timelineID",token!);
  }

  Future<Response> subscribeRequest(String token, String subscriber_id) async {
    return apiClient.subscribeRequest("/api/subscribe/SubscribeRequest", token, subscriber_id);
  }
  Future<Response> unsubscribeRequest(String token, String subscriber_id) async {
    return apiClient.unsubscribeRequest("/api/subscribe/UnSubscribeRequest", token, subscriber_id);
  }


  Future<Response> getAllSubscriberslist(String token, ) async {
    return apiClient.getSubscribersList(
      "/api/subscribe/", token,);
  }

  Future<Response> getSubscriptionRequest(String token, ) async {
    return apiClient.getSubscriptionRequest(
      "/api/subscribe/getSubscriptionRequest", token,);
  }



  Future<Response> createCalendar(String token, String time,String price,String type,String date) async {
    return apiClient.createCalendar("/api/user/Createcalendar", token,time,price,type,date );
  }

  Future<Response> getSpecialDateList(String token, ) async {
    return apiClient.getSpecialDateList("/api/user/GetSpecialEntries", token, );
  }

  Future<Response> getNormalPriceList(String token, ) async {
    return apiClient.getNormalPriceList("/api/user/GetNormalEntries", token, );
  }



  Future<Response> findPriceByDateTime(String token,String date,  String time, String user_id) async {
    return apiClient.findPriceByDateTime("/api/user/FindPriceByDateTime", token,date,time,user_id);
  }

  Future<Response> applyJob(String token, String job_id) async {
    return apiClient.applyJob("/api/job/appliedPostJob", token, job_id);
  }

  Future<Response> updateMyJobStatus(String token, String job_id,int job_status) async {
    return apiClient.updateMyJobStatus("/api/job/updateJobStatus", token, job_id,job_status);
  }





  Future<Response> getAppliedUsersList(String token,String jobID) async {
    debugPrint("jobID:${jobID}");
    return apiClient.getAppliedusersList("/api/job/getAppliedUsers/$jobID",token);
  }

  Future<Response> getFreiendsList(String token) async {
    return apiClient.getFreindsList("/api/myfriend",token);
  }

  Future<Response> getFreiendsRequestList(String token) async {
    return apiClient.getFreindsRequestsList("/api/myfriend/getMyFriendsrequests",token);
  }
  Future<Response> getFreindsAddList(String token) async {
    return apiClient.getFreindsAddList("/api/myfriend/getMyFriendsAdd",token);
  }


  //api/myfriend/getMyFriendsAdd

  Future<Response> acceptFriendRequest(String token,friend_id,String status,String? notificetion_id) async {
    return apiClient.acceptFriendRequest("/api/myfriend/AcceptFriendRequest",token,friend_id,status,notificetion_id);
  }

  Future<Response> getNotiID(String sender_id,String type,String? token) async {
    return apiClient.getNotiID("/api/user/getNotificationId",sender_id,type,token!);
  }


  //api/myfriend/getMyFriendsrequests

  Future<Response> uploadVideo(
      String token,
      String category_id,
      String description,
      String title,
      String? thumbnail_key,
      String video_key
      ) async {
    return apiClient.uploadVideo(
        "/api/video/uploadVideos", token, category_id, description, title,thumbnail_key!,video_key);
  }

  Future<Response> uploadReel(
      String token,
      String category_id,
      String description,
      String title,
      String reels_key,
      String? thumbnail_key

      ) async {
    return apiClient.uploadReel(
        "/api/reel/uploadReel", token, category_id, description, title,reels_key,thumbnail_key!);
  }

  Future<Response> seSitesFromAllotment(
      String token,
      ) async {
    return apiClient.seSitesFromAllotment(
        "${AppEndPoints.SESitesFromAllotment}", token);
  }


  Future<Response> seHomeReport(String token,String siteId) async {
    return await apiClient.seHomeReport(AppEndPoints.seSitesHomePage, token,siteId);
  }

  Future<Response> uploadSelfi(String token,String siteId,File file) async {
    return await apiClient.uploadSelfi(AppEndPoints.UPLOAD_SELFI, token,siteId,file);
  }


//api/job/getPaginatedJob/1
}

