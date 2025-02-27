import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:task2/core/custom_snackbar.dart';
import '../date_of_birth/date_of_birth.dart';
import 'phone_auth/phone_auth.dart';

class PhoneVerification extends StatefulWidget {
  final String phoneNumber;
  const PhoneVerification({super.key, required this.phoneNumber});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final TextEditingController otpController = TextEditingController();
  bool isOtpEntered = false;
  bool isVerifying = false;

  @override
  void initState() {
    super.initState();
    otpController.addListener(() {
      setState(() {
        isOtpEntered = otpController.text.isNotEmpty;
      });
    });
  }

  Future<void> _storePhoneNumber(String phoneNumber) async {
    final firebaseAuth = FirebaseAuth.instance;
    final supabaseUser = supabase.Supabase.instance.client.auth.currentUser;

    String? uid;
    String? email;

    if (firebaseAuth.currentUser != null) {
      uid = firebaseAuth.currentUser!.uid;
      email = firebaseAuth.currentUser!.email;
    } else if (supabaseUser != null) {
      uid = supabaseUser.id;
      email = supabaseUser.email;
    }

    if (uid != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'phoneNumber': phoneNumber,
          'email': email,
        }, SetOptions(merge: true));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DateOfBirth()),
        );
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print("No user found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double iconSize = size.width * 0.05;
    double fontSize = size.width * 0.05;
    return Scaffold(
      backgroundColor: const Color(0xff090D14),
      appBar: AppBar(
        backgroundColor: const Color(0xff090D14),
        leading: Padding(
          padding: EdgeInsets.only(left: padding * 1.5),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              "assets/sign_up_assets/back.svg",
              height: iconSize,
              width: iconSize,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding * 1.5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.1),
              Text(
                "Verify your phone number",
                style: TextStyle(
                  fontSize: fontSize * 1.8,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Switzer',
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                "We've sent an SMS with an activation code to your phone ${widget.phoneNumber}",
                style: TextStyle(
                  fontSize: fontSize * 1,
                  color: Colors.white70,
                  fontFamily: 'Switzer',
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: size.height * 0.1),
              PinCodeTextField(
                cursorColor: Colors.white,
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                controller: otpController,
                autoFocus: true,
                textStyle: TextStyle(fontSize: 18, color: Colors.white),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12.0),
                  fieldHeight: 60,
                  fieldWidth: 50,
                  activeFillColor: Color(0xff090D14),
                  selectedFillColor: Color(0xff090D14),
                  inactiveFillColor: Color(0xff090D14),
                  activeColor: Color(0xff3579DD),
                  selectedColor: Color(0xff3579DD),
                  inactiveColor: Color(0xff3579DD),
                ),
                onChanged: (value) {},
                enableActiveFill: true,
              ),
              SizedBox(height: size.height * 0.05),
              Align(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "I didn't receive the code ",
                        style: TextStyle(
                          fontSize: fontSize * 0.8,
                          color: Colors.white70,
                          fontFamily: 'Switzer',
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: GestureDetector(
                          onTap: () async {
                            bool success = await TwilioVerifyService().sendOtp(
                              widget.phoneNumber,
                            );
                            if (success) {
                              showCustomSnackbar(
                                context,
                                "New OTP has been sent",
                                Colors.green.shade600,
                              );
                            } else {
                              showCustomSnackbar(
                                context,
                                "Failed to resend OTP try again!",
                                Colors.red.shade600,
                              );
                            }
                          },
                          child: Text(
                            "Resend",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize * 0.8,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Switzer',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
              GestureDetector(
                onTap: () async {
                  if (isOtpEntered && !isVerifying) {
                    setState(() {
                      isVerifying = true;
                    });
                    bool isValid = await TwilioVerifyService().verifyOtp(
                      widget.phoneNumber,
                      otpController.text,
                    );
                    if (isValid) {
                      print('OTP Verified');
                      await _storePhoneNumber(widget.phoneNumber);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DateOfBirth()),
                      );
                    } else {
                      showCustomSnackbar(
                        context,
                        "Invalid OTP, Please try again!",
                        Colors.red.shade600,
                      );
                    }
                    setState(() {
                      isVerifying = false;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(padding * 1.5),
                  decoration: BoxDecoration(
                    color: isOtpEntered ? Color(0xff3579DD) : Color(0xff4D4D4D),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child:
                      isVerifying
                          ? const Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          )
                          : Text(
                            "Verify",
                            style: GoogleFonts.inter(
                              fontSize: fontSize,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
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
