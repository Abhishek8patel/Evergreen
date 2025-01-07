import 'package:testingevergreen/appconstants/appconstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ImageShow extends StatefulWidget {
  String? URL;

  ImageShow({Key? key, required this.URL}) : super(key: key);

  @override
  State<ImageShow> createState() => _ImageShowState();
}

class _ImageShowState extends State<ImageShow> {
  @override
  void initState() {
    AppConstant().enable_full_screen();
    super.initState();
  }

  @override
  void dispose() {
    AppConstant().disable_full_screen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(onTap: (){
        Get.back();
      },
        child: Container(height: 100,child: Row(children: [Container(margin: EdgeInsets.only(left: 8),
          width:40,height:40,child: Image.asset("assets/images/back_btn.png",scale: 1,),)],),),
      ),),
        body: Center(
            child: InteractiveViewer(
                panEnabled: true,
                // Set it to false
                panAxis: PanAxis.aligned,
                boundaryMargin: EdgeInsets.all(100),
                minScale: 0.5,
                maxScale: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.network(widget.URL!,fit: BoxFit.fitWidth,),
                ))));
  }
}
