import 'dart:io';
import 'package:testingevergreen/pages/SE/se_models/notEmptyValuesRes.dart'
    as notEmptyValuesRES;
import 'package:testingevergreen/data/repository/sv_repo.dart';
import 'package:testingevergreen/pages/SV/svmodels/solution_res.dart'
    as SolutionRes;
import 'package:testingevergreen/pages/SV/svmodels/sv_add_workingtype_res.dart'
    as addWorkingTypeRES;
import 'package:testingevergreen/pages/SV/svmodels/sv_site_res.dart' as SVSITEDTO;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testingevergreen/pages/SE/se_models/siteProductRes.dart'
    as siteProductsDTO;
import 'package:testingevergreen/pages/SE/se_models/final_report_submit_res.dart' as FinalReportRES;

import 'package:testingevergreen/pages/SE/se_models/allProblems.dart'
    as AllProblems;

import 'package:testingevergreen/pages/SE/se_models/postCorrectValuesRes.dart'
    as postCorrectValRes;

import 'package:testingevergreen/pages/SE/se_models/post_img_res.dart'
    as PostImgDTO;

class SvFormOneController extends GetxController {
  final SuperVisorRepo superVisorRepo;
  RxMap<String, String> selectedProblemCoverdwithProductIdValues =
      <String, String>{}.obs;

  SvFormOneController({required this.superVisorRepo});



  RxString errorMsg="".obs;

  RxBool errorStatus=false.obs;

  RxList<String> solutionsList = <String>[].obs;

  RxMap<int, String> solutionMap = <int, String>{}.obs;

  RxMap<String, String> selectedSolutionswithProductIdValues =
      <String, String>{}.obs;

  RxList<String> solutionsOptions = <String>[].obs;
  RxMap<int, String> solutionsValues = <int, String>{}.obs;

  RxInt currentPage = 0.obs;
  RxBool loadind = false.obs;

  RxMap<String, String> selectedProblemswithProductIdValues =
      <String, String>{}.obs;

  RxList<siteProductsDTO.Product?> productsList =
      <siteProductsDTO.Product?>[].obs;
  RxList<SVSITEDTO.UserDatum> svsiteList=<SVSITEDTO.UserDatum>[].obs;



  RxList<String> selectedProblemsOptionsIds = <String>[].obs;
  RxList<AllProblems.Datum?> _problemsList = <AllProblems.Datum?>[].obs;

  RxList<AllProblems.Datum?> get problemsList => _problemsList;

  RxList<AllProblems.Datum?> selectedProblemsOptions =
      <AllProblems.Datum?>[].obs;

  RxMap<int, String> selectedProblemsValues = <int, String>{}.obs;

  RxString currentSiteId = "".obs;

  RxList<notEmptyValuesRES.Product?> notEmptyValList =
      <notEmptyValuesRES.Product?>[].obs;
  RxList selectedIndices = [].obs;
  RxMap<int, Map<String, String>> selectedProductsIds =
      <int, Map<String, String>>{}.obs;
  RxList<List<File>> productImages = <List<File>>[].obs;

  RxList<TextEditingController> correct_value_controllers =
      <TextEditingController>[].obs;

  RxList<bool> isOutOfRange = <bool>[].obs;

  Map<String, String> productMainReportMap = {};
  RxMap<String, String> enteredValues = <String, String>{}.obs;

  Map<String, String> productReportMap = {};

  RxList<Map<String, String>> selectedProductsList =
      <Map<String, String>>[].obs;

  //  RxList<String> solutionsOptions = <String>[].obs;
  // RxMap<int, String> solutionsValues = <int, String>{}.obs;

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

  Future<siteProductsDTO.SiteProductResponse?> getProducts(
      String token, String siteID) async {
    debugPrint("getProducts:called");
    debugPrint("getProducts:token:$token}");
    debugPrint("getProducts:siteid:$siteID}");
    final res = await superVisorRepo.getSVSitesProducts(token, siteID);
    loadind.value = true;
    if (res.statusCode == 200 || res.statusCode == 201) {
      loadind.value = false;
      debugPrint("getProducts:200");

      final temp = siteProductsDTO.siteProductResponseFromJson(res.bodyString!);

      if (temp.products.isNotEmpty) {
        productsList.clear();
        productsList.value = temp.products;
        debugPrint("njj:list${productsList.value}");
        productsList.refresh();
        return temp;
      }
    } else {
      loadind.value = false;
      debugPrint("getProducts:failed${res.statusCode}");
      return null;
    }
  }

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

