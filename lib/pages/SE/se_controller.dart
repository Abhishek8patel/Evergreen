import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utills3/utills.dart';
import 'package:testingevergreen/data/repository/se_repo.dart';
import 'package:testingevergreen/pages/SE/se_models/allProblems.dart'
    as AllProblems;
import 'package:testingevergreen/pages/SE/se_models/se_report_res.dart'
    as SeReportRes;
import 'package:testingevergreen/pages/SE/se_models/service_eng_models.dart'
    as AttendanceDTO;
import 'package:testingevergreen/pages/SE/se_models/site_data_dto.dart'
    as seSitesDTO;
import 'package:testingevergreen/pages/SE/se_models/site_products_dto.dart'
    as siteProductsDTO;
import 'package:testingevergreen/pages/SV/svmodels/getSvReportDTO.dart'
    as svReportDTO;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:math' show cos, sqrt, asin;

class SEController extends GetxController {
  final ServiceEngneerRepo svRepo;

  SEController({required this.svRepo});

  RxList selectedIndices = [].obs;

  RxBool isActive = true.obs;

  // -1 means no selection

  List<TextEditingController> controllers = [];

  RxBool loadind = false.obs;

  RxBool timeFinished = false.obs;

  RxString userToken = "".obs;
  final util = Utills();
  Rx<File?> fimage1 = Rx<File?>(null);
  Rx<File?> fimage2 = Rx<File?>(null);
  File? image;
  RxString _current_date = "".obs;

  RxString get current_date => _current_date;

  RxInt currentIndex = 0.obs;

  RxString _current_time = "".obs;

  RxString get current_time => _current_time;

  RxString siteID = "".obs;

  RxBool _noDataFound = false.obs;

  RxBool get noDataFound => _noDataFound;

  RxString siteName = "".obs;

  static const int _start = 60; // 5 minutes in seconds
  RxInt _currentSeconds = _start.obs;

  RxInt get currentSeconds => _currentSeconds;
  Timer? _timer;

  RxList<AllProblems.Datum?> _problemsList = <AllProblems.Datum?>[].obs;

  RxList<AllProblems.Datum?> get problemsList => _problemsList;

  RxList<siteProductsDTO.ProductElement?> _productList =
      <siteProductsDTO.ProductElement>[].obs;

  RxList<siteProductsDTO.ProductElement?> get productList => _productList;

  RxList<seSitesDTO.SiteId> sitesDataLists = <seSitesDTO.SiteId>[].obs;

  RxList<AllProblems.Datum?> selectedProblemsOptions =
      <AllProblems.Datum?>[].obs;
  RxList<String> selectedProblemsOptionsIds = <String>[].obs;
  RxMap<int, String> selectedProblemsValues = <int, String>{}.obs;

  RxMap<int, String> selectedProductsIds = <int, String>{}.obs;

  // RxList selectedProductsIds = [].obs;

  RxList<TextEditingController> correct_value_controllers =
      <TextEditingController>[].obs;
  RxList<bool> isOutOfRange = <bool>[].obs;

  RxList<List<File>> productImages = <List<File>>[].obs;

  RxString siteid = "".obs;

  RxList<svReportDTO.UserDatum> svProductsList = <svReportDTO.UserDatum>[].obs;
  RxList<svReportDTO.Product> svOnlyProductsList = <svReportDTO.Product>[].obs;

  void getImageIndices(File targetImage) {
    for (int i = 0; i < productImages.length; i++) {
      for (int j = 0; j < productImages[i].length; j++) {
        if (productImages[i][j] == targetImage) {
          debugPrint('njimg+Image found at index: [$i][$j]');
          return; // Return if you only want the first occurrence
        }
      }
    }
    debugPrint('njimg+Image not found');
  }

