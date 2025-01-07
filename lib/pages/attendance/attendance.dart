// import 'package:testingevergreen/Utills/universal.dart';
import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:flutter/material.dart';

import '../../Utills3/universal.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 10,right: 10),
          child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
          backToolbar(name: "Aatendance"),
          Expanded(
              child: ListView.builder(
            itemBuilder: (c, i) {
              return Card(
                elevation: 1,
                child: Container(

                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: AppConstant.shadow_bottom()

                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                            child: Text("In Time",style: AppConstant.getRoboto(FontWeight.w700, 18, Color(0xff494F4D)),),
                          ),

                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.green),
                            ),
                            child: Image.asset(
                              "assets/images/selfie_logo.png",
                              scale: 2,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Take Selfie",
                            style: AppConstant.getRoboto(FontWeight.w700,
                                AppConstant.HEADLINE_SIZE_12, Color(0xff53C17F)),
                          )
                        ],
                      ),
                      Text(
                        "10:00",
                        style: AppConstant.getRoboto(FontWeight.w800,
                            AppConstant.HEADLINE_SIZE_25, Color(0xff4FB578)),
                      ),
                      BounceableButton(
                        onTap: () {},
                        text: 'Done',
                        width: 95,
                        height: 48,
                        gradient: AppConstant.BUTTON_COLOR,
                        borderRadius: 20,
                        fontSize: AppConstant.HEADLINE_SIZE_20,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: 2,
          ))
      ],
    ),
        ));
  }
}
