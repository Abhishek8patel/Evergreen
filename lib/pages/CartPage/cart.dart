import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../OrderDetailsPage/order_details.dart';
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button
          },
        ),
        title: Text('My Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Color(0xffF0F0F0)))),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CartItem(
                    image: 'assets/images/demoplant.png',
                    name: 'Aloe Vera',
                    size: 'Medium',
                    price: 30.0,
                    quantity: 1,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Color(0xffF0F0F0)))),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CartItem(
                    image: 'assets/images/demoplant.png',
                    name: 'Globie',
                    size: 'Medium',
                    price: 50.0,
                    quantity: 1,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Color(0xffF0F0F0)))),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CartItem(
                    image: 'assets/images/demoplant.png',
                    name: 'Chew',
                    size: 'Medium',
                    price: 90.0,
                    quantity: 1,
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: GoogleFonts.poly(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xff000000)),
                          ),
                          Text(
                            '${170.00}',
                            style: GoogleFonts.poly(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xff000000)),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    AddressForm(),
                    Divider(),
                    PaymentMethod(),
                    SizedBox(height: 30),
                    Center(
                      child: Container(
                        width: 295,
                        height: 78,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffABFFE7)),

                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff040A05)),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Get.to(OrderDetails());
                            },
                            child: Text(
                              'Checkout',
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
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String image;
  final String name;
  final String size;
  final double price;
  final int quantity;

  CartItem({
    required this.image,
    required this.name,
    required this.size,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 66,
                width: 66,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    spreadRadius: 0, // Spread radius
                    blurRadius: 6, // Blur radius
                    offset:
                        Offset(0, 3), // Offset in x and y direction (x: 0, y: 3)
                  ),
                ], color: Colors.white),
                child: Image.asset(
                  image,
                  width: 66,
                  height: 66,
                  fit: BoxFit.cover,
                )),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: GoogleFonts.aclonica(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Color(0xff3B7254))),
                  Text('Size: $size',
                      style: GoogleFonts.poly(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff34493A))),
                  Text('Price: \$$price',
                      style: GoogleFonts.poly(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff34493A))),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 41,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      border: Border.all(color: Color(0xffABFFE7)),
                      color: Color(0xff040A05)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 15,
                            ),
                            onPressed: () {}),
                      ),
                      Text(
                        '$quantity',
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                          onPressed: () {

                          }),
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),

      ],
    );
  }
}

class AddressForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shipping Address',
              style: GoogleFonts.poly(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xff8F8585))),
          SizedBox(height: 10),
          Text('Indore, M.P.',
              style: GoogleFonts.poly(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: Color(0xff000000))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCCCCCC)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCCCCCC)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff8F8585)),
                  ),
                  labelText: 'Pin code',
                  prefixStyle: GoogleFonts.poly(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xff8F8585))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCCCCCC)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCCCCCC)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff8F8585)),
                  ),
                  labelText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCCCCCC)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCCCCCC)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff8F8585)),
                  ),
                  labelText: 'Mobile Number'),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  String? _paymentMethod = 'Online';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 292,
            height: 51,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff040A05),
              border: Border.all(color: Color(0xffABFFE7)),
            ),
            child: ListTile(
              style: ListTileStyle.list,
              title: Text(
                'COD',
                style: GoogleFonts.aclonica(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white),
              ),
              leading: Radio<String>(
                activeColor: Colors.white,
                fillColor: new MaterialStatePropertyAll(Color(0xffffffff)),
                value: 'COD',
                groupValue: _paymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _paymentMethod = value;
                  });
                },
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Center(
          child: Container(
            width: 292,
            height: 51,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffABFFE7)),
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff040A05)),
            child: ListTile(
              horizontalTitleGap: 18,
              title: Text(
                'Online',
                style: GoogleFonts.aclonica(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white),
              ),
              leading: Radio<String>(
                fillColor: new MaterialStatePropertyAll(Color(0xffffffff)),
                value: 'Online',
                groupValue: _paymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _paymentMethod = value;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
