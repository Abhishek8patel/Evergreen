import 'dart:io';
import 'package:testingevergreen/pages/SE/se_edit_models/se_image_post_res_new.dart' as seeditImagePost;
import 'package:testingevergreen/pages/SE/se_models/postCorrectValuesRes.dart'
as postCorrectValRes;

import 'package:testingevergreen/data/repository/se_edit_repo.dart';
import 'package:testingevergreen/pages/SE/se_edit_models/edit_get_image_res_dto.dart' as SeEditImageGetRES;

import 'package:testingevergreen/pages/SE/se_edit_models/edit_productType_res_dto.dart' as addWorkingTypeRES;

import 'package:testingevergreen/pages/SE/se_edit_models/get_edited_product_dto.dart'
    as editProductRES;
// as seeditImagePost;

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:testingevergreen/pages/SE/se_models/notEmptyValuesRes.dart'
as notEmptyValuesRES;
// import 'package:testingevergreen/pages/SE/se_models/addWrokingTypeRes.dart'
// as addWorkingTypeRES;
import 'package:testingevergreen/pages/SE/se_models/allProblems.dart'
as AllProblems;
class SeEditFormOneController extends GetxController {
  final EditServiceEngneerRepo editServiceEngneerRepo;

  SeEditFormOneController({required this.editServiceEngneerRepo});
  RxList<notEmptyValuesRES.Product?> notEmptyValList =
      <notEmptyValuesRES.Product?>[].obs;


  RxList<SeEditImageGetRES.ProductReportId> getseImageslist =
      <SeEditImageGetRES.ProductReportId>[].obs;

  ScrollController scrollController =ScrollController();
  Map<String, String> productReportMap = {};
  RxMap<int, Map<String, String>> selectedProductsIds =
      <int, Map<String, String>>{}.obs;
  bool areAllProductsSelected() {
    for (int i = 0; i < selectedIndices.length; i++) {
      if (selectedIndices[i] == -1) {
        return false;
      }
    }
    return true;
  }
  RxString error_msg="Please,Rconfirm current values.".obs;
RxMap<String ,String> productReportIdMap=<String ,String>{}.obs;

  RxInt currentPage = 0.obs;

  RxList<AllProblems.Datum?> selectedProblemsOptions =
      <AllProblems.Datum?>[].obs;

  Map<String, String> productMainReportMap = {};

  RxList<editProductRES.ProductReportId?> editProductList =
      <editProductRES.ProductReportId?>[].obs;

  RxString currentReportID="".obs;

  RxBool loadind = false.obs;
 // RxMap<int, String> selectedProductsIds = <int, String>{}.obs;

  RxBool isLoading=false.obs;

  RxList<TextEditingController> correct_value_controllers =
      <TextEditingController>[].obs;
  RxList<bool> isOutOfRange = <bool>[].obs;

  RxList<List<File>> productImages = <List<File>>[].obs;


  RxMap<String, String> selectedProblemswithProductIdValues = <String, String>{}.obs;


  RxMap<int, String> selectedProblemsValues = <int, String>{}.obs;
  RxList<int> selectedIndices = <int>[].obs;




  RxMap<String, String> enteredValues = <String, String>{}.obs;

