import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:testingevergreen/helper/dependencies.dart' as deps;
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:testingevergreen/pages/profile/profile_controller.dart';
import 'package:testingevergreen/pages/splash/splash.dart';
import 'package:http/http.dart' as http;
import 'Testing.dart';
import 'appconstants/appconstants.dart';
import 'firebase/firebaseapi.dart';
import 'firebase_options.dart';
import 'helper/PreferencesService.dart';
import 'others/custom_animation.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Geolocator.isLocationServiceEnabled();
  await PreferencesService.init();
  await deps.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("IshwarMeghwal: main() Firebase");
  await FirebaseApi().initFirebase();
  runApp(const MyApp());
  configLoading();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Splash());
        // home: ScrollViewExample());
        // home: Testing());
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1000)
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 30.0
    ..radius = 10.0
    ..progressColor = Colors.green
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.green
    ..textColor = Colors.green
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}


Future<Map<String, dynamic>?> fetchUserData() async {
  final String url = "https://app.evergreenion.com/api/user/getUser";

  try {
    final userData = await AppConstant.getUserData("user_data");
    final token = userData?.user_token;

    if (token == null) {
      debugPrint("Error: User token is null");
      return null;
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Access the nested user object
      final user = data['user'];
      if (user == null) {
        debugPrint("Error: User object is null in the response.");
        return null;
      }

      // Extract required fields
      final userName = user['full_name'] ?? "No Name";
      final userPic = user['pic'] ?? "default_profile_picture_url";

      debugPrint("Fetched User Data: $userPic");
      return {'full_name': userName, 'pic': userPic};
    } else {
      debugPrint("Failed to fetch user data: ${response.statusCode}");
      return null;
    }
  } catch (error) {
    debugPrint("Error fetching user data: $error");
    return null;
  }
}


