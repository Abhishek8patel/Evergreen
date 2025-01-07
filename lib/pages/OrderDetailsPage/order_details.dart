import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../ProductDetailsPage/product_details.dart';
class OrderDetails extends StatefulWidget {
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<Map<String, String>> listOfsuppliers = [
    {
      "supplierName": "Oxford",
      "subTotal": "640.0",
      "verificationCode": "45SAXZ"
    },
    {
      "supplierName": "Mahesh",
      "subTotal": "120.0",
      "verificationCode": "45SAXasZ"
    },
    {
      "supplierName": "Rahul",
      "subTotal": "90.0",
      "verificationCode": "4ADASDXZ"
    }
  ];

  List<OrderItem> listOfOrdersone = [
    OrderItem(
      imageUrl: 'assets/images/demo_img_one.jpeg',
      title: 'Round Cactus',
      quantity: 1,
      price: 100.00,
    ),
    OrderItem(
      imageUrl: 'assets/images/demo_img_one.jpeg',
      title: 'Compost',
      quantity: 1,
      price: 220.00,
      weight: '300gm',
    ),
    OrderItem(
      imageUrl: 'assets/images/demo_img_one.jpeg',
      title: 'Round Cactus',
      quantity: 1,
      price: 320.00,
    ),
  ];
  List<OrderItem> listOfOrdersTwo = [
    OrderItem(
      imageUrl: 'assets/images/demo_img_one.jpeg',
      title: 'Round Cactus',
      quantity: 1,
      price: 50.00,
    ),
    OrderItem(
      imageUrl: 'assets/images/demo_img_one.jpeg',
      title: 'Compost',
      quantity: 1,
      price: 60.00,
      weight: '300gm',
    ),
    OrderItem(
      imageUrl: 'assets/images/demo_img_one.jpeg',
      title: 'Round Cactus',
      quantity: 1,
      price: 10.00,
    ),
  ];
  List<OrderItem> listOfOrdersThree = [
    OrderItem(
      imageUrl: 'assets/images/demo_img_one.jpeg',
      title: 'Round Cactus',
      quantity: 1,
      price: 20.00,
    ),
    OrderItem(
      imageUrl: 'assets/images/demo_img_one.jpeg',
      title: 'Compost',
      quantity: 3,
      price: 30.00,
      weight: '300gm',
    ),
    OrderItem(
      imageUrl: 'assets/images/demo_img_one.jpeg',
      title: 'Round Cactus',
      quantity: 4,
      price: 40.00,
    ),
  ];
  List<List<OrderItem>>? TotalOrders=<List<OrderItem>>[];

  @override
  void initState() {
    TotalOrders!.add(listOfOrdersone);
    TotalOrders!.add(listOfOrdersTwo);
    TotalOrders!.add(listOfOrdersThree);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            color: Colors.green[50],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#1932454',
                      style: GoogleFonts.aclonica(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment Type: COD',
                          style: GoogleFonts.poly(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                        Text(
                          '05-12-2019',
                          style: GoogleFonts.poly(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xff9B9B9B)),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Total \$2500',
                      style: GoogleFonts.poly(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          color: Color(0xff3B7254)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                  child: ListView.builder(
                    itemBuilder: (c, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OrderContainer(
                            supplierName: "${listOfsuppliers[i]['supplierName']}",
                            subTotal:
                            double.tryParse(
                                "${listOfsuppliers[i]['subTotal']}"),
                            verificationCode:
                            "${listOfsuppliers[i]['verificationCode']}",
                            orderItems: TotalOrders![i]
                        ),
                      );
                    },
                    itemCount: 3,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItem {
  final String imageUrl;
  final String title;
  final int quantity;
  final double price;
  final String? weight;

  OrderItem({
    required this.imageUrl,
    required this.title,
    required this.quantity,
    required this.price,
    this.weight,
  });
}

class OrderItemCard extends StatelessWidget {
  final OrderItem orderItem;

  OrderItemCard({required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffF1F1F1),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              width: 88,
              height: 85,
              child: Image.asset(
                orderItem.imageUrl,
                width: 88,
                height: 85,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderItem.title,
                    style: GoogleFonts.poly(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xff000000)),
                  ),
                  Text('Quantity: ${orderItem.quantity}',
                      style: GoogleFonts.poly(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff828282))),
                  Text('Price: \$${orderItem.price.toStringAsFixed(2)}',
                      style: GoogleFonts.poly(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff828282))),
                  if (orderItem.weight != null)
                    Text('Weight: ${orderItem.weight}',
                        style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderContainer extends StatelessWidget {
  String? supplierName;
  String? verificationCode;
  double? subTotal;
  List<OrderItem>? orderItems;

  OrderContainer({required this.supplierName,
    required this.verificationCode,
    required this.subTotal,
    required this.orderItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      margin: EdgeInsets.only(left: 5, right: 5),
      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
      decoration: BoxDecoration(
          color: Color(0xffF1F1F1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Supplier Name:',
                      style: GoogleFonts.poly(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color(0xff666666)),
                    ),
                    TextSpan(text: " "),
                    TextSpan(
                      text: '${this.supplierName ?? "Oxford"}',
                      style: GoogleFonts.poly(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color(0xff000000)),
                    ),
                  ],
                ),
              ),
              Text(
                'Sub Total',
                style: GoogleFonts.poly(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xff3B7254)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Verification code: ${this.verificationCode ?? "Not found"}',
                style: GoogleFonts.poly(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xff000000)),
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: "\$",
                        style: TextStyle(fontSize: 16, color: Colors.green)),
                    TextSpan(
                        text: "${subTotal}",
                        style: TextStyle(fontSize: 16, color: Colors.green)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 98,
                height: 30,
                padding:
                EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Text(
                      'Pending',
                      style: GoogleFonts.poly(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color(0xff000000)),
                    )),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: this.orderItems!.length ?? 0,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: (){
                      Get.to(ProductDetailPage());
                    },
                    child: OrderItemCard(orderItem: this.orderItems![index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