  // Future<AttendanceDTO.AttendanceRes?> seAttendance( int index, String token, String entry,
  //     String lat, String long, String siteid, String usertype) async {
  //   final image = index == 0 ? fimage1 : fimage2;
  //   if (image.value.isNull) {
  //     util.showSnackBar("Alert", "Please add selfie!", false);
  //     return null;
  //   }
  //   debugPrint("attendance:called}");
  //   var res = await svRepo.fillAttendance(
  //       token: token,
  //       file: image.value!,
  //       date: current_date.value,
  //       time: current_time.value,
  //       site_id: siteid,
  //       entry: entry,
  //       lat: lat,
  //       long: long,
  //       usertype: usertype);
  //   debugPrint("attendance+${siteID.value}");
  //   debugPrint(
  //       "attendance+called $token  $image.value!   $current_date.value   $current_time.value    $siteid   $entry   $lat  $long");
  //
  //   if (res.statusCode == 200 || res.statusCode == 201) {
  //     debugPrint("attendance+200");
  //     var temp = AttendanceDTO.attendanceResFromJson(res.bodyString!);
  //     if (temp.status == true) {
  //       return temp;
  //     }
  //   }
  //   else {
  //     if (res.statusCode == 404) {
  //       var temp = jsonDecode(res.bodyString!);
  //       util.showSnackBar("Alert:", temp['message'], false);
  //     } else {
  //       util.showSnackBar("Alert", "failed Rk ${res.statusCode}", false);
  //     }
  //
  //     debugPrint("attendance+failed: ${res.statusCode}");
  //   }
  // }
  Future<AttendanceDTO.AttendanceRes?> seAttendance(
      int index,
      String token,
      String entry,
      String lat,
      String long,
      String siteid,
      String usertype,
      ) async {
    final image = index == 0 ? fimage1 : fimage2;

    // Check if the image is null
    if (image.value.isNull) {
      util.showSnackBar("Alert", "Please add a selfie!", false);
      return null;
    }

    debugPrint("attendance:called");

    try {
      // Make the API call
      var res = await svRepo.fillAttendance(
        token: token,
        file: image.value!,
        date: current_date.value,
        time: current_time.value,
        site_id: siteid,
        entry: entry,
        lat: lat,
        long: long,
        usertype: usertype,
      );

      debugPrint("attendance+called $token $image.value! $current_date.value $current_time.value $siteid $entry $lat $long");

      // Handle success response
      if (res.statusCode == 200 || res.statusCode == 201) {
        debugPrint("attendance+200");
        var temp = AttendanceDTO.attendanceResFromJson(res.bodyString!);
        if (temp.status == true) {
          return temp;
        }
      } else {
        // Handle error response
        String errorMessage = "An unexpected error occurred";

        // Try to parse the error message from the response body
        try {
          var temp = jsonDecode(res.bodyString!);
          errorMessage = temp['message'] ?? errorMessage;
        } catch (e) {
          debugPrint("Error decoding response: $e");
        }

        // Show different messages based on the status code
        if (res.statusCode == 404) {
          util.showSnackBar("Alert", errorMessage, false);
        } else {
          util.showSnackBar("Alert", "Failed RK ${res.statusCode}: $errorMessage", false);
        }

        debugPrint("attendance+failed: ${res.statusCode}, Error: $errorMessage");
      }
    } catch (e) {
      // Handle exceptions like network issues
      debugPrint("Exception occurred during attendance: $e");
      util.showSnackBar("Error", "An error occurred while processing your request.", false);
    }

    return null;
  }

