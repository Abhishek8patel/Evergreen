import 'dart:convert';

// import '../../../Utills3/utills.dart';
import 'package:testingevergreen/data/repository/sv_repo.dart';
import 'package:testingevergreen/others/normal_res_dto.dart' as res;
import 'package:testingevergreen/pages/SV/svmodels/clientMailDto.dart'
    as EmailDTO;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Utills3/utills.dart';

class ClientEmailController extends GetxController {
  final SuperVisorRepo superVisorRepo;

  ClientEmailController({
    required this.superVisorRepo,
  });

  final util = Utills();

  RxString emailId = "".obs;
  RxList<EmailDTO.EmailDatum?> emailList = <EmailDTO.EmailDatum?>[].obs;

  RxMap<int, EmailDTO.EmailDatum?> selectedEmailValues =
      <int, EmailDTO.EmailDatum?>{}.obs;

  Future<EmailDTO.SvClientMailDto?> getClientEmails(
      String token, String site_id) async {
    final res = await superVisorRepo.getClientEmails(token, site_id);
    debugPrint("email" + "called");
    if (res.statusCode == 200 || res.statusCode == 201) {
      debugPrint("email" + "200");
      final temp = EmailDTO.svClientMailDtoFromJson(res.bodyString!);
      if (temp.emails.emailData.isNotEmpty) {
        if (temp.emails.id.isNotEmpty) {
          emailId.value = temp.emails.id;
          emailId.refresh();
        }
        emailList.clear();
        emailList.value = temp.emails.emailData;
        emailList.refresh();
      }
      return temp;
    } else {
      debugPrint("email" + "null");
      return null;
    }
  }

  Future<res.NormalResponse?> sendEmail(
      String token, String _id, String email) async {
    final result = await superVisorRepo.sendClientEmail(token, _id, email);
    debugPrint("email" + "called");
    if (result.statusCode == 200 || result.statusCode == 201) {
      debugPrint("email" + "200");
      final temp = res.normalResponseFromJson(result.bodyString!);
      if (temp.status == true) {
        return temp;
      } else {
        util.showSnackBar("Alert", "Somethig went wrong!", false);
        return null;
      }
    } else {
      util.showSnackBar(
          "Alert", "Somethig went wrong!${result.statusCode}", false);
      debugPrint("email" + "null");
      return null;
    }
  }

  Future<res.NormalResponse?> verifyOTP(
      String token, String _id, String otp) async {
    final result = await superVisorRepo.verifyOtp(token, _id, otp);
    debugPrint("email" + "called");
    if (result.statusCode == 200 || result.statusCode == 201) {

      debugPrint("email" + "200");
      final temp = res.normalResponseFromJson(result.bodyString!);
      debugPrint("email" + "${temp}");
      if (temp.status == true) {
        return temp;
      } else {
        util.showSnackBar("Alert", "Something went wrong!", false);
        return null;
      }
    } else {
      final temp = jsonDecode(result.bodyString!);
      debugPrint("email" + "${temp}");
      if (temp['status'] == false) {
        util.showSnackBar("Alert", temp['message'], false);
      }

      debugPrint("email" + "null");
      return null;
    }
  }
}
