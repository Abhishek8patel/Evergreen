import 'dart:convert';
import 'dart:io';
// import '../../../Utills3/utills.dart';
import 'package:testingevergreen/pages/SV/svmodels/solution_res.dart'
    as SolutionRes;
import 'package:testingevergreen/data/repository/sv_edit_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:testingevergreen/pages/SE/se_edit_models/get_edited_product_dto.dart'
    as editProductRES;

import 'package:testingevergreen/pages/SE/se_edit_models/edit_get_image_res_dto.dart'
    as SeEditImageGetRES;
import 'package:testingevergreen/pages/SE/se_models/notEmptyValuesRes.dart'
    as notEmptyValuesRES;
import 'package:testingevergreen/pages/SE/se_models/allProblems.dart'
    as AllProblems;

import 'package:testingevergreen/pages/SE/se_edit_models/se_edit_post_images_dto.dart'
    as seeditImagePost;

import 'package:testingevergreen/pages/SE/se_edit_models/edit_productType_res_dto.dart'
    as addWorkingTypeRES;

import 'package:testingevergreen/pages/SE/se_models/postCorrectValuesRes.dart'
    as postCorrectValRes;

import '../../../Utills3/utills.dart';

class svEditFormOneController extends GetxController {
  final EditSuperVisorRepo editSuperVisorRepo;
  RxString errorMsg = "".obs;
  final ScrollController scrollController = ScrollController();
  RxMap<int, String> solutionMap = <int, String>{}.obs;

  RxList<String> solutionsList = <String>[].obs;

  RxBool? noSiteId=false.obs;

  RxList<String> solutionsOptions = <String>[].obs;
  RxMap<int, String> solutionsValues = <int, String>{}.obs;

  RxMap<String, String> selectedSolutionswithProductIdValues =
      <String, String>{}.obs;

  svEditFormOneController({required this.editSuperVisorRepo});

  RxList<AllProblems.Datum?> selectedProblemsOptions =
      <AllProblems.Datum?>[].obs;

  RxList<SeEditImageGetRES.ProductReportId> getseImageslist =
      <SeEditImageGetRES.ProductReportId>[].obs;
  Map<String, String> productReportMap = {};

  RxList<List<File>> productImages = <List<File>>[].obs;
  RxMap<String, String> selectedProblemswithProductIdValues =
      <String, String>{}.obs;
  RxMap<String, String> selectedProblemCoverdwithProductIdValues =
      <String, String>{}.obs;

  RxBool isLoading = false.obs;
  RxBool loadind = false.obs;
  RxString loadind_error="".obs;
  RxMap<int, String> selectedProblemsValues = <int, String>{}.obs;
  RxInt currentPage = 0.obs;
  RxList<editProductRES.ProductReportId?> editProductList =
      <editProductRES.ProductReportId?>[].obs;
  RxList<bool> isOutOfRange = <bool>[].obs;
  RxString currentReportID = "".obs;
  RxList<int> selectedIndices = <int>[].obs;
  Map<String, String> productMainReportMap = {};
  RxMap<int, Map<String, String>> selectedProductsIds =
      <int, Map<String, String>>{}.obs;

  RxMap<String, String> productReportIdMap = <String, String>{}.obs;

  RxMap<String, String> enteredValues = <String, String>{}.obs;
  RxList<TextEditingController> correct_value_controllers =
      <TextEditingController>[].obs;
  RxList<notEmptyValuesRES.Product?> notEmptyValList =
      <notEmptyValuesRES.Product?>[].obs;

  RxMap<String, String> ProblemCoverdMap = <String, String>{}.obs;
  RxMap<String, String> solutionsMap = <String, String>{}.obs;
  RxBool isvisible = false.obs;
  final util=Utills();

