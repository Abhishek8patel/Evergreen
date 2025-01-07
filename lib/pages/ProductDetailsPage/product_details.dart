import 'dart:async';

import '../../../Utills3/utills.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailPage extends StatefulWidget {
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final pageController = PageController();
  Timer? timer;
  bool? isForword = true;

  @override
  void initState() {
    if (mounted) {
      Future.delayed(Duration(seconds: 2), () {
        pageController.nextPage(
            duration: Duration(seconds: 1), curve: Curves.linear);
      });
    }
    pageController.addListener(() {
      if (timer == null) {
        timer = Timer.periodic(Duration(seconds: 2), (timer) {
          if (isForword == true) {
            pageController.nextPage(
                duration: Duration(seconds: 1), curve: Curves.linear);
            if (pageController.page!.round() == 2) {
              setState(() {
                isForword = false;
              });
            }
          } else if (pageController.page!.round() == 2 ||
              pageController.page!.round() == 1 && isForword == false) {
            if (pageController.page!.round() == 1) {
              pageController.previousPage(
                  duration: Duration(seconds: 1), curve: Curves.linear);
            }

            pageController.previousPage(
                duration: Duration(seconds: 1), curve: Curves.linear);
            if (pageController.page!.round() == 0) {
              pageController.nextPage(
                  duration: Duration(seconds: 1), curve: Curves.linear);
              setState(() {

                isForword = true;

              });
            }
          }
          debugPrint("ctime:${timer.tick}");
          debugPrint("ctime:${pageController.page!.round()}");
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
        title: Text('Round Cactus'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 0, // Spread radius
                          blurRadius: 6, // Blur radius
                          offset: Offset(
                              0, 3), // Offset in x and y direction (x: 0, y: 3)
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffEBEBED)),
                  width: 314,
                  height: 144,
                  child: PageView(
                    controller: pageController,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/demo_img_one.jpeg', fit: BoxFit.cover,
                          // Replace with your image URL
                          height: 200,
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/demo_img_one.jpeg', fit: BoxFit.cover,
                          // Replace with your image URL
                          height: 200,
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/demo_img_one.jpeg', fit: BoxFit.cover,
                          // Replace with your image URL
                          height: 200,
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IndicatorDot(),
                    SizedBox(width: 5),
                    IndicatorDot(),
                    SizedBox(width: 5),
                    IndicatorDot(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Description',
                  style: GoogleFonts.aclonica(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Donec pharetra, nisi quis laoreet faucibus, nisi quam luctus lectus, '
                  'in gravida ex est enim.',
                  style: GoogleFonts.poly(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.black)),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Type: Outdoor',
                      style: GoogleFonts.aclonica(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black)),
                  Spacer(),
                  Text('Size: Medium',
                      style: GoogleFonts.aclonica(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black)),
                  Spacer(),
                  Text('Level: Easy',
                      style: GoogleFonts.aclonica(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black)),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Similar Type',
                  style: GoogleFonts.aclonica(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              HorizontalItemList(),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Fertilizer',
                  style: GoogleFonts.aclonica(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              HorizontalItemList(),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Tools',
                  style: GoogleFonts.aclonica(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              HorizontalItemList(),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 160,
                  height: 53,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffABFFE7)),
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff040A05)),
                  child: Center(
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'Add to Cart',
                        style: GoogleFonts.aclonica(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ProductItem(),
          ProductItem(),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 161,
            width: 146,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/demo_img_one.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0, top: 10),
              child: Container(
                width: 63,
                height: 18,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      spreadRadius: 0, // Spread radius
                      blurRadius: 6, // Blur radius
                      offset: Offset(
                          0, 3), // Offset in x and y direction (x: 0, y: 3)
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                  border: Border.all(color: Color(0xffABFFE7)),
                ),
                child: Center(
                  child: Text(
                    '\$44.00',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 10),
              child: Container(
                height: 18,
                child: Center(
                  child: Text(
                    'Round Cactus',
                    style: GoogleFonts.aclonica(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IndicatorDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
    );
  }
}
