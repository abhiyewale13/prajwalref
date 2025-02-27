import 'dart:ui';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task2/presentation/home_screen/home_screen/cubit/earned_points_cubit.dart';
import '../../../cart/view/cart_screen.dart';
import '../../recommendation/view/recommendation_screen.dart';
import '../../home_detail_screen/view/home_detail_screen.dart';
import '../model/recommendation_model.dart';
import '../../pick_location/pick_location_screen.dart';
import '../../../profile/user_profile.dart';

class HomeScreen extends StatelessWidget {
  final bool showSnackbar;
  final DateTime? selectedDate;
  final String? selectedStartTime;
  final String? selectedEndTime;
  const HomeScreen({
    super.key,
    this.showSnackbar = false,
    this.selectedDate,
    this.selectedStartTime,
    this.selectedEndTime

  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xff090D14),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: SizedBox(
                height: size.height * 0.4,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SvgPicture.asset(
                        'assets/home_assets/blur.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                        child: Container(color: Colors.transparent),
                      ),
                    ),
                    Positioned(
                      right: padding,
                      top: padding,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const ShoppingCartScreen(),
                                ),
                              );
                            },
                            child: SvgPicture.asset(
                              "assets/home_assets/cart.svg",
                              height: size.width * 0.12,
                            ),
                          ),
                          SizedBox(width: padding),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserProfile(),
                                ),
                              );
                            },
                            child: Image.asset(
                              "assets/home_assets/pfp.png",
                              height: size.width * 0.12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/home_assets/bulb.png",
                            height: size.width * 0.15,
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            "My Rewards Points",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                              fontFamily: 'Switzer',
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            "Earned Points",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize * 0.7,
                              fontFamily: 'Switzer',
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          BlocBuilder<EarnedPointsCubit, int>(
                            builder: (context, state) {
                              return Text(
                                "$state",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSize * 3,
                                  fontFamily: 'Switzer',
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.12,
              child: Swiper(
                itemCount: 6,
                itemBuilder: (context, index) => const CouponContainer(),
                axisDirection: AxisDirection.down,
                scrollDirection: Axis.vertical,
                itemHeight: 70,
                itemWidth: double.infinity,
                loop: true,
                autoplay: true,
                duration: 1000,
                viewportFraction: 0.3,
                scale: 0.85,
                layout: SwiperLayout.STACK,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding * 1.6),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PickLocationScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    color: Color(0xff161C25),
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
                          "assets/home_assets/pin.svg",

                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(width: size.width * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Location",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Switzer',
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Text(
                            "Some random road no 28",
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
            SizedBox(height: size.height * 0.02),
            RecommendationsWidget(),
          ],
        ),
      ),
    );
  }
}

class CouponContainer extends StatelessWidget {
  const CouponContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.04;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding * 2),
      child: Container(
        height: size.height * 0.1,
        padding: EdgeInsets.symmetric(
          vertical: padding,
          horizontal: padding * 1.5,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff0ECCB3),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/home_assets/star.svg",
              width: size.width * 0.08,
            ),
            SizedBox(width: size.width * 0.02),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Coupons",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                      fontFamily: 'Switzer',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.001),
                  Text(
                    "Apply W34EAFIK for discount",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize * 0.75,
                      fontFamily: 'Switzer',
                    ),
                  ),
                ],
              ),
            ),

            SvgPicture.asset(
              "assets/home_assets/arrow.svg",
              width: size.width * 0.07,
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendationsWidget extends StatelessWidget {
  const RecommendationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.04;
    double fontSize = size.width * 0.045;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height * 0.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Row(
            children: [
              Text(
                "Recommended for you",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Switzer',
                  fontSize: fontSize,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecommendationScreen(items: items),
                    ),
                  );
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                    color: const Color(0xff3579DD),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Switzer',
                    fontSize: fontSize * 0.9,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.02),
        SizedBox(
          height: size.height * 0.3,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: padding),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeDetailScreen(item: item),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: padding),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              item.image,
                              height: size.height * 0.2,
                              width: size.width * 0.7,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (items[index].isSuperstar)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: superStar(size),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      width: size.width * 0.7,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: padding * 0.5,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    items[index].title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Switzer',
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSize * 0.85,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.005),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/home_assets/rating.svg",
                                        height: size.width * 0.045,
                                        width: size.width * 0.045,
                                      ),
                                      SizedBox(width: size.width * 0.02),
                                      Text(
                                        items[index].rating,
                                        style: GoogleFonts.prompt(
                                          color: Colors.white,
                                          fontSize: fontSize * 0.75,
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.02),
                                      Text(
                                        "(${items[index].reviews})",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontFamily: 'Switzer',
                                          fontSize: fontSize * 0.7,
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.02),
                                      Text(
                                        "${items[index].distance} away",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontFamily: 'Switzer',
                                          fontSize: fontSize * 0.7,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(height: size.height * 0.005),
                                Text(
                                  'AED ${items[index].price}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Switzer',
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSize * 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget superStar(Size size) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: size.width * 0.02,
      vertical: size.height * 0.005,
    ),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [const Color(0xff3579DD), const Color(0xff3DFF51)],
      ),
      borderRadius: BorderRadius.circular(42),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/home_assets/crown.svg",
          height: size.width * 0.04,
        ),
        SizedBox(width: size.width * 0.01),
        Text(
          "Superstar Stuff",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Switzer',
            fontSize: size.width * 0.03,
          ),
        ),
      ],
    ),
  );
}