  bool areAllProductsSelected() {
    for (int i = 0; i < selectedIndices.length; i++) {
      if (selectedIndices[i] == -1) {
        return false;
      }
    }
    return true;
  }

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
    final res = await editSuperVisorRepo.getEditedProducts(token, siteID);
    debugPrint("getEditProductList:called");
    loadind.value = true;
    if (res.statusCode == 200 || res.statusCode == 201) {
      loadind.value = false;
      debugPrint("getEditProductList:200");
      final result =
          editProductRES.getEdittedProductDtoFromJson(res.bodyString!);

      if (result.productReportId.isNotEmpty) {
        editProductList.clear();
        editProductList.value = result.productReportId;
        currentReportID.value = result.id;
        currentReportID.refresh();
        editProductList.refresh();
        debugPrint(
            "getEditProductList:${editProductList.value.first!.workingStatus}");
        debugPrint("getEditProductList currentReportID:${currentReportID}");
        return result;
      } else {
        debugPrint("getEditProductList:null list");
        return null;
      }
    } else {
      debugPrint("getEditProductList:failed${res.statusCode}");
      debugPrint("getEditProductList:failed${res.bodyString}");
      final result=jsonDecode(res.bodyString!);
      if(result['message'].toString().isNotEmpty){
        util.showSnackBar("Alert:", result['message'].toString(), false);
        loadind.value=false;
        noSiteId!.value=true;
        loadind_error.value="${result['message'].toString()}";

      }
      return null;
    }
  }

  Future<SeEditImageGetRES.GetEditImageSeRes?> getSeEditImages(
      String token, String siteID) async {
    final res = await editSuperVisorRepo.getSeEditImages(token, siteID);
    debugPrint("getSeEditImages CALLED");

    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("getSeEditImages 200");

      final temp = SeEditImageGetRES.getEditImageSeResFromJson(res.bodyString!);

      if (temp.productReportId.isNotEmpty) {
        getseImageslist.clear();
        ProblemCoverdMap.value.clear();
        solutionsValues.clear();
        solutionsOptions.clear();
        selectedSolutionswithProductIdValues.value.clear();
        getseImageslist.value = temp.productReportId;
        for (var element in getseImageslist.value) {
          ProblemCoverdMap.value[element.productId.id.toString()] =
              element.problemCovered.toString();
        }

        for (int i = 0; i < getseImageslist.value.length; i++) {
          debugPrint(
              "nj solutions: ${getseImageslist.value[i].solution.toString()}");
          solutionsValues[i] = getseImageslist.value[i].solution.toString();
          if (!solutionsOptions
              .contains(getseImageslist.value[i].solution.toString())) {
            solutionsOptions.add(getseImageslist.value[i].solution.toString());
          }

          selectedSolutionswithProductIdValues
                  .value[getseImageslist.value[i].productId.id] =
              getseImageslist.value[i].solution.toString()!;
        }
        selectedSolutionswithProductIdValues.refresh();
        solutionsOptions.refresh();
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

  Future<notEmptyValuesRES.NotEmptyValuesRes?> getEditNotEmptyValues(
      String token, String siteID) async {
    final res = await editSuperVisorRepo.getNotEmptyValues(token, siteID);
    debugPrint("getNotEmptyValues" + "CALLED");
    isLoading.value = true;
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("getNotEmptyValues" + "200");

      final temp = notEmptyValuesRES.notEmptyValuesResFromJson(res.bodyString!);
      // debugPrint("postWorkingType" + "${temp.toString()}");
      if (temp.products.isNotEmpty) {
        notEmptyValList.clear();
        notEmptyValList.value = temp.products;
        notEmptyValList.refresh();
        isLoading.value = false;
        return temp;
      } else {
        isLoading.value = false;
        return null;
      }
    } else {
      isLoading.value = false;
      debugPrint("getNotEmptyValues" + "FAILED${res.statusCode}");
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
      String solution,
      String problem_covered,
      int listindex,
      [List<File>? productImages]) async {
    final res = await editSuperVisorRepo.editSeaddImages(
        token,
        site_id,
        product_id,
        product_report_id,
        problem_id,
        solution,
        problem_covered,
        listindex,
        productImages);
    debugPrint("editSeaddImages" + "CALLED");
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("editSeaddImages" + "200");

      final temp = seeditImagePost.editImagePostSeResFromJson(res.bodyString!);
      // debugPrint("postWorkingType" + "${temp.toString()}");
      if (temp.message.isNotEmpty &&
          temp.message == "Images and problem ID updated successfully") {
        return temp;
      } else {
        return null;
      }
    } else {
      debugPrint("editSeaddImages" + "FAILED${res.statusCode}");
      debugPrint("editSeaddImages" + "FAILED${res.bodyString}");
      return null;
      ;
    }
  }

  Future<addWorkingTypeRES.EditWorkingTypeRes?> postWorkingType(
      String token,
      String siteID,
      String product_id,
      String working_type,
      String product_report_id,
      String reportID) async {
    final res = await editSuperVisorRepo.postWorkingType(
        token, siteID, product_id, working_type, product_report_id, reportID);
    debugPrint("postWorkingType" + "CALLED");
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("postWorkingType" + "200");

      final temp =
          addWorkingTypeRES.editWorkingTypeResFromJson(res.bodyString!);
      // debugPrint("postWorkingType" + "${temp.toString()}");

      return temp;
    } else {
      debugPrint("postWorkingType" + "FAILED${res.statusCode}");
      return null;
      ;
    }
  }

  Future<postCorrectValRes.PostCorrectValueRes?> postCorrectValuesSeEdit({
    required String token,
    required String siteID,
    required String product_id,
    required String product_report_id,
    required String current_value,
    required bool is_edit,
  }) async {
    final res = await editSuperVisorRepo.postCorrectValuesSeEdit(
        token, siteID, product_id, product_report_id, current_value, is_edit);
    debugPrint("postCorrectValues" + "CALLED");
    debugPrint("postCorrectValues" + "${res.bodyString}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("postCorrectValues" + "200");

      final temp =
          postCorrectValRes.postCorrectValueResFromJson(res.bodyString!);
      // debugPrint("postWorkingType" + "${temp.toString()}");
      if (temp.message.isNotEmpty &&
          temp.message.toString() == "Value updated successfully") {
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

  Future<SolutionRes.SolutionRes?> getSolutions(
    String token,
    String problem_Id,
  ) async {
    final res = await editSuperVisorRepo.getSolutions(token, problem_Id);
    debugPrint("getSolutions" + "CALLED");
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("getSolutions" + "200");

      final temp = SolutionRes.solutionResFromJson(res.bodyString!);
      // debugPrint("postWorkingType" + "${temp.toString()}");
      if (temp.solution != null) {
        solutionsList.value.clear();
        solutionsList.value = temp.solution.solution;
        debugPrint("getSolutions" + "$solutionsList}");
        solutionsList.refresh();

        return temp;
      } else {
        return null;
      }
    } else {
      debugPrint("getSolutions" + "FAILED${res.statusCode}");
      debugPrint("getSolutions" + "FAILED${res.bodyString}");
      return null;
      ;
    }
  }
}
