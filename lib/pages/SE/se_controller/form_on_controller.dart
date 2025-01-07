import 'dart:io';

import 'package:testingevergreen/data/repository/se_repo.dart';
import 'package:testingevergreen/pages/SE/se_models/add_working_type_res.dart' as addWorkingTypeRES;

import 'package:testingevergreen/pages/SE/se_models/final_report_submit_res.dart' as FinalReportRES;

import 'package:testingevergreen/pages/SE/se_models/notEmptyValuesRes.dart'
    as notEmptyValuesRES;
import 'package:testingevergreen/pages/SE/se_models/postCorrectValuesRes.dart'
    as postCorrectValRes;
import 'package:testingevergreen/pages/SE/se_models/post_img_res.dart' as PostImgDTO;
import 'package:testingevergreen/pages/SE/se_models/siteProductRes.dart'
    as siteProductsDTO;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testingevergreen/data/repository/se_repo.dart';
import 'package:testingevergreen/pages/SE/se_models/allProblems.dart'
as AllProblems;

class FormOnController extends GetxController {
  final ServiceEngneerRepo serviceEngneerRepo;
  RxString errorMsg="".obs;
  RxInt currentPage = 0.obs;
  RxMap<int, String> solutionMap = <int, String>{}.obs;
  RxString productReportId="".obs;
  RxList<int> selectedIndices = <int>[].obs;
  RxMap<int, Map<String, String>> selectedProductsIds =
      <int, Map<String, String>>{}.obs;

  RxList<Map<String, String>> selectedProductsList = <Map<String, String>> [].obs;

  FormOnController({required this.serviceEngneerRepo});

  RxList<siteProductsDTO.Product?> productsList =
      <siteProductsDTO.Product?>[].obs;

  RxBool loadind = false.obs;


  Map<String, String> productReportMap = {};

  RxList<String> solutionsOptions = <String>[].obs;
  RxMap<int, String> solutionsValues = <int, String>{}.obs;
  RxMap<String, String> selectedSolutionswithProductIdValues =
      <String, String>{}.obs;

  Map<String, String> productMainReportMap = {};
  RxList<notEmptyValuesRES.Product?> notEmptyValList =
      <notEmptyValuesRES.Product?>[].obs;

  RxList<TextEditingController> correct_value_controllers =
      <TextEditingController>[].obs;
  RxList<bool> isOutOfRange = <bool>[].obs;




  RxList<AllProblems.Datum?> selectedProblemsOptions =
      <AllProblems.Datum?>[].obs;
  RxList<String> selectedProblemsOptionsIds = <String>[].obs;

  RxMap<int, String> selectedProblemsValues = <int, String>{}.obs;
  RxMap<String, String> selectedProblemswithProductIdValues = <String, String>{}.obs;

  RxList<AllProblems.Datum?> _problemsList = <AllProblems.Datum?>[].obs;

  RxList<AllProblems.Datum?> get problemsList => _problemsList;

  RxList<List<File>> productImages = <List<File>>[].obs;
 // RxList<Map<String,List<File>>> productImages=<Map<String,List<File>>>[].obs;




  RxMap<String, String> enteredValues = <String, String>{}.obs;

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

  bool areAllProductsSelected() {
    for (int i = 0; i < selectedIndices.length; i++) {
      if (selectedIndices[i] == -1) {
        return false;
      }
    }
    return true;
  }
  bool getAllProductOkSelected() {
    for (int i = 0; i < selectedIndices.length; i++) {
      if (selectedIndices[i] == 1) {
        return false;
      }
    }
    return true;
  }
  void logSelectedProducts() {
    selectedProductsIds.forEach((key, value) {
      debugPrint("njjjj" +
          'Index: $key, Type: ${value['type']}, Product ID: ${value['productID']}');
    });
  }

  void clearSelections() {
    selectedIndices.clear();
    selectedProductsIds.clear();
    selectedIndices.refresh();
    selectedProductsIds.refresh();
  }

  Future<siteProductsDTO.SiteProductResponse?> getProducts(
      String token, String siteID) async {
    debugPrint("njj:called");
    debugPrint("njj:called$token $siteID}");
    final res = await serviceEngneerRepo.getSiteProducts(token, siteID);
    loadind.value = true;
    if (res.statusCode == 200 || res.statusCode == 201) {
      loadind.value = false;
      debugPrint("njj:200");

      final temp = siteProductsDTO.siteProductResponseFromJson(res.bodyString!);

      if (temp.products.isNotEmpty) {
        productsList.clear();
        productsList.value = temp.products;
        productsList.refresh();
        return temp;
      }
    } else {
      loadind.value = false;
      debugPrint("njj:failed${res.statusCode}");
      return null;
    }
  }

  Future<addWorkingTypeRES.AddWorkingTypeRes?> postWorkingType(String token,
      String siteID, String product_id, String working_type) async {
    final res = await serviceEngneerRepo.postWorkingType(
        token, siteID, product_id, working_type);
    debugPrint("postWorkingType" + "CALLED");
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("postWorkingType" + "200");

      final temp = addWorkingTypeRES.addWorkingTypeResFromJson(res.bodyString!);
      // debugPrint("postWorkingType" + "${temp.toString()}");

      return temp;
    } else {
      debugPrint("postWorkingType" + "FAILED${res.statusCode}");
      return null;
      ;
    }
  }

  Future<notEmptyValuesRES.NotEmptyValuesRes?> getNotEmptyValues(
      String token, String siteID) async {
    final res = await serviceEngneerRepo.getNotEmptyValues(token, siteID);
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

  Future<postCorrectValRes.PostCorrectValueRes?> postCorrectValues(
  { required String token,
    required String siteID,
    required String product_id,
    required String product_report_id,
    required String current_value,
    required bool is_edit,
  }) async {
    final res = await serviceEngneerRepo.postCorrectValues(
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

  Future<FinalReportRES.FinalReportSubmitRes?> finalFormSubmit(
    String token,
    String report_id,
  ) async {
    final res = await serviceEngneerRepo.finalFormSubmit(token, report_id);
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


  Future<PostImgDTO.PostImgRes?> addImages(
      String token,
      String site_id,
      String product_id,
      String product_report_id,
      String problem_id,
      int listindex,
      [List<File>? productImages]
      ) async {
    final res = await serviceEngneerRepo.addImages(token,site_id,product_id,product_report_id,problem_id,listindex,productImages);
    debugPrint("addImages" + "CALLED");
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("addImages" + "200");

      final temp = PostImgDTO.postImgResFromJson(res.bodyString!);
      // debugPrint("postWorkingType" + "${temp.toString()}");
      if (temp.message.isNotEmpty && temp.message=="Images and problem ID updated successfully") {
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
}
