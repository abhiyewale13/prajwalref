import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task2/presentation/apple_pay_animation/apple_pay.dart';
import 'package:task2/presentation/payment/cubit/payment_cubit.dart';
import 'package:task2/presentation/wallet/wallet_screen.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xff090D14),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding * 1.6),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset("assets/sign_up_assets/back.svg"),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    "Payment Method",
                    style: TextStyle(
                      fontSize: fontSize * 1.2,
                      color: Colors.white,
                      fontFamily: 'Switzer',
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding * 1.6),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WalletScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(padding),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(42),
                          border: Border.all(color: Color(0xff202938)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(padding),
                              decoration: BoxDecoration(
                                color: Color(0xff2D3748),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xff202938),
                                  width: 2,
                                ),
                              ),
                              child: SvgPicture.asset(
                                "assets/payment_assets/wallet.svg",

                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            SizedBox(width: size.width * 0.03),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Wallet",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Switzer',
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),
                                Text(
                                  "Available balance : AED 183.43",
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontFamily: 'Switzer',
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xff3579DD),
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    "Other Method",
                    style: TextStyle(
                      fontSize: fontSize * 1,
                      color: Colors.white,
                      fontFamily: 'Switzer',
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  PaymentMethod(
                    iconPath: "assets/payment_assets/master.svg",
                    label: "MasterCard",
                  ),
                  SizedBox(height: size.height * 0.02),
                  PaymentMethod(
                    iconPath: "assets/payment_assets/paypal.svg",
                    label: "Paypal",
                  ),
                  SizedBox(height: size.height * 0.02),
                  PaymentMethod(
                    iconPath: "assets/payment_assets/stripe.svg",
                    label: "Stripe",
                  ),
                  SizedBox(height: size.height * 0.02),
                  PaymentMethod(
                    iconPath: "assets/payment_assets/apl_pay.svg",
                    label: "Apple Pay",
                  ),
                  SizedBox(height: size.height * 0.02),
                  buildDebitCard(context),
                  SizedBox(height: size.height * 0.05),
                  Divider(color: Colors.grey, thickness: 0.1),
                  SizedBox(height: size.height * 0.01),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff3579DD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: EdgeInsets.symmetric(vertical: padding * 1.2),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApplePayScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        "Proceed Payment",
                        style: TextStyle(
                          fontSize: fontSize,
                          color: Colors.white,
                          fontFamily: 'Switzer',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentMethod extends StatelessWidget {
  final String iconPath;
  final String label;

  const PaymentMethod({super.key, required this.iconPath, required this.label});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;
    return BlocBuilder<PaymentCubit, String?>(
      builder: (context, selectedMethod) {
        bool isSelected = selectedMethod == label;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding * 1.6),
          child: GestureDetector(
            onTap: () {
              context.read<PaymentCubit>().selectPaymentMethod(label);
            },
            child: Container(
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(42),
                border: Border.all(color: Color(0xff202938)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(padding),
                    decoration: BoxDecoration(
                      color: Color(0xff2D3748),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xff202938), width: 2),
                    ),
                    child: SvgPicture.asset(iconPath, fit: BoxFit.scaleDown),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Switzer',
                          fontSize: fontSize * 0.9,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: Color(0xff3579DD),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildDebitCard(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  double padding = size.width * 0.03;
  double fontSize = size.width * 0.05;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: padding * 1.6),
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: padding * 1.5,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(42),
        border: Border.all(color: Color(0xff202938)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.add, color: Colors.white),
          SizedBox(width: size.width * 0.03),
          Text(
            'Add Debit Card',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize * 0.9,
              fontFamily: 'Switzer',
            ),
          ),
        ],
      ),
    ),
  );
}

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;
    return Dialog(
      insetPadding: EdgeInsets.all(padding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.black,
      child: Padding(
        padding: EdgeInsets.all(padding * 1.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/receipt_assets/check.svg"),
            SizedBox(height: size.height * 0.02),
            Text(
              "Checkout Success!",
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              "Your order is confirmed and on its way. Get set to savor your chosen delights!",
              style: TextStyle(fontSize: fontSize * 0.7, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.02),
            const CircularProgressIndicator(color: Color(0xff3579DD)),
          ],
        ),
      ),
    );
  }
}
