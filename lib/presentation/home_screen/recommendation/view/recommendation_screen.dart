import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task2/presentation/home_screen/home_screen/model/recommendation_model.dart';

class RecommendationScreen extends StatelessWidget {
  final List<RecommendationModel> items;
  const RecommendationScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;
    return Scaffold(
      backgroundColor: Color(0xff090C15),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding * 1.6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTwo(),
              SizedBox(height: size.height * 0.03),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding * 1.6),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: padding),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  items[index].image,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: size.width * 0.03),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      items[index].title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSize,
                                        fontFamily: 'Switzer',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/home_assets/rating.svg",
                                          height: size.height * 0.02,
                                          width: size.width * 0.04,
                                        ),
                                        SizedBox(width: size.width * 0.01),
                                        Text(
                                          items[index].rating,
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontFamily: 'Switzer',
                                            fontSize: fontSize * 0.8,
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.01),
                                        Text(
                                          "(${items[index].reviews})",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: fontSize * 0.8,
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.01),
                                        Text(
                                          "${items[index].distance} away",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: fontSize * 0.8,
                                            fontFamily: 'Switzer',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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

class HeaderTwo extends StatelessWidget {
  const HeaderTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding * 1.6),
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
          SizedBox(height: size.height * 0.02),
          Text(
            "Recommended for you",
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontFamily: 'Switzer',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            "Our recommendations depend on your search results.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: fontSize * 0.75,
              fontFamily: 'Switzer',
            ),
          ),
        ],
      ),
    );
  }
}
