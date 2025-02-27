import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;
    return Scaffold(
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
                SizedBox(height: size.height * 0.04),
                Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.more_horiz_outlined, color: Colors.white),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                      Text(
                        "Available Balance",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: fontSize * 0.7,
                          fontFamily: 'Switzer',
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        "AED 183.43",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize * 1.8,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Switzer',
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomButtons(
                              label: "Add Money",
                              color: Color(0xff3579DD),
                              textColor: Colors.white,
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Expanded(
                            child: CustomButtons(
                              label: "Change Wallet",
                              color: Color(0xff0D1828),
                              textColor: Color(0xff3579DD),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Text(
                  "Last Transactions",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize * 1.2,
                    fontFamily: 'Switzer',
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

class CustomButtons extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  const CustomButtons({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.04;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(42)),
        padding: EdgeInsets.symmetric(vertical: padding * 1.2),
      ),
      onPressed: () {},
      child: FittedBox(
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontFamily: 'Switzer',
          ),
        ),
      ),
    );
  }
}
