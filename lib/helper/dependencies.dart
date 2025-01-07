import 'package:testingevergreen/controller/notificationcontroller.dart';
import 'package:testingevergreen/data/repository/se_edit_repo.dart';
import 'package:testingevergreen/data/repository/se_repo.dart';
import 'package:testingevergreen/data/repository/setting_repo.dart';
import 'package:testingevergreen/data/repository/sv_edit_repo.dart';
import 'package:testingevergreen/data/repository/sv_repo.dart';
import 'package:testingevergreen/leave_regination/leave_and_regination_controller.dart';
import 'package:testingevergreen/pages/Consume_Chemical_list/chemical_controller.dart';
import 'package:testingevergreen/pages/Consume_Chemical_list/chemical_repo.dart';
import 'package:testingevergreen/pages/SE/se_controller.dart';
import 'package:testingevergreen/pages/SE/se_controller/form_on_controller.dart';
import 'package:testingevergreen/pages/SE/se_edit_controller/se_edit_fromone_controller.dart';
import 'package:testingevergreen/pages/SV/svController/clentEmailController.dart';
import 'package:testingevergreen/pages/SV/svController/sv_edit_form_one_controller.dart';
import 'package:testingevergreen/pages/SV/svController/sv_form_one_controller.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:testingevergreen/pages/notification/notification.dart';
import 'package:get/get.dart';

import '../appconstants/appconstants.dart';
import '../data/apiclient/apiclient.dart';
import '../data/repository/profile_repo.dart';
import '../data/repository/user_repo.dart';
import '../getXNetworkManager.dart';
import '../pages/auth/auth_repository.dart';
import '../pages/contact_us/contact_controller.dart';
import '../pages/edit_profile/edit_pro_controller.dart';
import '../pages/forgot_password/forgot_pw_controller.dart';
import '../pages/login/login_controller.dart';
import '../pages/otp/otp_controller.dart';
import '../pages/profile/profile_controller.dart';
import '../pages/settings/setting_controller.dart';
import '../pages/signup/signup_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstant.BASE_URL));

  Get.lazyPut(() => AuthRepository(apiClient: Get.find()));

  Get.lazyPut(() => SuperVisorRepo(apiclient: Get.find()));

  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  Get.lazyPut(() => ServiceEngneerRepo(apiclient: Get.find()));

  Get.put(SEController(svRepo: Get.find()));

  Get.put(GetXNetworkManager());

  Get.lazyPut(() => DashboardController(userRepo: Get.find()));

  Get.put(SettingController(authRepository: Get.find()));

  Get.lazyPut(() => LoginController(authRepository: Get.find()));

  Get.put(LoginController(authRepository: Get.find()));

  Get.put(SignupController(authRepository: Get.find()));

  Get.put(OtpController(authRepository: Get.find()));

  Get.put(ForgotPasswordController(authRepository: Get.find()));

  Get.put(ProfileRepository(apiclient: Get.find()));

  Get.lazyPut(() => ProfileRepository(apiclient: Get.find()));

  Get.put(ProfileController(profileRepository: Get.find()));

  Get.put(ContactController(profileRepository: Get.find()));

  Get.put(SettingController(authRepository: Get.find()));

  Get.put(EditProfileController(profileRepository: Get.find()));

  Get.put(DashboardController(userRepo: Get.find()));

  Get.put(NotificationController(userRepo: Get.find()));

  Get.put(ChemicalRepo(apiClient: Get.find()));

  Get.put(ChemicalController(chemicalRepo: Get.find()));

  Get.put(ClientEmailController(superVisorRepo: Get.find()));

  Get.put(FormOnController(serviceEngneerRepo: Get.find()));

  Get.put(EditServiceEngneerRepo(apiclient: Get.find()));

  Get.put(SeEditFormOneController(editServiceEngneerRepo: Get.find()));

  Get.put(SvFormOneController(superVisorRepo: Get.find()));

  Get.put(EditSuperVisorRepo(apiclient: Get.find()));

 Get.put(svEditFormOneController(editSuperVisorRepo: Get.find()));
 Get.put(SettingRepo(apiClient: Get.find()));
 Get.lazyPut(()=>SettingRepo(apiClient: Get.find()));
 Get.put(LeaveAndReginationController(settingRepo: Get.find()));
 Get.lazyPut(() => LeaveAndReginationController(settingRepo: Get.find()));

}
