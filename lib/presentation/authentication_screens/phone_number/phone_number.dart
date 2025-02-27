import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_picker/country_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:task2/core/custom_snackbar.dart';
import 'package:task2/presentation/authentication_screens/phone_number/country_picker.dart';
import 'package:task2/presentation/authentication_screens/phone_number/phone_auth/phone_auth.dart';
import 'package:task2/presentation/authentication_screens/phone_number/phone_verification.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  String userName = "there";

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "2012345678",
    displayName: "India (IN) [+91]",
    displayNameNoCountryCode: "India",
    e164Key: "",
  );

  final TextEditingController phoneController = TextEditingController();
  bool isPhoneEnter = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUserName();
    phoneController.addListener(() {
      setState(() {
        isPhoneEnter = phoneController.text.isNotEmpty;
      });
    });
  }

  void _pickCountry() async {
    final chosenCountry = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChooseCountryScreen()),
    );

    if (chosenCountry != null && chosenCountry is Country) {
      setState(() {
        selectedCountry = chosenCountry;
      });
    }
  }

  Future<void> fetchUserName() async {
    final firebase_auth.User? firebaseUser =
        firebase_auth.FirebaseAuth.instance.currentUser;
    final supabase.User? supabaseUser =
        supabase.Supabase.instance.client.auth.currentUser;

    if (firebaseUser == null && supabaseUser == null) {
      print("No authenticated user found.");
      return;
    }

    String uid = firebaseUser?.uid ?? supabaseUser!.id;
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc.exists && userDoc.data() != null) {
      print("User data found in Firestore: ${userDoc.data()}");
      setState(() {
        userName = userDoc.data()!['name'] ?? "there";
      });
    } else {
      print("User not found in Firestore, trying fallback.");

      if (firebaseUser != null) {
        String email = firebaseUser.email ?? "";
        if (email.isNotEmpty) {
          setState(() {
            userName = email.split('@').first;
          });
        }
      }
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
        padding: EdgeInsets.symmetric(horizontal: padding * 1.6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.03),
            Text(
              "Hi $userName!",
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize * 1.6,
                fontFamily: 'Switzer',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              "Please enter your phone number",
              style: GoogleFonts.inter(
                color: Colors.white70,
                fontSize: fontSize * 1,
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Row(
              children: [
                InkWell(
                  onTap: _pickCountry,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: padding,
                      vertical: padding * 1.3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          selectedCountry.flagEmoji,
                          style: GoogleFonts.inter(fontSize: fontSize),
                        ),
                        SizedBox(width: size.width * 0.04),
                        Text(
                          "+${selectedCountry.phoneCode}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: size.width * 0.02),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: iconSize * 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                Expanded(
                  child: TextField(
                    cursorColor: Colors.white70,
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: GoogleFonts.inter(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      hintStyle: GoogleFonts.inter(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.07),
            GestureDetector(
              onTap: () async {
                if (isPhoneEnter && !isLoading) {
                  setState(() {
                    isLoading = true;
                  });

                  String phoneNumber =
                      "+${selectedCountry.phoneCode}${phoneController.text}";

                  bool success = await TwilioVerifyService().sendOtp(
                    phoneNumber,
                  );

                  if (success) {
                    print('OTP Sent');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                PhoneVerification(phoneNumber: phoneNumber),
                      ),
                    );
                  } else {
                    showCustomSnackbar(
                      context,
                      "Error, Try Again",
                      Colors.red.shade600,
                    );
                  }

                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(padding * 1.5),
                decoration: BoxDecoration(
                  color:
                      isPhoneEnter
                          ? const Color(0xff3579DD)
                          : Color(0xff4D4D4D),
                  borderRadius: BorderRadius.circular(24),
                ),
                child:
                    isLoading
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
                          "Send OTP",
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
    );
  }
}
