import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:task2/core/bottom_navigation_bar.dart';

class DateOfBirth extends StatefulWidget {
  const DateOfBirth({super.key});

  @override
  State<DateOfBirth> createState() => _DateOfBirthState();
}

class _DateOfBirthState extends State<DateOfBirth> {
  int? selectedDay;
  String? selectedMonth;
  int? selectedYear;

  List<int> days = List.generate(31, (index) => index + 1);
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  List<int> years = List.generate(125, (index) => DateTime.now().year - index);

  bool get isDOBSelected =>
      selectedDay != null && selectedMonth != null && selectedYear != null;

  OverlayEntry? overlayEntry;

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  Future<void> _storeDateOfBirth(String dob) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    final supabaseUser = supabase.Supabase.instance.client.auth.currentUser;
    String? uid;
    String? email;

    if (firebaseUser != null) {
      uid = firebaseUser.uid;
      email = firebaseUser.email;
    } else if (supabaseUser != null) {
      uid = supabaseUser.id;
      email = supabaseUser.email;
    }

    if (uid != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'dateOfBirth': dob,
          'email': email,
        }, SetOptions(merge: true));
        print("dob stored");
      } catch (e) {
        print("errror : $e");
      }
    } else {
      print("No user found");
    }
  }

  void showDropdown<T>(
    BuildContext context,
    List<T> items,
    Function(T) onSelect,
    GlobalKey key,
  ) {
    removeOverlay();

    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(
      Offset.zero,
      ancestor: context.findRenderObject(),
    );
    final Size size = renderBox.size;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dropdownHeight = 300;
    final double dropdownWidth = size.width;

    bool showAbove =
        (position.dy + size.height + dropdownHeight > screenHeight);
    double left = position.dx;
    double top =
        showAbove
            ? position.dy - dropdownHeight - 5
            : position.dy + size.height + 5;

    if (left + dropdownWidth > screenWidth) {
      left = screenWidth - dropdownWidth - 16;
    } else if (left < 0) {
      left = 16;
    }

    overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            left: left,
            top: top,
            width: dropdownWidth,
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: dropdownHeight,
                    maxWidth: dropdownWidth,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          items
                              .map(
                                (item) => ListTile(
                                  title: Text(
                                    item.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  onTap: () {
                                    onSelect(item);
                                    removeOverlay();
                                  },
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  final GlobalKey monthKey = GlobalKey();
  final GlobalKey dayKey = GlobalKey();
  final GlobalKey yearKey = GlobalKey();

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
            onTap: () {
              removeOverlay();
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/sign_up_assets/back.svg",
              height: iconSize,
              width: iconSize,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: removeOverlay,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding * 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.1),
              Text(
                "DOB",
                style: TextStyle(
                  fontSize: fontSize * 1.6,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Switzer',
                  color: Colors.white,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                "Share your DOB with us to get special offers",
                style: TextStyle(
                  fontSize: fontSize * 1,
                  color: Colors.white70,
                  fontFamily: 'Switzer',
                ),
              ),
              SizedBox(height: size.height * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDropdown(
                    "MM",
                    selectedMonth,
                    months,
                    (val) => setState(() => selectedMonth = val),
                    monthKey,
                  ),
                  SizedBox(width: size.width * 0.03),
                  _buildDropdown(
                    "DD",
                    selectedDay,
                    days,
                    (val) => setState(() => selectedDay = val),
                    dayKey,
                  ),
                  SizedBox(width: size.width * 0.03),
                  _buildDropdown(
                    "YYYY",
                    selectedYear,
                    years,
                    (val) => setState(() => selectedYear = val),
                    yearKey,
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.08),
              InkWell(
                onTap: () async {
                  if (!isDOBSelected) return;

                  String dob = "$selectedDay $selectedMonth $selectedYear";
                  await _storeDateOfBirth(dob);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNavScreen()),
                  );
                },

                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(padding * 1.5),
                  decoration: BoxDecoration(
                    color:
                        isDOBSelected
                            ? const Color(0xff3579DD)
                            : const Color(0xff4D4D4D),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
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

  Widget _buildDropdown<T>(
    String hint,
    T? selectedValue,
    List<T> items,
    Function(T) onSelect,
    GlobalKey key,
  ) {
    return Expanded(
      child: GestureDetector(
        key: key,
        onTap: () => showDropdown(context, items, onSelect, key),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Color(0xff3579DD)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedValue != null ? selectedValue.toString() : hint,
                style: GoogleFonts.inter(color: Colors.white70),
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
