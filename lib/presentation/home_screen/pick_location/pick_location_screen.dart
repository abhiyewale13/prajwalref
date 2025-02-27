import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:task2/presentation/map/map_screen.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({super.key});

  @override
  _PickLocationScreenState createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  String? _currentAddress;
  bool _isFetching = false;

  Future<void> _getCurrentLocation() async {
    setState(() => _isFetching = true); 

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks.first;

      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      print("Error fetching location: $e");
      setState(() {
        _currentAddress = "Failed to get location";
      });
    } finally {
      setState(() => _isFetching = false); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xff090D14),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding * 1.6),
        child: SafeArea(
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
              SizedBox(height: size.height * 0.05),
              Text(
                "Pick Location",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize * 1.4,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Switzer',
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                "Our recommendation depends on your search result",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: fontSize * 0.8,
                  fontFamily: 'Switzer',
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Color(0xff202938)),
                ),
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.white54),
                    SizedBox(width: padding),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search food",
                          hintStyle: TextStyle(
                            color: Colors.white54,
                            fontFamily: 'Switzer',
                            fontSize: fontSize * 0.8,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: padding * 1.5),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xff202938)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(width: size.width * 0.03),
                            Text(
                              "Add address",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize * 0.9,
                                fontFamily: 'Switzer',
                              ),
                            ),
                            Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white54,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Divider(color: Color(0xff202938)),
                    SizedBox(height: size.height * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: GestureDetector(
                        onTap: _getCurrentLocation,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/home_assets/location.svg",
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: padding),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Use your current location",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: fontSize * 0.9,
                                      fontFamily: 'Switzer',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.005),
                                  _isFetching
                                      ? Text(
                                        "Fetching location...",
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: fontSize * 0.75,
                                          fontFamily: 'Switzer',
                                        ),
                                      )
                                      : Text(
                                        _currentAddress ??
                                            "Tap to fetch location",
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: fontSize * 0.75,
                                          fontFamily: 'Switzer',
                                        ),
                                      ),
                                ],
                              ),
                            ),
                          ],
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
