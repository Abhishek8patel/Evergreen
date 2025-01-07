import 'dart:convert';

import '../../../Utills3/utills.dart';
import 'package:testingevergreen/pages/Consume_Chemical_list/ChemicalListDTO.dart'
    as ChemicalDTO;
import 'package:testingevergreen/pages/Consume_Chemical_list/chemical_repo.dart';
import 'package:testingevergreen/pages/Consume_Chemical_list/updateChemicalResponseDto.dart'
    as updateChimalDTO;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChemicalController extends GetxController {
  final ChemicalRepo chemicalRepo;

  ChemicalController({required this.chemicalRepo});

  RxList<ChemicalDTO.Product> chemicalProductsList =
      <ChemicalDTO.Product>[].obs;
  RxMap<int, String> selectedProductsValues = <int, String>{}.obs;
  var qty = TextEditingController();
  final util = Utills();

  RxString chemicalProduct = "".obs;
  RxString userToken = "".obs;
  RxBool isLoading = false.obs;

  Future<ChemicalDTO.ChemicalListDto?> getChemicalList(
      String token, String site_id) async {
    debugPrint("chemicalget:called");
    isLoading.value = true;
    final res = await chemicalRepo.getChemicalList(token, site_id);

    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("chemicalget:200");
      final temp = ChemicalDTO.chemicalListDtoFromJson(res.bodyString!);

      if (temp.products.isNotEmpty) {
        chemicalProductsList.value.clear();
        chemicalProductsList.value = temp.products;
        chemicalProductsList.refresh();
        update();
        isLoading.value = false;
      }

      debugPrint("chemicalget:${res.bodyString}");
      isLoading.value = false;
      return temp;
    } else {
      isLoading.value = false;
      debugPrint("chemicalget:failed${res.statusCode}");
      util.showSnackBar(
          "Alert", "something went wrong", false);
      return null;
    }
  }

  Future<updateChimalDTO.UpdateChemicalResponse?> updateChemicalList(
      String token, String site_id, String productID, String usedQty) async {
    debugPrint("UpdateChemicalResponse:called");
    debugPrint("UpdateChemicalResponse:${site_id}${productID}${usedQty}");

    final res = await chemicalRepo.updateChemicalList(
        token, site_id, productID, usedQty);

    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("UpdateChemicalResponse:200");
      final temp =
          updateChimalDTO.updateChemicalResponseFromJson(res.bodyString!);

      if (temp.message!.isNotEmpty) {
        util.showSnackBar("Alert", temp.message!, true);
        qty.text = "";
      }
      // debugPrint("UpdateChemicalResponse:${res.bodyString}");
      // debugPrint("UpdateChemicalResponse:${res.bodyString}");

      return temp;
    } else {
      if(res.statusCode==404||res.statusCode==403){
        util.showSnackBar("Alert",
            "${jsonDecode(res.bodyString!)['Message'].toString()}", false);
      }
      debugPrint("UpdateChemicalResponse:failed${res.statusCode}");
      final result = jsonDecode(res.bodyString!);
      if (result['error'].toString().isNotEmpty) {
        util.showSnackBar("Alert",
            "${result['error'].toString()}", false);
      }else{
        util.showSnackBar("Alert",
            "something went wrong", false);

      }

      return null;
    }
  }
}