  void clearSelections() {
    selectedIndices.clear();
    selectedProductsIds.clear();
    selectedIndices.refresh();
    selectedProductsIds.refresh();
  }
  Future scrollToBottom() async{
    await scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.easeOut,
    );
  }

  Future<editProductRES.GetEdittedProductDto?> getEditProductList(
      String token, String siteID) async {
    final res = await editServiceEngneerRepo.getEditedProducts(token, siteID);
        debugPrint("getEditProductList:called");
    loadind.value=true;
    if (res.statusCode == 200 || res.statusCode == 201) {
      loadind.value=false;
      debugPrint("getEditProductList:200");
      final result =
          editProductRES.getEdittedProductDtoFromJson(res.bodyString!);

      if (result.productReportId.isNotEmpty) {
        editProductList.clear();
        editProductList.value = result.productReportId;
        currentReportID.value=result.id;
        currentReportID.refresh();
        editProductList.refresh();
        debugPrint("getEditProductList:${editProductList.value.first!.workingStatus}");
        debugPrint("getEditProductList currentReportID:${currentReportID}");
        return result;
      }else{
        debugPrint("getEditProductList:null list");
        return null;
      }
    }else{

      debugPrint("getEditProductList:failed${res.statusCode}");
      return null;
    }
  }







  Future<notEmptyValuesRES.NotEmptyValuesRes?> getEditNotEmptyValues(
      String token, String siteID) async {
    final res = await editServiceEngneerRepo.getNotEmptyValues(token, siteID);
    debugPrint("getNotEmptyValues" + "CALLED");
    isLoading.value=true;
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("getNotEmptyValues" + "200");

      final temp = notEmptyValuesRES.notEmptyValuesResFromJson(res.bodyString!);
      // debugPrint("postWorkingType" + "${temp.toString()}");
      if (temp.products.isNotEmpty) {
        notEmptyValList.clear();
        notEmptyValList.value = temp.products;
        notEmptyValList.refresh();
        isLoading.value=false;
        return temp;
      } else {
        isLoading.value=false;
        return null;
      }
    } else {
      isLoading.value=false;
      debugPrint("getNotEmptyValues" + "FAILED${res.statusCode}");
      return null;
      ;
    }
  }


  Future<SeEditImageGetRES.GetEditImageSeRes?> getSeEditImages(
      String token, String siteID) async {
    final res = await editServiceEngneerRepo.getSeEditImages(token, siteID);
    debugPrint("getSeEditImages CALLED");

    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("getSeEditImages 200");

      final temp = SeEditImageGetRES.getEditImageSeResFromJson(res.bodyString!);

      if (temp.productReportId.isNotEmpty) {
        getseImageslist.clear();
        getseImageslist.value = temp.productReportId;
        debugPrint("getSeEditImages ${getseImageslist.value}");
        // Populate selectedProblemsValues map
        // for (int i = 0; i < getseImageslist.length; i++) {
        //   selectedProblemsValues[i] = getseImageslist[i].problemId?.problem ?? '';
        // }

        getseImageslist.refresh();

        for (var productReport in getseImageslist) {
          productReportMap[productReport.productId.id] = productReport.id;
        }

        return temp;
      } else {
        return null;
      }
    } else {
      debugPrint("getSeEditImages FAILED ${res.statusCode}");
      return null;
    }
  }






  Future<addWorkingTypeRES.EditWorkingTypeRes?> postWorkingType(String token,
      String siteID, String product_id, String working_type,String product_report_id,String reportID) async {
    final res = await editServiceEngneerRepo.postWorkingType(
        token, siteID, product_id, working_type,product_report_id,reportID);
    debugPrint("postWorkingType" + "CALLED");
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("postWorkingType" + "200");

      final temp = addWorkingTypeRES.editWorkingTypeResFromJson(res.bodyString!);
      // debugPrint("postWorkingType" + "${temp.toString()}");

      return temp;
    } else {
      debugPrint("postWorkingType" + "FAILED${res.statusCode}");
      return null;
      ;
    }
  }



  Future<seeditImagePost.EditImagePostSeRes?> editSeaddImages(
      String token,
      String site_id,
      String product_id,
      String product_report_id,
      String problem_id,
      int listindex,
      [List<File>? productImages]
      ) async {
    final res = await editServiceEngneerRepo.editSeaddImages(token,site_id,product_id,product_report_id,problem_id,listindex,productImages);
    debugPrint("editSeaddImages" + "CALLED");
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("editSeaddImages" + "200");

      final temp = seeditImagePost.editImagePostSeResFromJson(res.bodyString!);
      // debugPrint("postWorkingType" + "${temp.toString()}");
      if (temp.message.isNotEmpty && temp.message=="Images and problem ID updated successfully") {
        return temp;
      } else {
        return null;
      }
    } else {
      debugPrint("editSeaddImages" + "FAILED${res.statusCode}");
      debugPrint("editSeaddImages" + "FAILED${res.bodyString}");
      return null;

    }
  }



  Future<postCorrectValRes.PostCorrectValueRes?> postCorrectValuesSeEdit(
      { required String token,
        required String siteID,
        required String product_id,
        required String product_report_id,
        required String current_value,
        required bool is_edit,
      }) async {
    final res = await editServiceEngneerRepo.postCorrectValuesSeEdit(
        token, siteID, product_id, product_report_id, current_value,is_edit);
    debugPrint("postCorrectValues" + "CALLED");
    debugPrint("postCorrectValues" + "${res.bodyString}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("postCorrectValues" + "200");

      final temp = postCorrectValRes.postCorrectValueResFromJson(res.bodyString!);
      // debugPrint("postWorkingType" + "${temp.toString()}");
      if (temp.message.isNotEmpty && temp.message.toString()=="Value updated successfully") {
        return temp;
      } else {
        return null;
      }
    } else {
      debugPrint("postCorrectValues" + "FAILED${res.statusCode}");
      return null;
      ;
    }
  }

}
