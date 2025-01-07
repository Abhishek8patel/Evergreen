import 'dart:io';

// import 'package:testingevergreen/Utills/endpoints.dart';
import 'package:testingevergreen/data/apiclient/apiclient.dart';
import 'package:get/get.dart';

import '../../Utills3/endpoints.dart';

class SuperVisorRepo extends GetxService {
  final ApiClient apiclient;

  SuperVisorRepo({required this.apiclient});

  Future<Response> getSiteData(String token, String userId) async {
    return apiclient.getSiteData("${AppEndPoints.getSiteData}", token, userId);
  }

  Future<Response> getClientEmails(String token, String site_id) async {
    return apiclient.getClientEmails("${AppEndPoints.CLIENT_EMAIL}", token, site_id);
  }

  Future<Response> sendClientEmail(String token, String _id,String email) async {
    return apiclient.sendClientEmail("${AppEndPoints.SEND_EMAIL}", token,_id,email);
  }


  Future<Response> verifyOtp(String token, String _id,String otp) async {
    return apiclient.verifyOtpEmail("${AppEndPoints.VERIFY_OTP}", token,_id,otp);
  }


  Future<Response> getSVSitesProducts(String token, String siteID) async {
    return apiclient.getSiteProducts(AppEndPoints.SVPRODUCTBYSITE, token, siteID);
  }


  Future<Response> getSVSITES(String token,) async {
    return apiclient.getSvSites(AppEndPoints.SVHOMEPAGESITE, token,);
  }

  Future<Response> getNotEmptyValues(
      String token,
      String siteID,
      ) async {
    return apiclient.getNotEmptyValues(
        AppEndPoints.NOTEMPTYVALUES, token, siteID);
  }


  Future<Response> svpostCorrectValues(String token, String siteID,
      String product_id, String product_report_id, String current_value ,bool isEdit) async {
    return apiclient.postCorrectValues(AppEndPoints.SVPOSTCOTRERCVALUES, token,
        siteID, product_id, product_report_id, current_value);
  }

  Future<Response> postWorkingType(String token, String siteID,
      String product_id, String working_type) async {
    return await apiclient.postWorkingType(
        AppEndPoints.SVPOSTWORKINGTYPE, token, siteID, product_id, working_type,null,null);
  }

  Future<Response> addImages(String token, String site_id, String product_id,
      String product_report_id, String problem_id,String solution,String problem_covered,  int listindex,
      [List<File>? productImages]) async {
    return apiclient.sveditaddImages(AppEndPoints.SVADDIMAGE, token, site_id,
        product_id, product_report_id, problem_id,solution,problem_covered,listindex,productImages);
  }

  Future<Response> getSolutions(String token, String problem_Id, ) async {
    return apiclient.GetSloutions(AppEndPoints.SOLUTIONS, token, problem_Id);
  }

  Future<Response> finalFormSubmit(String token, String report_id) async {
    return apiclient.finalFormSubmit(
      AppEndPoints.SVFINALFORMSUBMIT,
      token,
      report_id,
    );
  }

}
