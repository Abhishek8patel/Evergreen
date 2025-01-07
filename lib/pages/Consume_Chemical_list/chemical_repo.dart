// import 'package:testingevergreen/Utills/endpoints.dart';
import 'package:testingevergreen/data/apiclient/apiclient.dart';
import 'package:get/get.dart';

import '../../Utills3/endpoints.dart';

class ChemicalRepo extends GetxService {
  final ApiClient apiClient;

  ChemicalRepo({required this.apiClient});

  Future<Response> getChemicalList(String token,String site_id) async {
    return apiClient.getChemicalList("${AppEndPoints.CHEMICAL_LIST_GET}", token,site_id);
  }

  Future<Response> updateChemicalList(String token,String site_id,String productID,String used_qty) async {
    return apiClient.updateChemicalList("${AppEndPoints.UPDATE_CHEMICAL}", token,site_id,productID,used_qty);
  }


}
