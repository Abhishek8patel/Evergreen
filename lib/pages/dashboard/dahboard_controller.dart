import 'dart:convert';
import 'dart:io';
import '../../../Utills3/utills.dart';
import 'package:testingevergreen/others/normal_res_dto.dart' as MyrRes;
import 'package:testingevergreen/pages/SE/se_models/seHomeReport.dart'
    as HomeReport;

import 'package:testingevergreen/pages/dashboard/selfi_res.dart' as SelfiDTO;
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
// import 'package:testingevergreen/Utills/endpoints.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:get/get.dart';
import '';
import '../../Utills3/endpoints.dart';
import '../../data/repository/user_repo.dart';
import 'package:testingevergreen/pages/SV/SeSitesFromAllotmentDTO.dart'
    as SVSITEDTO;

import 'package:intl/intl.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
enum LocationStatus {
  fetching,
  available,
  denied,
  disabled,
  error,
}

enum loadingNJ { started, loading, finished }

class DashboardController extends GetxController {
  final UserRepo userRepo;

  DashboardController({required this.userRepo});

  //sv

  RxBool noreport = false.obs;
  RxList<SVSITEDTO.Site> svsitesList = <SVSITEDTO.Site>[].obs;



RxList<String> listOfsiteIds=<String>[].obs;
  RxString _current_date = "".obs;

  RxString get current_date => _current_date;

  RxInt currentIndex = 0.obs;


  RxString _current_time = "".obs;

  RxString get currentTime=>_current_time;
  RxString siteID = "".obs;

  RxString user_role = "".obs;

  RxBool _newNototifiaction = false.obs;

  LocationStatus _location_sta = LocationStatus.fetching;

  LocationStatus get location_sta => _location_sta;

  RxBool get newNotification => _newNototifiaction;

  RxBool isSubmitTimeRange=false.obs;

  final util = Utills();

  RxString _lattitude = "".obs;

  RxString userToken = "".obs;

  RxString get lattitude => _lattitude;

  RxString _longitude = "".obs;

  RxString get longitude => _longitude;

  RxString uid = "".obs;

  RxBool viewOnly=false.obs;

  RxString locationMSG = "".obs;
  RxBool _hasLocation = false.obs;

  RxString? currentSiteID = "".obs;
  RxString userpic = "".obs;

  RxString user_token = "".obs;

  RxBool get hasLocation => _hasLocation;

  Rx<loadingNJ> process = loadingNJ.started.obs;

  RxString lastSubmittedReport = "".obs;
  RxString userName = "".obs;

  // getnotifiaction() async {
  //   Future.delayed(Duration(seconds: 5), () {
  //     _newNototifiaction.value = true;
  //   });
  // }

  setRedDot(value) {
    _newNototifiaction.value = value;
    _newNototifiaction.refresh();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  } //category

  Future<LocationStatus?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    process.value = loadingNJ.started;
    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationMSG.value = "Location services are disabled.";
      process.value = loadingNJ.finished;
      return _location_sta = LocationStatus.disabled;
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        locationMSG.value = "Location permissions are denied.";
        process.value = loadingNJ.finished;
        return _location_sta = LocationStatus.denied;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      locationMSG.value = "Location permissions are permanently denied.";
      process.value = loadingNJ.finished;
      return _location_sta = LocationStatus.error;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    locationMSG.value =
        "Latitude: ${position.latitude}, Longitude: ${position.longitude}";

    _lattitude.value = position.latitude.toString();
    _longitude.value = position.longitude.toString();

    _lattitude.refresh();
    _longitude.refresh();

    process.value = loadingNJ.finished;

