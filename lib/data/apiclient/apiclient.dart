import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/foundation.dart'; // For debugPrint

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';

class ApiClient extends GetConnect implements GetxService {
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  final uuid = Uuid();

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 10);
    _mainHeaders = {"content-type": "application/json; charset=UTF-8"};
  }

  //login
  Future<Response> login(
    String url,
    Map mybody,
  ) async {
    Map data;

    if(mybody["mobile"].toString()=="1111111110"){
      data = {
        "mobile": mybody["mobile"].toString(),
        "password": mybody["password"].toString(),
        "deviceId": "111111",
        "firebase_token":mybody["firebase_token"].toString()
      };
    }else{
      data = {
        "mobile": mybody["mobile"].toString(),
        "password": mybody["password"].toString(),
        "deviceId": mybody["deviceId"].toString(),
        "firebase_token":mybody["firebase_token"].toString()
      };
    }




    // else {
    //   debugPrint("firebase_token"+"${mybody["firebase_token"].toString()}");
    //   data = {
    //     "mobile": mybody["mobile"].toString(),
    //     "password": mybody["password"].toString(),
    //     "deviceId": mybody["deviceId"].toString(),
    //     "firebase_token":mybody["firebase_token"].toString()
    //   };
    // }

    //encode Map to JSON
    var body = json.encode(data);

    // FormData formData = FormData({
    //   "mobile": body["mobile"].toString(),
    //   "password": body["password"].toString()
    // });

    try {
      var res = await post(url, body);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> resendOtp(String url, String mobile) async {
    try {
      // FormData formData = new FormData({"email": email.toString()});
      Map data = {
        "mobile": mobile,
      };
      var res = post(url, data);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> saveFirebaseToken(
      String url, String token, String fToken) async {
    try {
      // FormData formData = new FormData({"email": email.toString()});
      Map data = {
        "token": fToken,
      };
      var res = post(url, data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //signup

  Future<Response> signUp(
    String url,
    String fname,
    String mobile,
    String password,
    String deviceId,
  ) async {
    try {
      Map data = {
        "full_name": fname,
        "mobile": mobile,
        "password": password,
        "deviceId": deviceId
      };
      debugPrint("signup" + data.toString());
      var res = await post(url, data);
      return res;
    } catch (e) {
      debugPrint("signup_error" + e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> SignupAndUpoadImage({
    required String url,
    required File file,
    required String fullName,
    required String mobile,
    required String password,
    required String deviceId,
    required String email,
    required String address,
    String? firebase_token
  }) async {
    debugPrint("njdebug:$url}");
    debugPrint("njdebug:$MultipartFile}");
    debugPrint("njdebug:$fullName}");
    debugPrint("njdebug:$deviceId}");
    debugPrint("njdebug:$email}");
    debugPrint("njdebug:$address}");
    debugPrint("njdebug:$firebase_token}");
    FormData formData = FormData({
      'file': MultipartFile(file, filename: 'image.jpg'),
      'full_name': fullName,
      'mobile': mobile,
      'password': password,
      'deviceId': deviceId,
      'email': email,
      'address': address,
      "firebase_token":  firebase_token??""
    });

    Response response = await post(url, formData);

    debugPrint("njdebuge:${response.bodyString}}");
    return response;
  }

  Future<Response> PostJob(
      String url, String cid, String des, String token, String title) async {
    try {
      //debugPrint("njtest"+body.toString());

      Map data = {
        "title": title,
        "category_id": cid,
        "description": des,
      };

      var res = await post(url, data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      print("Abhi api respone check : ${res.bodyString}");
      return res;
    } catch (e) {
      debugPrint("signup_error" + e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //api/user/updateUserWatchTime

  Future<Response> UpdateWatchTime(
    String url,
    String time,
    String token,
  ) async {
    try {
      //debugPrint("njtest"+body.toString());
      //debugPrint("first letter:${  AppConstant.capitalizeWords(title)}");
      Map data = {
        "time": time,
      };

      var res = await post(url, data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      debugPrint("signup_error" + e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> PostTimeline(
      String url, String cid, String des, String token, String title) async {
    try {
      //debugPrint("njtest"+body.toString());
      //debugPrint("first letter:${  AppConstant.capitalizeWords(title)}");
      Map data = {
        "title": title,
        "category_id": cid,
        "description": des,
      };

      var res = await post(url, data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      debugPrint("signup_error" + e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getCategoryIdByName(
      String url, String category_name, String token) async {
    try {
      //debugPrint("njtest"+body.toString());

      Map data = {
        "category_name": category_name,
      };

      var res = await post(url, data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      debugPrint("signup_error" + e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //api/timeline/uploadPostTimeline

  Future<Response> uploadProfile(List<File> file, String name) async {
    var mymap = <String, MultipartFile>{};
    for (int i = 0; i < file.length; i++) {
      mymap.update(
          "img${i}",
          (value) =>
              MultipartFile(file[i].path, filename: "image${i}:" + uuid.v1()));
    }
    mymap.update("name", (value) => MultipartFile(name, filename: name));

    try {
      var res = await post("api/profile_update", mymap);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> imageUploadKey(
      String url, String token, String profilePicKey) async {
    try {
      //debugPrint("njtest"+body.toString());

      Map data = {
        "profilePicKey": profilePicKey,
      };

      var res = await post(url, data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      debugPrint("signup_error" + e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //se

  Future<Response> submitReport(
      String url, String token, List<Map<String, String>> dataMap,
      [List<List<File>>? productImages]) async {
    try {
      // Prepare the data to be sent in the request

      debugPrint("njmap2:${dataMap}");
      debugPrint("njmap2:${productImages}");

      FormData formData = FormData({});
      if (productImages!.toString() == "[[], []]") {
        debugPrint("njform:called noimages");
        String siteId = "";

        for (var item in dataMap) {
          if (item.containsKey("site_id")) {
            siteId = item["site_id"]!;
          } else {
            formData.fields.add(MapEntry("product_id", item["product_id"]!));
            formData.fields.add(MapEntry("problem_id", item["problem_id"]!));
            formData.fields
                .add(MapEntry("current_value", item["current_value"]!));
          }
        }

        // Add site_id separately
        formData.fields.add(MapEntry("site_id", siteId));

        debugPrint("njmap22:$formData");
      } else {
        debugPrint("njform:called has images");
        // Create an instance of FormData

        String siteId = "";

        for (var item in dataMap) {
          if (item.containsKey("site_id")) {
            siteId = item["site_id"]!;
          } else {
            formData.fields.add(MapEntry("product_id", item["product_id"]!));
            formData.fields.add(MapEntry("problem_id", item["problem_id"]!));
            formData.fields
                .add(MapEntry("current_value", item["current_value"]!));
          }
        }

        // Add site_id separately
        formData.fields.add(MapEntry("site_id", siteId));

        // Process productImages and add them to formData
        int imageIndex = 1;
        for (var images in productImages) {
          if (images.isEmpty) {
            formData.fields.add(MapEntry("product_images_$imageIndex", ""));
          } else {
            for (var file in images) {
              String fileKey = "product_images_$imageIndex";
              formData.files.add(MapEntry(
                fileKey,
                MultipartFile(
                  file.path,
                  filename: file.path.split('/').last,
                ),
              ));
            }
          }
          imageIndex++;
        }

        debugPrint("formData: $formData");
      }

      // Send the POST request with Bearer token and form data
      //
      if (productImages!.toString() == "[[], []]") {
        debugPrint("njform:called noimages");
        final response = await post(
          url,
          formData,
          headers: {
            "Authorization": "Bearer $token",
          },
        );
        return response;
      } else {
        debugPrint("njform:called has images");
        final response = await post(
          url,
          formData,
          headers: {
            "Authorization": "Bearer $token",
          },
        );
        return response;
      }
    } catch (e) {
      debugPrint("njform:error:${e}");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getAllProblems(
      {required String url, required String token}) async {
    try {
      // FormData formData = new FormData({"email": email.toString()});

      var res = post(url, {
        "site_id": "6675168cd78fce5f007e8c13",
        "product_id": "66751400d78fce5f007e8bac",
        "problem_id": "6675298acd0a93c81cd3c096",
        "current_value": 1
      }, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> fillSEAttendance({
    required String token,
    required String url,
    required File file,
    required String date,
    required String time,
    required String siteId,
    required String entry,
    required String lat,
    required String long,
  }) async {
    // Create FormData object
    final formData = FormData({
      'file': MultipartFile(file, filename: 'image.jpg'),
      'date': date,
      'time': time,
      'site_id': siteId,
      'entry': entry,
      'lat': lat,
      'long': long,
    });

    // Set headers with Bearer token
    httpClient.addRequestModifier<void>((request) {
      request.headers['Authorization'] = 'Bearer $token';
      return request;
    });

    try {
      debugPrint(
          "Request data: $token $url $file $date $time $siteId $entry $lat $long");

      // Make POST request with form data
      final response = await post(url, formData);

      return response;
    } catch (e) {
      debugPrint("Error: $e");
      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  Future<Response> getSeSites(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> siteProducts(
      {required String url,
      required String token,
      required String site_id}) async {
    try {
      // FormData formData = new FormData({"email": email.toString()});
      Map data = {
        "site_id": site_id,
      };
      var res = post(
          url,
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          },
          data);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> svGetReport(
      {required String url,
      required String token,
      required String reportId}) async {
    try {
      // FormData formData = new FormData({"email": email.toString()});
      Map data = {
        "reportId": reportId,
      };
      var res = post(
          url,
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          },
          data);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //

//  api/user/profilePicKey
//postinwork and dental authentication process flow

//login->data->home page(if not verified then)->sent otp->otppage->verify->data->home page
//signup->otpsent->otppage->verify->data->homepage(user may left before verification)
//forgot password->otp sent->otppage->verify->create password->data->home page

//resend otp

//verify otp

  Future<Response> verifyOtp(String url, String mobile, String otp) async {
    // FormData formData = new FormData({"email": email, "otp": otp});
    Map data = {
      "mobile": mobile,
      "otp": otp,
    };
    try {
      var res = post(url, data);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> forgotPassword(
      String url, String mobile, String newpass, String otp) async {
    //FormData formData = new FormData({"email": email});
    Map data = {"newPassword": newpass, "mobile": mobile, "otp": otp};
    try {
      var res = post(url, data);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> changePassword(
      String url, String newpass, String token) async {
    //FormData formData = new FormData({"email": email});
    debugPrint("NJDEBUG pass:${newpass}");
    debugPrint("NJDEBUG token:${token}");

    Map data = {
      "newPassword": newpass,
    };
    try {
      var res = post(
        url,
        data,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> updateProfilePic(String url, File? pic, String token) async {
    //FormData formData = new FormData({"email": email});
    Map data = {
      "profilePic": pic != null ? base64Encode(pic!.readAsBytesSync()) : '',
    };
    try {
      var res = put(
        url,
        data,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //api/user/profilePicUpload

  Future<Response> createPassword(String url, String email, String password,
      String confirm_password) async {
    FormData formData = new FormData({
      "email": email,
      "password": password,
      "confirmpassword": confirm_password
    });

    try {
      var res = post(url, formData);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> uploadBankDetails(
      String url,
      String token,
      String name,
      String bankName,
      String accountNumber,
      String ifsc,
      String branchname) async {
    Map Data = {
      "name": name,
      "bankName": bankName,
      "accountNumber": accountNumber,
      "ifscCode": ifsc,
      "branchName": branchname,
    };

    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getBankDetails(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //api/user/bankdetailsUpload

  Future<Response> getProfile(String url, String token) async {
    debugPrint("mytoken" + token);
    try {
      var res =
    await  get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      print("sadfeff: ${res.bodyString}");
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getProfileUser(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getProfileReview(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getUrlImageUpload(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getMyVideos(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getMyReels(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getUserReels(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> addFriendRequest(
      String url, String token, String friend_id) async {
    Map Data = {
      "friend_id": friend_id,
    };
    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //api/products/GetChemicallist

  Future<Response> getUserVideos(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getUserTimeline(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getMyTimeline(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getnotification(String url) async {
    try {
      var res = get(url);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> updateProfile(String url, String token, Map databody) async {
    debugPrint("full_name" + databody["full_name"].toString());

    debugPrint("address" + databody["address"].toString());

    try {
      // var payload = {
      //   "full_name": body['full_name'],
      //
      // };
      //
      final body = jsonEncode({
        "full_name": databody['full_name'],
        "address": databody['address'],
        "email": databody['email'],
      });

      var res = post(
        url,
        body,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getBanner(String url) async {
    try {
      var res = get(url);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getAppointmentList(String url) async {
    try {
      var res = get(url);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //  'Authorization': 'Bearer $token',

  Future<Response> logout(String url, String token) async {
    try {
      var res = get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Cookie': 'Websitetoken=$token'
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> about_us(String url) async {
    try {
      var res = get(url);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getAllCategories(String url) async {
    try {
      var res = get(url);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getAllCategoriesNew(String url) async {
    try {
      var res = get(url);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getTrendingVideos(
      String url, String token, String? category_id, String? search) async {
    debugPrint("videodebug token" + "${token}");
    if (token == "null" || token == "") {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': "null",
      };
      try {
        var res = post(
          url,
          {"category_id": "${category_id ?? ""}", "search": "${search ?? ""}"},
        );
        return res;
      } catch (e) {
        return Response(statusCode: 1, statusText: e.toString());
      }
    } else {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      };
      try {
        var res = post(
            url,
            {
              "category_id": "${category_id ?? ""}",
              "search": "${search ?? ""}"
            },
            headers: myheader);
        return res;
      } catch (e) {
        return Response(statusCode: 1, statusText: e.toString());
      }
    }
  }

  Future<Response> getUserList(
      String url, String token, String? name, String? page) async {
    debugPrint("videodebug token" + "${token}");
    if (token == "null" || token == "") {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': "null",
      };
      try {
        var res = post(
          url,
          {"search": "${name ?? ""}", "page": "${int.parse(page ?? "1")}"},
        );
        return res;
      } catch (e) {
        return Response(statusCode: 1, statusText: e.toString());
      }
    } else {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      };
      try {
        var res = post(url,
            {"search": "${name ?? ""}", "page": "${int.parse(page ?? "1")}"},
            headers: myheader);
        return res;
      } catch (e) {
        return Response(statusCode: 1, statusText: e.toString());
      }
    }
  }

  Future<Response> getMyAllAppliedJobsList(
      String url, String token, String? category_id) async {
    if (token == "") {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': '',
      };
      try {
        var res = post(url, {"category_id": "${category_id ?? ""}"},
            headers: myheader);
        return res;
      } catch (e) {
        return Response(statusCode: 1, statusText: e.toString());
      }
    } else {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      };
      try {
        var res = post(url, {"category_id": "${category_id ?? ""}"},
            headers: myheader);
        return res;
      } catch (e) {
        return Response(statusCode: 1, statusText: e.toString());
      }
    }
  }

  Future<Response> reportPost(String url, String token, String? report_type,
      String type_id, String title, String description) async {
    if (token == "") {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': '',
      };
      try {
        var res = post(
            url,
            {
              "report_type": "${report_type}",
              "type_id": "${type_id}",
              "title": "${title}",
              "description": "${description}"
            },
            headers: myheader);
        return res;
      } catch (e) {
        return Response(statusCode: 1, statusText: e.toString());
      }
    } else {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      };
      try {
        var res = post(
            url,
            {
              "report_type": "${report_type}",
              "type_id": "${type_id}",
              "title": "${title}",
              "description": "${description}"
            },
            headers: myheader);
        return res;
      } catch (e) {
        return Response(statusCode: 1, statusText: e.toString());
      }
    }
  }

  Future<Response> getTrendingJobs(
      String url, String token, String? category_id, String? search) async {
    if (token == "null" || token == "") {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': '',
      };
      try {
        var res = post(
            url,
            {
              "category_id": "${category_id ?? ""}",
              "search": "${search ?? ""}",
            },
            headers: myheader);
        return res;
      } catch (e) {
        // if (EasyLoading.isShow) {
        //   EasyLoading.dismiss();
        // }
        return Response(statusCode: 1, statusText: e.toString());
      }
    } else {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      };
      try {
        var res = post(
            url,
            {
              "category_id": "${category_id ?? ""}",
              "search": "${search ?? ""}"
            },
            headers: myheader);
        return res;
      } catch (e) {
        // if (EasyLoading.isShow) {
        //   EasyLoading.dismiss();
        // }

        return Response(statusCode: 1, statusText: e.toString());
      }
    }
  }

  Future<Response> getMyAllJobsPostedList(
      String url, String token, String? category_id) async {
    if (token == "") {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': '',
      };
      try {
        var res = post(url, {"category_id": "${category_id ?? ""}"},
            headers: myheader);
        return res;
      } catch (e) {
        return Response(statusCode: 1, statusText: e.toString());
      }
    } else {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      };
      try {
        var res = post(url, {"category_id": "${category_id ?? ""}"},
            headers: myheader);
        return res;
      } catch (e) {
        return Response(statusCode: 1, statusText: e.toString());
      }
    }
  }

  Future<Response> getTrendingTimeline(
      String url, String token, String? category_id, String? search) async {
    if (token == "null" || token == "") {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': '',
      };
      try {
        var res = post(
          url,
          {},
        );
        return res;
      } catch (e) {
        return Response(statusCode: 1, statusText: e.toString());
      }
    } else {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      };
      try {
        var res = post(
            url,
            {
              "category_id": "${category_id ?? ""}",
              "search": "${search ?? ""}"
            },
            headers: myheader);
        return res;
      } catch (e) {
        return Response(statusCode: 1, statusText: e.toString());
      }
    }
  }

  Future<Response> getTrendingReels(
      String url, String token, String? category_id, String? search) async {
    debugPrint("videodebug token" + "${token}");
    debugPrint("videodebug category_id" + "${category_id}");
    if (token == "null" || token == "") {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': '',
      };
      try {
        var res = post(url, {
          "category_id": "${category_id ?? ""}",
          "search": "${search ?? ""}"
        });
        return res;
      } catch (e) {
        return Response(statusCode: 1, statusText: e.toString());
      }
    } else {
      var myheader = {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      };
      try {
        var res = post(
            url,
            {
              "category_id": "${category_id ?? ""}",
              "search": "${search ?? ""}"
            },
            headers: myheader);
        return res;
      } catch (e) {
        return Response(statusCode: 1, statusText: e.toString());
      }
    }
  }

  Future<Response> getHireList(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getMyWorkList(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getVideoUploadkey(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getReelUploadkey(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getImageUploadkey(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getNotificationsList(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getTimeLineList(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> ContactUS(String url, String token, String name,
      String email_id, String mobile_no, String message) async {
    Map Data = {
      "name": name,
      "email_id": email_id,
      "mobile_number": mobile_no,
      "message": message,
    };

    var body = jsonEncode({
      'name': name,
      'email_id': email_id,
      'mobile_number': mobile_no,
      'message': message,
    });

    debugPrint("njdata:${token}");

    try {
      var res = post(url, body, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> updateHireStatus(
      String url, String token, String _id, String status) async {
    Map Data = {
      "_id": _id,
      "status": status,
    };

    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> videoLikeDeslike(
    String url,
    String token,
    String videoID,
    String count,
  ) async {
    Map Data = {
      "video_id": videoID,
      "count": count,
    };

    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> videoCountUp(
    String url,
    String token,
    String videoID,
  ) async {
    Map Data = {
      "videoId": videoID,
    };

    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> reelCountUp(
    String url,
    String token,
    String reel_id,
  ) async {
    Map Data = {
      "Reels_Id": reel_id,
    };

    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> timelineCountUp(
    String url,
    String token,
    String reel_id,
  ) async {
    Map Data = {
      "timelineId": reel_id,
    };

    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> reelLikeDeslike(
    String url,
    String token,
    String reelID,
    String count,
  ) async {
    Map Data = {
      "reel_id": reelID,
      "count": count,
    };

    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> timelinelLikeDeslike(
    String url,
    String token,
    String post_timeline_id,
    String count,
  ) async {
    Map Data = {
      "post_timeline_id": post_timeline_id,
      "count": count,
    };

    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> addVideoComments(
    String url,
    String token,
    String videoID,
    String comment,
  ) async {
    Map Data = {
      "video_id": videoID,
      "comment": comment,
    };

    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> addReelComments(
    String url,
    String token,
    String reel_id,
    String comment,
  ) async {
    Map Data = {
      "reel_id": reel_id,
      "comment": comment,
    };

    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> addTimelineComments(
    String url,
    String token,
    String timeline_id,
    String comment,
  ) async {
    Map Data = {
      "timeline_id": timeline_id,
      "comment": comment,
    };

    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteVideo(
    String url,
    String token,
    String videoID,
  ) async {
    Map Data = {
      "video_id": videoID,
    };

    try {
      var res = delete(url, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response<T>> deleteReel<T>(
      String url, String token, String reelId) async {
    try {
      var res = await delete<T>(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response<T>(statusCode: 1, statusText: e.toString());
    }
  }

  // Future<Response> deleteReel(String url,
  //     String token,
  //     String reel_id,) async {
  //
  //
  //   try {
  //     var res = delete(url,query: {
  //     "reel_id": reel_id,
  //     }, headers: {
  //       "Content-Type": "application/json",
  //       'Authorization': 'Bearer $token',
  //     },);
  //     return res;
  //   } catch (e) {
  //     return Response(statusCode: 1, statusText: e.toString());
  //   }
  // }

  Future<Response> getVideoAllComments(String url, String? token) async {
    debugPrint("videotoken:${token}");
    try {
      if (token == null || token == "") {
        debugPrint("videotoken:${token} is null ");
        var res = get(url);
        return res;
      } else {
        debugPrint("videotoken:${token} not null");
        var res = get(url, headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        });
        return res;
      }
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getReelAllComments(
    String url,
  ) async {
    try {
      var res = get(url);
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getTimelineAllComments(String url, String token) async {
    try {
      if (token == null || token == "") {
        var res = get(
          url,
        );
        return res;
      } else {
        var res = get(url, headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        });
        return res;
      }
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> subscribeRequest(
    String url,
    String token,
    String subscriber_id,
  ) async {
    Map Data = {
      "subscriber_id": subscriber_id,
    };
    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> unsubscribeRequest(
    String url,
    String token,
    String subscriber_id,
  ) async {
    Map Data = {
      "subscriber_id": subscriber_id,
    };
    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> applyJob(
    String url,
    String token,
    String job_id,
  ) async {
    Map Data = {
      "job_id": job_id,
    };
    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> updateMyJobStatus(
      String url, String token, String job_id, int job_status) async {
    Map Data = {"job_id": job_id, "job_status": job_status};
    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> uploadVideo(
      String url,
      String token,
      String category_id,
      String description,
      String title,
      String? thumbnail_key,
      String video_key) async {
    Map Data = {
      "category_id": category_id,
      "description": description,
      "title": title,
      "thumbnail_key": thumbnail_key == null ? null : thumbnail_key,
      "video_key": video_key
    };
    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> uploadReel(
      String url,
      String token,
      String category_id,
      String description,
      String title,
      String reels_key,
      String? thumbnail_key) async {
    Map Data = {
      "category_id": category_id,
      "description": description,
      "title": title,
      "reels_key": reels_key,
      "thumbnail_key": thumbnail_key == null ? null : thumbnail_key
    };
    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> createCalendar(
    String url,
    String token,
    String time,
    String price,
    String type,
    String date,
  ) async {
    Map Data = {"time": time, "price": price, "type": type, "date": date};
    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> addReview(
    String url,
    String token,
    String review_id,
    String review_number,
    String description,
    String hire_list_id,
  ) async {
    Map Data = {
      "review_id": review_id,
      "review_number": review_number,
      "description": description,
      "hire_list_id": hire_list_id
    };
    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

//createHire

  Future<Response> createHire(String url, String token, String hire_id,
      String amount, String calendar_id) async {
    Map Data = {
      "hire_id": hire_id,
      "amount": amount,
      "calendar_id": calendar_id,
    };
    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getSpecialDateList(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getNormalPriceList(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getFreindsList(String url, String token) async {
    try {
      var res = post(
        url,
        {},
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> acceptFriendRequest(String url, String token,
      String friend_id, String status, String? notificetion_id) async {
    Map Data = {
      "friend_id": friend_id,
      "status": int.parse(status),
      "notificetion_id": notificetion_id!,
    };

    debugPrint("njdebug friend_id:" + "${friend_id}");
    debugPrint("njdebug status:" + "${status}");
    debugPrint("njdebug notificetion_id:" + "${notificetion_id!}");

    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getNotiID(
    String url,
    String sender_id,
    String type,
    String token,
  ) async {
    Map Data = {
      "sender_id": sender_id,
      "type": type,
    };

    debugPrint("njdebug sender_id:" + "${sender_id}");
    debugPrint("njdebug type:" + "${type}");

    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getFreindsRequestsList(String url, String token) async {
    try {
      var res = post(
        url,
        {},
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getFreindsAddList(String url, String token) async {
    try {
      var res = post(
        url,
        {},
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //api/myfriend/getMyFriendsrequests

  Future<Response> findPriceByDateTime(String url, String token, String date,
      String time, String user_id) async {
    Map Data = {
      "date": date,
      "time": time,
      "user_id": user_id,
    };
    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> uploadImage(
    String url,
    String token,
    String profilePicKey,
  ) async {
    Map Data = {"profilePicKey": profilePicKey};
    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getSubscribersList(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getSubscriptionRequest(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getAppliedusersList(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getChatList(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> fetchAllMsgs(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //api/message/65abbb447650743b85a77502
  Future<Response> getAllMessages(String url, String token) async {
    try {
      var res = get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> createChatList(
      String url, String token, String userId) async {
    Map Data = {
      "userId": userId,
    };

    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> sendMessage(
      String url, String token, String chatId, String content) async {
    Map Data = {"chatId": chatId, "content": content};

    try {
      var res = post(url, Data, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getChemicalList(
      String url, String token, String siteID) async {
    try {
      var res =
      await post(url, {
        "site_id": "${siteID}"
      }, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      print("Abhichecklist: ${res.bodyString}");
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> updateChemicalList(String url, String token, String siteID,
      String productID, String used_qty) async {
    try {
      debugPrint("chemi: ${token}    ${siteID}   ${productID}    ${used_qty} ");
      Map map = {
        "site_id": siteID,
        "product_id": productID,
        "used_qty": used_qty
      };

      var res = post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      print("Abhi check list : ${res}");
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

//api/video/addVideoComment
//sv

  Future<Response> getSiteData(String url, String token, String userId) async {
    try {
      var res = post(url, {
        "userId": "${userId}"
      }, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getClientEmails(
      String url, String token, String site_id) async {
    try {
      Map map = {"site_id": site_id};
      var res = post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> sendClientEmail(
      String url, String token, String _id, String email) async {
    try {
      Map map = {"_id": _id, "email": email};
      var res = post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> verifyOtpEmail(
      String url, String token, String _id, String otp) async {
    try {
      Map map = {"_id": _id, "otp": otp};
      var res = post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> seSitesFromAllotment(
    String url,
    String token,
  ) async {
    try {
      var res = get(url, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getSiteProducts(
    String url,
    String token,
    String site_id,
  ) async {
    try {
      debugPrint("njjj:called$token $site_id}");
      Map map = {"site_id": site_id};
      var res = post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postWorkingType(
      String url,
      String token,
      String site_id,
      String product_id,
      String working_type,
      String? product_report_id,
      String? report_id) async {
    try {
      debugPrint("typefill:site_id $site_id}");
      debugPrint("typefill:product_id $product_id}");
      debugPrint("typefill:working_type$working_type}");
      debugPrint("typefill:product_report_id $product_report_id}");
      debugPrint("typefill:report_id $report_id}");
      Map<String, String> map;
      if (product_report_id != null && report_id != null) {
        map = {
          "site_id": site_id,
          "product_id": product_id,
          "working_type": working_type,
          "product_report_id": product_report_id,
          "report_id": report_id
        };
      } else {
        map = {
          "site_id": site_id,
          "product_id": product_id,
          "working_type": working_type
        };
      }

      var res = await post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });

      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getNotEmptyValues(
    String url,
    String token,
    String site_id,
  ) async {
    try {
      debugPrint("njjj:called$token $site_id}");
      Map map = {
        "site_id": site_id,
      };
      var res = post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getSeEditImages(
    String url,
    String token,
    String site_id,
  ) async {
    try {
      debugPrint("njjj:called$token $site_id}");
      Map map = {
        "site_id": site_id,
      };
      var res = post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postCorrectValues(
    String url,
    String token,
    String site_id,
    String product_id,
    String product_report_id,
    String current_value,
  ) async {
    try {
      debugPrint(
          "njjjres:called $token $site_id $product_report_id  $current_value  $product_id}");
      Map map = {
        "site_id": site_id,
        "product_id": product_id,
        "product_report_id": product_report_id,
        "current_value": current_value,
      };
      var res = post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> finalFormSubmit(
    String url,
    String token,
    String report_id,
  ) async {
    try {
      debugPrint("njjj:called$token $report_id}");
      Map map = {
        "report_id": report_id,
      };
      var res = post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> seHomeReport(
    String url,
    String token,
    String siteID,
  ) async {
    try {
      debugPrint("njjj:called$token $siteID}");
      Map map = {
        "site_id": siteID,
      };
      var res = post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //api/se/getReportHomePage
  Future<Response> addImages(String url, String token, String site_id,
      String product_id, String product_report_id, String problem_id,
      [int? imageIndex, List<File>? productImages]) async {
    try {
      // debugPrint("end point data:${site_id}");
      // debugPrint("end point data:${product_id}");
      // debugPrint("end point data:${product_report_id}");
      // debugPrint("end point data:${problem_id}");
      // debugPrint("end point data imageIndex:${imageIndex}");
      // debugPrint("end point data:${filePaths}");
      FormData formData = FormData({});

      formData.fields.add(MapEntry("site_id", site_id));
      formData.fields.add(MapEntry("product_id", product_id));
      formData.fields.add(MapEntry("product_report_id", product_report_id));
      formData.fields.add(MapEntry("problem_id", problem_id));

      //
      debugPrint("end point data imageIndex:${imageIndex}");
      debugPrint("end point data productImages:${productImages}");

      if (imageIndex == 0) {
        debugPrint("end point data productImages:index 0");
        if (productImages.toString() == "[]") {
          for (int i = 0; i < 3; i++) {
            formData.fields.add(MapEntry("image_$i", ""));
            debugPrint("end point data productImages:null added");
          }
        } else {
          debugPrint("end point data productImages:not null");

          for (int i = 0; i < productImages!.length; i++) {
            await Future.delayed(Duration(milliseconds: 500));
            String fileKey = "image_$i";
            formData.files.add(MapEntry(
              fileKey,
              MultipartFile(
                productImages![i].path,
                filename: productImages![i].path.split('/').last,
              ),
            ));
          }
        }
      }
      if (imageIndex == 1) {
        debugPrint("end point data productImages:index 1");
        if (productImages.toString() == "[]") {
          for (int i = 0; i < 3; i++) {
            formData.fields.add(MapEntry("image_$i", ""));
          }
        } else {
          for (int i = 0; i < productImages!.length; i++) {
            await Future.delayed(Duration(milliseconds: 500));
            String fileKey = "image_$i";
            formData.files.add(MapEntry(
              fileKey,
              MultipartFile(
                productImages![i].path,
                filename: productImages![i].path.split('/').last,
              ),
            ));
          }
        }
      }
      if (imageIndex == 2) {
        debugPrint("end point data productImages:index 2");
        if (productImages.toString() == "[]") {
          for (int i = 0; i < 3; i++) {
            formData.fields.add(MapEntry("image_$i", ""));
          }
        } else {
          for (int i = 0; i < productImages!.length; i++) {
            await Future.delayed(Duration(milliseconds: 500));
            String fileKey = "image_$i";
            formData.files.add(MapEntry(
              fileKey,
              MultipartFile(
                productImages![i].path,
                filename: productImages![i].path.split('/').last,
              ),
            ));
          }
        }
      }

      var res = post(url, formData, headers: {
        'Authorization': 'Bearer $token',
      });
      res.then((onValue) {
        debugPrint("Response status:${(onValue.bodyString)}");
      });

      return res;
    } catch (e) {
      debugPrint("Exception: ${e.toString()}");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> sveditaddImages(
      String url,
      String token,
      String site_id,
      String product_id,
      String product_report_id,
      String problem_id,
      String solution,
      String problem_covered,
      [int? imageIndex,
      List<File>? productImages]) async {
    try {
      debugPrint("end point data site_id:${site_id}");
      debugPrint("end point data product_id:${product_id}");
      debugPrint("end point data product_report_id:${product_report_id}");
      debugPrint("end point data problem_id:${problem_id}");
      debugPrint("end point data imageIndex:${imageIndex}");
      debugPrint("end point data productImages:${productImages}");
      debugPrint("end point data solution:${solution}");
      debugPrint("end point data problem_covered:${problem_covered}");
      FormData formData = FormData({});

      formData.fields.add(MapEntry("site_id", site_id));
      formData.fields.add(MapEntry("product_id", product_id));
      formData.fields.add(MapEntry("product_report_id", product_report_id));
      formData.fields.add(MapEntry("problem_id", problem_id));
      formData.fields.add(MapEntry("solution", solution));
      formData.fields.add(MapEntry("problem_covered", problem_covered));

      //solution//problem_covered
      debugPrint("end point data imageIndex:${imageIndex}");
      debugPrint("end point data productImages:${productImages}");

      if (imageIndex == 0) {
        debugPrint("end point data productImages:index 0");
        if (productImages.toString() == "[]") {
          for (int i = 0; i < 3; i++) {
            formData.fields.add(MapEntry("image_$i", ""));
            debugPrint("end point data productImages:null added");
          }
        } else {
          debugPrint("end point data productImages:not null");

          for (int i = 0; i < productImages!.length; i++) {
            await Future.delayed(Duration(milliseconds: 500));
            String fileKey = "image_$i";
            formData.files.add(MapEntry(
              fileKey,
              MultipartFile(
                productImages![i].path,
                filename: productImages![i].path.split('/').last,
              ),
            ));
          }
        }
      }
      if (imageIndex == 1) {
        debugPrint("end point data productImages:index 1");
        if (productImages.toString() == "[]") {
          for (int i = 0; i < 3; i++) {
            formData.fields.add(MapEntry("image_$i", ""));
          }
        } else {
          for (int i = 0; i < productImages!.length; i++) {
            await Future.delayed(Duration(milliseconds: 500));
            String fileKey = "image_$i";
            formData.files.add(MapEntry(
              fileKey,
              MultipartFile(
                productImages![i].path,
                filename: productImages![i].path.split('/').last,
              ),
            ));
          }
        }
      }
      if (imageIndex == 2) {
        debugPrint("end point data productImages:index 2");
        if (productImages.toString() == "[]") {
          for (int i = 0; i < 3; i++) {
            formData.fields.add(MapEntry("image_$i", ""));
          }
        } else {
          for (int i = 0; i < productImages!.length; i++) {
            await Future.delayed(Duration(milliseconds: 500));
            String fileKey = "image_$i";
            formData.files.add(MapEntry(
              fileKey,
              MultipartFile(
                productImages![i].path,
                filename: productImages![i].path.split('/').last,
              ),
            ));
          }
        }
      }

      var res = post(url, formData, headers: {
        'Authorization': 'Bearer $token',
      });
      res.then((onValue) {
        debugPrint("Response status:${(onValue.bodyString)}");
      });

      return res;
    } catch (e) {
      debugPrint("Exception: ${e.toString()}");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> editProductGet(
    String url,
    String token,
    String site_id,
  ) async {
    try {
      debugPrint("njjj:called$token $site_id}");
      Map map = {
        "site_id": site_id,
      };
      var res = post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //svadd
  Future<Response> getSvSites(
    String url,
    String token,
  ) async {
    try {
      var res = get(url, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //svadd
  Future<Response> getSolByproblem(
      String url, String token, String problem_Id) async {
    try {
      Map map = {"problem_Id": problem_Id};

      var res = post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> GetSloutions(
    String url,
    String token,
    String problem_Id,
  ) async {
    try {
      debugPrint("njjj:called$token $problem_Id}");
      Map map = {
        "problem_Id": problem_Id,
      };
      var res = post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> uploadSelfi(
      String url, String token, String site_id, File? images) async {
    try {
      // Prepare the data to be sent in the request

      FormData formData = FormData({});
      formData.fields.add(MapEntry("site_id", site_id));
      if (images == null) {
        formData.fields.add(MapEntry("selfie", ""));
      } else {
        String fileKey = "selfie";
        formData.files.add(MapEntry(
          fileKey,
          MultipartFile(
            images.path,
            filename: images.path.split('/').last,
          ),
        ));
      }

      debugPrint("formData: ${formData.fields.toString()}");

      final response = await post(
        url,
        formData,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      return response;
    } catch (e) {
      debugPrint("njform:error:${e}");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> ApplyForLeave(
      String url, String token, String start_date,String end_date,String reason ) async {
    try {
      Map map = {"start_date": start_date,"end_date":end_date,"reason":reason};

      var res = post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }


  Future<Response> ApplyForResignation(
      String url, String token, String last_date_working,String reason, ) async {
    try {
      Map map = {"last_date_working": last_date_working,"reason":reason};

      var res = post(url, map, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      });
      return res;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

//
}
