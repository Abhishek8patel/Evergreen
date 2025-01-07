// import 'package:testingevergreen/Utills/universal.dart';
// import '../../../Utills3/utills.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:testingevergreen/appconstants/mycolor.dart';
import 'package:testingevergreen/pages/SV/svController/clentEmailController.dart';
import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testingevergreen/pages/SV/Verification_otp.dart';
import 'package:testingevergreen/pages/SV/svmodels/clientMailDto.dart'
    as EmailDTO;

import '../../Utills3/universal.dart';
import '../../Utills3/utills.dart';

class ClientEmail extends StatefulWidget {
  const ClientEmail({Key? key}) : super(key: key);

  @override
  State<ClientEmail> createState() => _ClientEmailState();
}

class _ClientEmailState extends State<ClientEmail>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  ClientEmailController clientEmailController = Get.find();
  DashboardController dashboardController = Get.find();
  var selected_category = "";
  var pageBucket = PageStorageBucket();
  final util = Utills();

  // var categories_data = <EmailDTO.EmailDatum?>[].map((value) {
  //   return DropdownMenuItem<EmailDTO.EmailDatum?>(
  //     value: value,
  //     child: Expanded(child: Text(value!.email)),
  //   );
  // }).toList();

  @override
  void initState() {
    if (mounted) {
      debugPrint("njpagecalled");
      clientEmailController
          .getClientEmails(dashboardController.user_token.value,
              dashboardController.currentSiteID!.value)
          .then((value) => {
                if (value != null)
                  {
                    // util.showSnackBar('Alert',
                    //     value.emails.emailData.length.toString(), true),
                    clientEmailController.selectedEmailValues.value[0] =
                        value.emails.emailData.first,

                    // value.emails.emailData
                    //     .map((e) => categories_data.add(
                    //     DropdownMenuItem(child: Text(e.email.toString()))))
                    //     .toList()
                  },
                setState(() {
                  clientEmailController.selectedEmailValues.value[0] =
                      value!.emails.emailData.first;
                })
              });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PageStorage(
      bucket: pageBucket,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          backToolbar(name: ""),
          SizedBox(height: 150,),
          Center(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset("assets/images/otp_client.png"))),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Select Your Client Email Address',
                style: AppConstant.getRoboto(FontWeight.w700,
                    AppConstant.HEADLINE_SIZE_20, Color(0xff25BD62)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width*0.8,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: const Offset(5.0, 5.0),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ),
                ],
                border: Border.all(
                  color: MyColor.OUTLINE_COLOR_POST,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: DropdownButton<EmailDTO.EmailDatum?>(
                    isExpanded:true,

                    value: clientEmailController.selectedEmailValues.value[0],
                    hint: Expanded(child: Text('Select Emails')),

                    onChanged: (newValue) {
                      setState(() {
                        clientEmailController.selectedEmailValues.value[0] =
                            newValue!;
                      });
                    },

                    items: clientEmailController.emailList.value
                        .map<DropdownMenuItem<EmailDTO.EmailDatum?>>((value) {
                      return DropdownMenuItem<EmailDTO.EmailDatum?>(
                        value: value,
                        child: Text(value!.email),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  AppConstant.getTapButton(
                      AppConstant.getRoboto(FontWeight.w800,
                          AppConstant.HEADLINE_SIZE_20, Colors.white),
                      "Send",
                      121,
                      53, () {
                    if (clientEmailController
                            .selectedEmailValues.value[0]!.email.isNotEmpty ||
                        clientEmailController
                            .selectedEmailValues.value[0]!.id.isNotEmpty ||
                        clientEmailController.emailId.value.isNotEmpty) {
                      clientEmailController
                          .sendEmail(
                              dashboardController.user_token.value,
                              clientEmailController.emailId.value,
                              clientEmailController
                                  .selectedEmailValues.value[0]!.email)
                          .then((value) => {
                                if (value!.status == true)
                                  {
                                    Get.to(() => VerificationOTP(
                                          id: clientEmailController.emailId.value,
                                          email: clientEmailController
                                              .selectedEmailValues
                                              .value[0]!
                                              .email,
                                        ))
                                  }
                              });
                    }
                  }, borderRadius: BorderRadius.circular(30))
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