    return _location_sta = LocationStatus.available;
  }

  Future<DateTime> fetchDateTime() async {
    // Use the Asia/Kolkata timezone for India
    final response = await http
        .get(Uri.parse('http://worldtimeapi.org/api/timezone/Asia/Kolkata'));

    if (response.statusCode == 200) {
      // Parse the JSON response to get the date and time
      final data = json.decode(response.body);
      final dateTimeString = data['datetime'];
      DateTime utcDateTime = DateTime.parse(dateTimeString);

      // Initialize timezone data
      tz.initializeTimeZones();
      final india = tz.getLocation('Asia/Kolkata');
      final localDateTime = tz.TZDateTime.from(utcDateTime, india);

      String formattedDate = DateFormat('dd-MM-yyyy').format(localDateTime);
      String formattedTime = DateFormat('hh:mm a').format(localDateTime);

      _current_date.refresh();
      _current_time.refresh();

      _current_date.value = formattedDate;
      _current_time.value = formattedTime;

      // Assuming util.showSnackBar is defined elsewhere in your code
      // util.showSnackBar("Alert", "$formattedDate $formattedTime", true);
      return localDateTime;
    } else {
      // Assuming util.showSnackBar is defined elsewhere in your code
      util.showSnackBar("Alert", "Failed to load date and time", false);
      throw Exception('Failed to load date and time');
    }
  }

  Future<MyrRes.NormalResponse?> uploadImage(
      File imageFile, String userId) async {
    // Replace with your server's upload URL
    final uri =
        Uri.parse('${AppConstant.BASE_URL}${AppEndPoints.edit_image_upload}');

    var request = http.MultipartRequest('POST', uri);

    // Add the image file to the request
    var multipartFile = await http.MultipartFile.fromPath(
      'file',
      imageFile.path,
    );
    //request.fields['userId'] = userId;
    request.files.add(multipartFile);

    //request.fields['param1'] = 'value1';

    var response = await request.send();

    if (response.statusCode == 200) {
      util.showSnackBar("Alert", "Image has uploaded successfully", true);
      print('Image ss: ${response.statusCode}');
      return MyrRes.NormalResponse(message: "ok", status: true);

    } else {
      print('Image upload failed: ${response.statusCode}');
      print('Image upload failed: ${response.reasonPhrase}');
      return MyrRes.NormalResponse(message: "ok", status: false);
    }
  }

  Future<SVSITEDTO.SeSitesFromAllotment?> getSvSites(String token) async {
    final res = await userRepo.seSitesFromAllotment(token);
    debugPrint("sesites:called");
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("sesites:200");
      debugPrint("sesites:${res.bodyString}");
      final temp = SVSITEDTO.seSitesFromAllotmentFromJson(res.bodyString!);

      if (temp.userData.isNotEmpty) {
        if (temp.userData.first.sites.isNotEmpty) {
          svsitesList.clear();
          svsitesList.value = temp.userData.first.sites;
          svsitesList.refresh();
          debugPrint("sesites length:${svsitesList.length}");
        }
      }
      if (temp.userData.isNotEmpty) {
        if (temp.userData.first.sites.isNotEmpty) {
          siteID.value = temp.userData.first.sites.first.id;
          siteID.refresh();
        }
      }
      return temp;
    } else {
      debugPrint("sesites:failed${res.statusCode}");
      return null;
    }
  }

  Future<HomeReport.SeHomeReportList?> seHomeReport(
      String token, String siteid) async {
    final res = await userRepo.seHomeReport(token, siteid);
    debugPrint("seHomeReport:called");
    debugPrint("seHomeReport:called${res.bodyString}${res.statusCode}");
    if (res.statusCode == 200 || res.statusCode == 201) {
      noreport.value = false;
      debugPrint("seHomeReport:200");
      debugPrint("seHomeReport:${res.bodyString}");
      final temp = HomeReport.seHomeReportListFromJson(res.bodyString!);
      if (temp.submittedBy.id.isNotEmpty) {
        lastSubmittedReport.value = temp.submittedBy.id;
        lastSubmittedReport.refresh();
      }
      if(temp.date.toString()==current_date.value){

      }
      if (temp.submittedBy.fullName.isNotEmpty) {
        return temp;
      }

      noreport.value = false;
      return temp;
    } else {
      if (res.statusCode == 404) {
        var temp = jsonDecode(res.bodyString!);
        if (temp != null &&
            temp['message'] == "No report found for the given site") {
          noreport.value = true;

        }
        return null;
      } else if (res.statusCode == 400) {
        noreport.value = true;
      }
      debugPrint("seHomeReport:failed${res.statusCode}");
      return null;
    }
  }

  Future<SelfiDTO.SelfiResponse?> uploadSelfi(
      String token, String siteID, File file) async {
    final res = await userRepo.uploadSelfi(token, siteID, file);
    debugPrint("uploadSelfi:called" );
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("uploadSelfi:200");
      final temp = SelfiDTO.selfiResponseFromJson(res.bodyString!);
      if (temp.status == true) {
        debugPrint("uploadSelfi:status true");
        return temp;
      } else {
        debugPrint("uploadSelfi:status false");
        return null;
      }
    } else {
      debugPrint("uploadSelfi:${res.statusCode}");
      return null;
    }
  }
}
