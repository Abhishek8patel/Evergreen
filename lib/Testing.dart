//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'appconstants/appconstants.dart';
//
// class CallApi {
//   // Singleton Instance
//   static final CallApi _instance = CallApi._newInstance();
//
//   factory CallApi() {
//     return _instance;
//   }
//
//   CallApi._newInstance();
//
//   // Store Fetched Data
//   List<Map<String, String>>? _userData;
//
//   // Getter for accessing stored user data
//   List<Map<String, String>>? get userData => _userData;
//
//   // Fetch User Data from API
//   Future<void> fetchAndStoreUserData() async {
//     const String url = "https://app.evergreenion.com/api/user/getUser";
//
//     try {
//       final userData = await AppConstant.getUserData("user_data");
//       final token = userData?.user_token;
//
//       if (token == null) {
//         debugPrint("Error: User token is null");
//         _userData = null;
//         return;
//       }
//
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//
//         // Access the nested user object
//         final user = data['user'];
//         if (user == null) {
//           debugPrint("Error: User object is null in the response.");
//           _userData = null;
//           return;
//         }
//          print("drewrt${_userData}");
//         // Store extracted user data in `_userData`
//         _userData = [
//           {
//             'full_name': user['full_name'] ?? "No Name",
//             'pic': user['pic'] ?? "default_profile_picture_url",
//           }
//         ];
//       } else {
//         debugPrint("Failed to fetch user data: ${response.statusCode}");
//         _userData = null;
//       }
//     } catch (error) {
//       debugPrint("Error fetching user data: $error");
//       _userData = null;
//     }
//   }
// }
//
// class TestingClass extends StatelessWidget {
//   const TestingClass({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final callApi = CallApi();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("User Data"),
//       ),
//       body: FutureBuilder<void>(
//         future: callApi.fetchAndStoreUserData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text("Error: ${snapshot.error}"),
//             );
//           } else if (callApi.userData == null || callApi.userData!.isEmpty) {
//             return const Center(
//               child: Text("No User Data Found"),
//             );
//           }
//
//           // If data is fetched successfully
//           final users = callApi.userData!;
//           return ListView.builder(
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(user['pic']!),
//                 ),
//                 title: Text(user['full_name']!),
//                 subtitle: const Text("User Details..."),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';

class ScrollViewExample extends StatefulWidget {
  const ScrollViewExample({super.key});

  @override
  State<ScrollViewExample> createState() => _ScrollViewExampleState();
}

class _ScrollViewExampleState extends State<ScrollViewExample> {
  final ScrollController _scrollController = ScrollController();
bool _scrollControllerr = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar( toolbarHeight: 4,  title:  Text("")),
      body: SafeArea(
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverList(
                delegate: SliverChildListDelegate([
                 // Container(height: 300, color: Colors.red), // Large Header
                Image.asset("assets/images/splash_center_logo.png",color: Colors.green,)
                ]),
              ),
              SliverPersistentHeader(
                pinned: true, // Ensures the widget stays pinned to the top
                delegate: _SliverAppBarDelegate(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Search...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              const Text(
                "Scrollable Content Below",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              Container(height: 300, color: Colors.grey),
              Container(height: 300, color: Colors.green),
              Container(height: 300, color: Colors.pink),
              Container(height: 300, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverAppBarDelegate({required this.child});

  @override
  double get minExtent => 60.0;

  @override
  double get maxExtent => 60.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