  Future<List<SVSITEDTO.UserDatum>?> getSvsites(
    String token,
  ) async {
    final res = await superVisorRepo.getSVSITES(token);
    debugPrint("siteID");
    debugPrint("SVSITES oken:${token}");
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("svSitesCalled${200}");
      debugPrint("svSitesCalled${res.bodyString!}");
      final temp = SVSITEDTO.svSiteResponseFromJson(res.bodyString!);

      if(temp.userData.toString()==[]){
        errorStatus.value=true;
        errorMsg.value="";
        debugPrint(
            "SVSITES: no userdata}");
      }
      if (temp.userData.first.toString() != "[]") {
        print("fjdkdkfjdk ${temp.userData.first.sites}");
        if (temp.userData.first.sites.isNotEmpty) {
          svsiteList.clear();
          svsiteList.value=temp.userData;
          svsiteList.refresh();
          debugPrint(
              "SVSITES: length${svsiteList.value.length.toString()}");
          if (temp.userData.first.sites.first.id.isNotEmpty) {
            debugPrint(
                "SVSITES:${temp.userData.first.sites.first.id.toString()}");
            return temp.userData;
          } else {
            return null;
          }
        }
      } else {
        return null;
      }
    } else {
      debugPrint("svSitesCalled${res.statusCode}");
      return null;
    }
  }

  Future<notEmptyValuesRES.NotEmptyValuesRes?> getNotEmptyValues(
      String token, String siteID) async {
    final res = await superVisorRepo.getNotEmptyValues(token, siteID);
    debugPrint("getNotEmptyValues" + "CALLED");
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("getNotEmptyValues" + "200");

      final temp = notEmptyValuesRES.notEmptyValuesResFromJson(res.bodyString!);
      // debugPrint("postWorkingType" + "${temp.toString()}");
      if (temp.products.isNotEmpty) {
        notEmptyValList.clear();
        notEmptyValList.value = temp.products;
        notEmptyValList.refresh();
        return temp;
      } else {
        return null;
      }
    } else {
      debugPrint("getNotEmptyValues" + "FAILED${res.statusCode}");
      return null;
      ;
    }
  }

  Future<postCorrectValRes.PostCorrectValueRes?> postCorrectValues({
    required String token,
    required String siteID,
    required String product_id,
    required String product_report_id,
    required String current_value,
    required bool is_edit,
  }) async {
    final res = await superVisorRepo.svpostCorrectValues(
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

  Future<addWorkingTypeRES.SvAddWorkingTypeRes?> postWorkingType(String token,
      String siteID, String product_id, String working_type) async {
    final res = await superVisorRepo.postWorkingType(
        token, siteID, product_id, working_type);
    debugPrint("postWorkingType" + "CALLED");
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("postWorkingType" + "200");

      final temp =
          addWorkingTypeRES.svAddWorkingTypeResFromJson(res.bodyString!);
      // debugPrint("postWorkingType" + "${temp.toString()}");

      return temp;
    } else {
      debugPrint("postWorkingType" + "FAILED${res.statusCode}");
      return null;
      ;
    }
  }

  Future<PostImgDTO.PostImgRes?> addImages(String token, String site_id,
      String product_id, String product_report_id, String problem_id, String solution,
      String problem_covered,
      int listindex,
      [List<File>? productImages]) async {
    final res = await superVisorRepo.addImages(
        token, site_id, product_id, product_report_id, problem_id,solution,problem_covered,listindex,productImages);
    debugPrint("addImages" + "CALLED");
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("addImages" + "200");

      final temp = PostImgDTO.postImgResFromJson(res.bodyString!);
      // debugPrint("postWorkingType" + "${temp.toString()}");
      if (temp.message.isNotEmpty &&
          temp.message == "Images and problem ID updated successfully") {
        return temp;
      } else {
        return null;
      }
    } else {
      debugPrint("addImages" + "FAILED${res.statusCode}");
      debugPrint("addImages" + "FAILED${res.bodyString}");
      return null;
      ;
    }
  }

  Future<SolutionRes.SolutionRes?> getSolutions(
    String token,
    String problem_Id,
  ) async {
    final res = await superVisorRepo.getSolutions(token, problem_Id);
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


  Future<FinalReportRES.FinalReportSubmitRes?> finalFormSubmit(
      String token,
      String report_id,
      ) async {
    final res = await superVisorRepo.finalFormSubmit(token, report_id);
    debugPrint("finalFormSubmit" + "CALLED");
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("finalFormSubmit" + "200");

      final temp = FinalReportRES.finalReportSubmitResFromJson(res.bodyString!);
      // debugPrint("postWorkingType" + "${temp.toString()}");
      if (temp.message.isNotEmpty) {
        return temp;
      } else {
        return null;
      }
    } else {
      debugPrint("finalFormSubmit" + "FAILED${res.statusCode}");
      return null;
      ;
    }
  }


//getSolutions
}