    RxList<DropdownMenuItem<String>> categories_data = [
    "problem one",
    "problem two",
    "problem three",
    "problem four",
  ]
      .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Expanded(child: Text(value)),
        );
      })
      .toList()
      .obs;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currentSeconds.value > 0) {
        _currentSeconds.value--;
        _currentSeconds.refresh();
        update();
      } else {
        timer.cancel();
      }
    });
  }

  void cancelTimer() {
    _timer!.cancel();
    _currentSeconds.value = 60;
  }

  Future<double> calculateDistance(
      double lat1, double lon1, double lat2, double lon2) async {
    const p = 0.017453292519943295; // Math.PI / 180
    const c = cos;
    final a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return await 12742 * 1000 * asin(sqrt(a)); // 2 * R * 1000; R = 6371 km
  }

  Future<seSitesDTO.UserData?> getSeSites(String token) async {
    final response = await svRepo.getSeSites(token);
    debugPrint("njlist+called");
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("njlist+200");
      var temp = seSitesDTO.siteDataDtoFromJson(response.bodyString!);
      util.showSnackBar("Alert", temp.message, true);
      if (temp.userData.siteId.isNotEmpty ||
          temp.userData.siteId.toString() != "[]") {
        debugPrint("njlist+200");
        sitesDataLists.value.clear();
        sitesDataLists.value = temp.userData.siteId;
        sitesDataLists.refresh();
        _noDataFound.value = false;
        _noDataFound.refresh();
        update();
        debugPrint("njlist+${sitesDataLists.first.id}");
        return temp.userData;
      } else {
        _noDataFound.value = true;
        _noDataFound.refresh();
        debugPrint("njlist+null");
        return null;
      }
    } else {
      debugPrint("njlist+failed");
      _noDataFound.value = true;
      _noDataFound.refresh();
      return null;
    }
  }

  Future<DateTime> fetchDateTime() async {
    // Use the Asia/Kolkata timezone for India
    final response = await http
        // .get(Uri.parse('http://worldtimeapi.org/api/timezone/Asia/Kolkata'));
        .get(Uri.parse('https://timeapi.io/api/time/current/zone?timeZone=Asia%2FKolkata')); // Yeh ek free api hai jo kabhi bhi band ho
                                                                                             // sakti hai.
    if (response.statusCode == 200) {
      // Parse the JSON response to get the date and time
      final data = json.decode(response.body);
      print("Check date Time: ${response.body}");
      final dateTimeString = data['dateTime'];
      // DateTime utcDateTime = DateTime.parse(dateTimeString);
      DateTime utcDateTime = DateTime.parse(dateTimeString);

      // Initialize timezone data
      tz.initializeTimeZones();
      final india = tz.getLocation('Asia/Kolkata');
      final localDateTime = tz.TZDateTime.from(utcDateTime, india);

      String formattedDate = DateFormat('MM/dd/yyyy').format(localDateTime);
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

  Future<DateTime?> fetchDateTimef() async {
    final url = Uri.parse('http://worldclockapi.com/api/json/utc/now');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && data['currentDateTime'] != null) {
        return DateTime.parse(data['currentDateTime']);
      }
    }
    return null;
  }

  Future<siteProductsDTO.SiteProductDto?> SiteProducts(
      String token, String site_id, String userType) async {
    debugPrint("from1+apicalled");
    final res = await svRepo.siteProducts(token, site_id, userType);

    if (res.statusCode == 200 || res.statusCode == 201) {
      loadind.value = true;
      loadind.refresh();
      debugPrint("from1+200");
      final temp = siteProductsDTO.siteProductDtoFromJson(res.bodyString!);
      if (temp.product.product.isNotEmpty ||
          temp.product.product.toString() == "[]") {
        siteName.value = temp.product.siteName;
        siteName.refresh();
        _productList.value.clear();
        _productList.value = temp.product.product;
        _productList.refresh();
        update();
        return temp;
      }
    } else {
      debugPrint("from1+failed${res.statusCode}");
      return null;
    }
  }

  Future<AllProblems.AllProblemsDto?> getAllProblems(String token) async {
    final res = await svRepo.getAllProblems(token);

    if (res.statusCode == 200 || res.statusCode == 201) {
      final result = AllProblems.allProblemsDtoFromJson(res.bodyString!);

      if (result.problems != null) {
        _problemsList.clear();
        _problemsList.value = result.problems.data;
        _problemsList.refresh();
        update();
        return result;
      }
    } else {
      util.showSnackBar("Alert", "failed RK", false);
      return null;
    }
  }

  Future<SeReportRes.SeReportRes?> submit_report(
      String token, List<Map<String, String>> map,
      [List<List<File>>? productImages]) async {
    final res = await svRepo.submitReport(token, map, productImages);
    debugPrint("njform:called");
    util.startLoading();
    isActive.value = false;
    isActive.refresh();
    if (res.statusCode == 200 || res.statusCode == 201) {
      util.stopLoading();
      isActive.value = true;
      isActive.refresh();
      debugPrint("njform:200");
      debugPrint("njform:${res.bodyString}");
      final temp = SeReportRes.seReportResFromJson(res.bodyString!);
      if (temp.status == true) {
        //  util.showSnackBar("Alert", "Report Submitted!", true);
        return temp;
      } else {
        util.showSnackBar("Alert", "Couldn't submit report", true);
        return null;
      }
    } else {
      isActive.value = true;
      isActive.refresh();
      util.stopLoading();
      debugPrint("njform:${res.statusCode}");
      util.showSnackBar("Alert", "Someting went wrong!", false);
      return null;
    }
  }
  Future<svReportDTO.GetReportDto?> svGetReport(String token, String reportID) async {
    final res = await svRepo.svGetReport(token, reportID);

    if (res.statusCode == 200 || res.statusCode == 201) {
      final temp = svReportDTO.getReportDtoFromJson(res.bodyString!);

      if (temp.userData.isNotEmpty) {
        svProductsList.clear();
        svProductsList.value = temp.userData;
        svProductsList.refresh();

        final String productListJson = jsonEncode(temp.userData
            .expand((userDatum) => userDatum.product)
            .toList());

        // Store the JSON string in SharedPreferences
        final sp = await SharedPreferences.getInstance();
        sp.setString('productList', productListJson);

        debugPrint('njj:Product list saved to SharedPreferences');
        debugPrint('njj:${sp.getString("productList")}');

        // Retrieve the JSON string and decode it to a list of Product objects
        String? storedProductListJson = sp.getString("productList");
        if (storedProductListJson != null) {
          List<dynamic> jsonList = jsonDecode(storedProductListJson);
          List<svReportDTO.Product> productList = jsonList
              .map((jsonItem) => svReportDTO.Product.fromJson(jsonItem))
              .toList();

          svOnlyProductsList.clear();
          svOnlyProductsList.addAll(productList);
          svOnlyProductsList.refresh();

          debugPrint('njj:${svOnlyProductsList.value.first.id}');
        }
      } else {
        return null;
      }
      return temp;
    } else {
      return null;
    }
  }



}
