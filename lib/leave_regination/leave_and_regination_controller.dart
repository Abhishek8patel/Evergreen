import '../../../Utills3/utills.dart';
import 'package:testingevergreen/data/repository/setting_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LeaveAndReginationController extends GetxController {
  final SettingRepo settingRepo;

  LeaveAndReginationController({required this.settingRepo});

  DateTime? selectedDate;
  String? formattedDate;
  DateTime? startDate;
  DateTime? endDate;
  String? formattedStartDate;
  String? formattedEndDate;
  RxBool _isProcess=false.obs;

  RxBool get isProcess=>_isProcess;

  TextEditingController problem = TextEditingController();

  RxList<Item> reasons = <Item>[].obs;
  Item? selectedItem;

  final util = Utills();

  Future<void> ApplyforLeave(String token) async {
    util.startLoading();
    _isProcess(true);
    debugPrint("Resignation"+"Called");
    final reslut = await settingRepo.ApplyForLeave(
        token: token,
        start_date: formattedStartDate!,
        end_date: formattedEndDate!,
        reason: selectedItem!.id);
    if (reslut.statusCode == 200 || reslut.statusCode == 201) {
      _isProcess(false);
      util.stopLoading();
      debugPrint("Resignation"+"Success${reslut.statusCode}");
      util.showSnackBar("Alert", "Success", true);
    }else{
      _isProcess(false);
      util.stopLoading();
      debugPrint("Resignation"+"failed${reslut.statusCode}");
      util.showSnackBar("Alert", "failed", true);
    }
  }


  Future<void> ApplyForResignation(String token) async {
    util.startLoading();
    debugPrint("Resignation"+"Called");
    _isProcess(true);
    final reslut = await settingRepo.ApplyForResignation(
        token: token,
        last_date_working: formattedStartDate!,
        reason: selectedItem!.id);
    if (reslut.statusCode == 200 || reslut.statusCode == 201) {
      _isProcess(false);
      util.stopLoading();
      debugPrint("Resignation"+"Success${reslut.statusCode}");
      util.showSnackBar("Alert", "Success", true);
    }else{
      _isProcess(false);
      debugPrint("Resignation"+"failed${reslut.statusCode}");
      util.stopLoading();
      util.showSnackBar("Alert", "failed", true);
    }
  }

  Future<void> fetchReasons() async {
    Future.delayed(Duration(seconds: 2), () {
      reasons.add(Item(id: "sickness", name: "Sickness"));
      reasons.add(Item(id: "urgent_work", name: "Urgent Work"));
      reasons.add(Item(id: "family_issue", name: "Family Issue"));
      reasons.add(Item(id: "family_event", name: "Family Event"));
    });
  }

  Future<void> fetchReasonsForResignation() async {
    Future.delayed(Duration(seconds: 2), () {
      reasons.add(Item(id: "new_job", name: "New Job"));
      reasons.add(Item(id: "personal_reasons", name: "Personal Reasons"));
      reasons.add(Item(id: "relocation", name: "Relocation"));
      reasons.add(Item(id: "health_issues", name: "Health Issues"));
    });
  }
}

class Item {
  final String id;
  final String name;

  Item({required this.id, required this.name});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
    );
  }
}
