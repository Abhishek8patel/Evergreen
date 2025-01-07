import 'dart:io';

// import 'package:testingevergreen/Utills/endpoints.dart';
import 'package:testingevergreen/data/apiclient/apiclient.dart';
import 'package:get/get.dart';

import '../../Utills3/endpoints.dart';

class ServiceEngneerRepo extends GetxService {
  final ApiClient apiclient;

  ServiceEngneerRepo({required this.apiclient});

  Future<Response> fillAttendance({
    required String token,
    required File file,
    required String date,
    required String time,
    required String site_id,
    required String entry,
    required String lat,
    required String long,
    required String usertype,
  }) async {
    return apiclient.fillSEAttendance(
        token: token,
        url: usertype == "supervisor"
            ? "${AppEndPoints.SVAttendace}"
            : "${AppEndPoints.SEAttendace}",
        file: file,
        date: date,
        time: time,
        entry: entry,
        lat: lat,
        long: long,
        siteId: site_id);
  }

  Future<Response> getSeSites(String token) async {
    return apiclient.getSeSites("${AppEndPoints.SESite}", token);
  }

  Future<Response> siteProducts(
      String token, String site_id, String userType) async {
    return apiclient.siteProducts(
        url: userType == "supervisor"
            ? "${AppEndPoints.SVSITEPRODUCTS}"
            : "${AppEndPoints.SITEPRODUCTS}",
        token: token,
        site_id: site_id);
  }

  Future<Response> getAllProblems(String token) async {
    return apiclient.getAllProblems(
        url: "${AppEndPoints.GETPROBLEMS}", token: token);
  }

  Future<Response> submitReport(String token, List<Map<String, String>> map,
      [List<List<File>>? productImages]) async {
    return apiclient.submitReport(
        "${AppEndPoints.SUBMITFORM}", token, map, productImages);
  }

  Future<Response> svGetReport(String token, String reportId) async {
    return apiclient.svGetReport(
        url: AppEndPoints.SV_GET_REPORT, token: token, reportId: reportId);
  }

  Future<Response> getSiteProducts(String token, String siteID) async {
    return apiclient.getSiteProducts(AppEndPoints.PRODUCTBYSITE, token, siteID);
  }

  Future<Response> postWorkingType(String token, String siteID,
      String product_id, String working_type) async {
    return await apiclient.postWorkingType(
        AppEndPoints.POSTWORKINGTYPE, token, siteID, product_id, working_type,null,null);
  }

  Future<Response> getNotEmptyValues(
    String token,
    String siteID,
  ) async {
    return apiclient.getNotEmptyValues(
        AppEndPoints.NOTEMPTYVALUES, token, siteID);
  }

  Future<Response> postCorrectValues(String token, String siteID,
      String product_id, String product_report_id, String current_value ,bool isEdit) async {
    return apiclient.postCorrectValues(AppEndPoints.POSTCOTRERCVALUES, token,
        siteID, product_id, product_report_id, current_value);
  }

  Future<Response> finalFormSubmit(String token, String report_id) async {
    return apiclient.finalFormSubmit(
      AppEndPoints.FINALFORMSUBMIT,
      token,
      report_id,
    );
  }

  Future<Response> addImages(String token, String site_id, String product_id,
      String product_report_id, String problem_id,int listindex, [List<File>? productImages]) async {
    return apiclient.addImages(AppEndPoints.ADDIMAGE, token, site_id,
        product_id, product_report_id, problem_id,listindex,productImages);
  }
}
