// import 'package:testingevergreen/Utills/endpoints.dart';
import 'package:testingevergreen/data/apiclient/apiclient.dart';
import 'package:get/get.dart';

import '../../Utills3/endpoints.dart';

class SettingRepo extends GetxService {
  final ApiClient apiClient;

  SettingRepo({required this.apiClient});



  Future<Response> ApplyForLeave({required String token,required String start_date,required String end_date,required String reason,})async{
    return await apiClient.ApplyForLeave("${AppEndPoints.LEAVE}", token, start_date, end_date, reason);
  }

  Future<Response> ApplyForResignation({required String token,required String last_date_working,required String reason,})async{
    return await apiClient.ApplyForResignation("${AppEndPoints.RESIGNATION}", token, last_date_working, reason);
  }

}
