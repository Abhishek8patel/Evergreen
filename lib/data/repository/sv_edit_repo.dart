import 'dart:io';

// import 'package:testingevergreen/Utills/endpoints.dart';
import 'package:testingevergreen/data/apiclient/apiclient.dart';
import 'package:get/get.dart';

import '../../Utills3/endpoints.dart';
class EditSuperVisorRepo extends GetxService{

  final ApiClient apiclient;

  EditSuperVisorRepo({required this.apiclient});

  Future<Response> getEditedProducts(String token,String siteID)async{
    return await apiclient.editProductGet(AppEndPoints.SVEDITPRODUCT,token,siteID);
  }


  Future<Response> getSeEditImages(
      String token,
      String siteID,
      ) async {
    return apiclient.getSeEditImages(
        AppEndPoints.SVEDITGETIMAGES, token, siteID);
  }

  Future<Response> getNotEmptyValues(
      String token,
      String siteID,
      ) async {
    return apiclient.getNotEmptyValues(
        AppEndPoints.SVEDITNOTEMPTYVALUES, token, siteID);
  }

  Future<Response> editSeaddImages(String token, String site_id, String product_id,
      String product_report_id, String problem_id,String solution,String problem_covered,  int listindex,
      [List<File>? productImages]) async {
    return apiclient.sveditaddImages(AppEndPoints.SVEDITADDIMAGE, token, site_id,
        product_id, product_report_id, problem_id,solution,problem_covered,listindex,productImages);
  }


  Future<Response> postWorkingType(String token, String siteID,
      String product_id, String working_type,String product_report_id,String report_id) async {
    return apiclient.postWorkingType(
        AppEndPoints.SVPOSTEDITWORKINGTYPE, token, siteID, product_id, working_type,product_report_id,report_id);
  }

  Future<Response> postCorrectValuesSeEdit(String token, String siteID,
      String product_id, String product_report_id, String current_value ,bool isEdit) async {
    return apiclient.postCorrectValues(AppEndPoints.SVEDITPOSTCOTRERCVALUES,token,
        siteID, product_id, product_report_id, current_value);
  }

  Future<Response> getSolutions(String token, String problem_Id, ) async {
    return apiclient.GetSloutions(AppEndPoints.SOLUTIONS, token, problem_Id);
  }

}