import 'dart:io';

// import 'package:testingevergreen/Utills/endpoints.dart';
import 'package:testingevergreen/data/apiclient/apiclient.dart';
import 'package:get/get.dart';

import '../../Utills3/endpoints.dart';
class EditServiceEngneerRepo extends GetxService {
  final ApiClient apiclient;

  EditServiceEngneerRepo({required this.apiclient});


  Future<Response> getEditedProducts(String token,String siteID)async{
    return await apiclient.editProductGet(AppEndPoints.SEEDITPRODUCT,token,siteID);
  }


  Future<Response> getNotEmptyValues(
      String token,
      String siteID,
      ) async {
    return apiclient.getNotEmptyValues(
        AppEndPoints.EDITNOTEMPTYVALUES, token, siteID);
  }

  Future<Response> getSeEditImages(
      String token,
      String siteID,
      ) async {
    return apiclient.getSeEditImages(
        AppEndPoints.EDITGETIMAGES, token, siteID);
  }





  Future<Response> postWorkingType(String token, String siteID,
      String product_id, String working_type,String product_report_id,String report_id) async {
    return apiclient.postWorkingType(
        AppEndPoints.POSTEDITWORKINGTYPE, token, siteID, product_id, working_type,product_report_id,report_id);
  }


  Future<Response> editSeaddImages(String token, String site_id, String product_id,
      String product_report_id, String problem_id, int listindex, [List<File>? productImages]) async {
    return apiclient.addImages(AppEndPoints.SEEDITADDIMAGE, token, site_id,
        product_id, product_report_id, problem_id,listindex,productImages);
  }



  Future<Response> postCorrectValuesSeEdit(String token, String siteID,
      String product_id, String product_report_id, String current_value ,bool isEdit) async {
    return apiclient.postCorrectValues(AppEndPoints.EDITPOSTCOTRERCVALUES,token,
        siteID, product_id, product_report_id, current_value);
  }
}