import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseCountryScreen extends StatefulWidget {
  const ChooseCountryScreen({super.key});

  @override
  ChooseCountryScreenState createState() => ChooseCountryScreenState();
}

class ChooseCountryScreenState extends State<ChooseCountryScreen> {
  List<Country> allCountries = [];
  List<Country> filteredCountries = [];
  String searchQuery = '';
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  void _loadCountries() {
    allCountries = CountryService().getAll();
    setState(() {
      filteredCountries = List.from(allCountries);
    });
  }

  void _filterCountries(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredCountries = List.from(allCountries);
      } else {
        filteredCountries =
            allCountries.where((country) {
              return country.name.toLowerCase().contains(query.toLowerCase());
            }).toList();

        filteredCountries.sort((a, b) {
          if (a.name.toLowerCase().startsWith(query.toLowerCase())) return -1;
          if (b.name.toLowerCase().startsWith(query.toLowerCase())) return 1;
          return 0;
        });
      }
    });
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
        surfaceTintColor: Colors.transparent,
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding * 1.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.03),
                Text(
                  "Choose Country",
                  style: TextStyle(
                    fontSize: fontSize * 1.6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Switzer',
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  "Don't worry! It happens. Please enter the email associated with your account.",
                  style: TextStyle(
                    fontSize: fontSize * 0.9,
                    color: Colors.grey,
                    fontFamily: 'Switzer',
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                TextField(
                  onChanged: _filterCountries,
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: GoogleFonts.inter(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                final country = filteredCountries[index];
                final isSelected = country == selectedCountry;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding * 1.6),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: padding * 0.3),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? const Color(0xff3579DD)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onTap: () {
                        setState(() {
                          selectedCountry = country;
                        });
                      },
                      leading: Text(
                        country.flagEmoji,
                        style: TextStyle(fontSize: fontSize * 1.5),
                      ),
                      title: Text(
                        "${country.name} (+${country.phoneCode})",
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: fontSize,
                        ),
                      ),
                      trailing:
                          isSelected
                              ? Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: iconSize,
                              )
                              : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(padding * 1.5),
        child: SizedBox(
          width: double.infinity,
          child: InkWell(
            onTap:
                selectedCountry != null
                    ? () {
                      Navigator.pop(context, selectedCountry);
                    }
                    : null,

            child: Container(
              padding: EdgeInsets.all(padding * 1.5),
              decoration: BoxDecoration(
                color:
                    selectedCountry == null
                        ? Color(0xff4D4D4D)
                        : const Color(0xff3579DD),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                "Continue",
                style: GoogleFonts.inter(
                  fontSize: fontSize,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
