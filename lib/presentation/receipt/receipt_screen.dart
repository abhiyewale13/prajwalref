

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
 

 

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;
    return Scaffold(
      backgroundColor: const Color(0xff090D14),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding * 1.6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset("assets/sign_up_assets/back.svg"),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                SvgPicture.asset('assets/receipt_assets/qr.svg'),
                SizedBox(height: size.height * 0.04),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: padding * 1.5,
                          horizontal: padding,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Color(0xff0D1828)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height * 0.06),
                            Text(
                              "Order completed",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize * 1.2,
                                fontFamily: 'Switzer',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: size.height * 0.015),
                            Text(
                              "Sit back and await your delicious delivery. Thank you for choosing us to serve up your culinary cravings. Enjoy your meal",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: fontSize * 0.8,
                                fontFamily: 'Switzer',
                              ),
                            ),
                            SizedBox(height: size.height * 0.03),
                            Divider(color: Color(0xff0D1828), thickness: 1.5),
                            SizedBox(height: size.height * 0.02),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Order Summary",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSize,
                                  fontFamily: 'Switzer',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.015),
                            _orderSummaryRow("Order Number", "#9129834903"),
                            _orderSummaryRow("Order Time", "22:25"),
                            _orderSummaryRow("Payment Method", "PayPal"),
                            _orderSummaryRow(
                              "Merchant Name",
                              "paypal",
                              isBold: true,
                            ),
                            SizedBox(height: size.height * 0.02),
                            Divider(color: Color(0xff0D1828), thickness: 1.5),
                            SizedBox(height: size.height * 0.02),
                            _orderSummaryRow("Amount", "AED 218"),
                            _orderSummaryRow("Discount", "AED 25.99"),
                            _orderSummaryRow("Admin Fee", "AED 25.99"),
                            SizedBox(height: size.height * 0.04),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff3579DD),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(42),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: padding * 1.2,
                                  horizontal: padding * 6,
                                ),
                              ),
                              onPressed: () {
                                
                              },
                              child: Text(
                                "Download Receipt",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSize * 0.9,
                                  fontFamily: 'Switzer',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -size.height * 0.03,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(padding * 0.6),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff0D1828),
                            ),
                            child: SvgPicture.asset(
                              "assets/receipt_assets/check.svg",
                              height: size.width * 0.12,
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
      ),
    );
  }
}

Widget _orderSummaryRow(String title, String value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70)),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Switzer',
          ),
        ),
      ],
    ),
  );
}
