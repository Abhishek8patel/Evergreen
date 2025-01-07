import 'dart:io';

// import 'package:testingevergreen/Utills/endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Utills3/endpoints.dart';
import '../../data/apiclient/apiclient.dart';



class AuthRepository extends GetxService {
  final ApiClient apiClient;

  AuthRepository({required this.apiClient});

  Future<Response> login(Map body) async {
    return await apiClient.login("/api/user/login",body);
  }

  Future<Response> saveFirebaseToken(String token ,String ftoken) async {
    return await apiClient.saveFirebaseToken("/api/user/websiteNotificationToken",token,ftoken);
  }

  Future<Response> Signup(String fname, mobile,String password,String deviceId) async {
    return await apiClient.signUp("${AppEndPoints.register}",fname,mobile,password,deviceId);
  }

  Future<Response> SignupAndUploadImage(File file,String fname, String mobile,String password,String deviceId,String email,String address,String? firebase_token) async {
    return await apiClient.SignupAndUpoadImage(url:"${AppEndPoints.register}",file: file,fullName: fname,mobile: mobile,password: password,deviceId: deviceId,email: email,address:address,firebase_token: firebase_token! );
  }




  Future<Response> resendOtp(String email)async{
    return await apiClient.resendOtp("${AppEndPoints.resend_otp}",email);
  }

  Future<Response> verifyOtp(String email,String otp)async{
    return await apiClient.verifyOtp("/api/user/verifyOtp",email,otp);
  }

  Future<Response> forgotPassword(String mobile,String newpass,String otp)async{
    return await apiClient.forgotPassword("${AppEndPoints.forget_pw}",mobile,newpass,otp);
  }

  Future<Response> createPassword(String email,String password,String confirm_password,)async{
    return await apiClient.createPassword("/api/forget_password_post",email,password,confirm_password);
  }


  //

  Future<Response> logout(String token)async{
    return await apiClient.logout("${AppEndPoints.logout_user}",token);
  }

  Future<Response> about_us(String endpoint)async{
    return await apiClient.about_us("/api/CompanyDetails/$endpoint");
  }

  Future<Response> changePassword(String newpass,String token) async {
    return await apiClient.changePassword("${AppEndPoints.change_password}", newpass,token);
  }
}
