import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../cart/view/cart_screen.dart';
import '../cubit/booking_cubit.dart';
import '../model/booking_model.dart';
import '../widgets/affordable_package.dart';
import '../widgets/drink_view.dart';
import '../widgets/time_date.dart';
import '../widgets/chip_widget.dart';
import '../../home_screen/model/recommendation_model.dart';
import '../../../messages_screen/messages_screen.dart';

class HomeDetailScreen extends StatelessWidget {
  final RecommendationModel item;

  const HomeDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return HomeDetailContent(item: item);
  }
}

class HomeDetailContent extends StatelessWidget {
  final RecommendationModel item;
  const HomeDetailContent({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;
    return Scaffold(
      backgroundColor: const Color(0xff090D14),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  item.image,
                  height: size.height * 0.4,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: padding * 2,
                  top: padding * 4,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/sign_up_assets/back.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: padding * 2,
                  top: padding * 4,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShoppingCartScreen(),
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/home_assets/cart.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding * 1.6),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Switzer',
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        '${item.distance} away',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: Colors.white70,
                          fontFamily: 'Switzer',
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessagesScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: padding * 1.5,
                        vertical: padding * 0.8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff3579DD)),
                        borderRadius: BorderRadius.circular(42),
                      ),
                      child: Text(
                        "Message",
                        style: TextStyle(
                          fontSize: fontSize * 0.7,
                          color: Color(0xff3579DD),
                          fontFamily: 'Switzer',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: size.height * 0.05),
            Padding(
              padding: EdgeInsets.only(left: padding * 1.6),
              child: Text(
                "Book a table",
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontFamily: 'Switzer',
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            BookingWidget(),
          ],
        ),
      ),
    );
  }
}

class BookingWidget extends StatelessWidget {
  const BookingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const BookingContent(); 
  }
}

class BookingContent extends StatelessWidget {
  const BookingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.02),
        buildNavigationChips(context),
        SizedBox(height: size.height * 0.02),
        SizedBox(
          height: size.height * 0.4,
          child: BlocBuilder<BookingCubit, BookingState>(
            builder: (context, state) {
              switch (state.currentView) {
                case BookingView.dateTime:
                  return buildDateTimeView(context);
                case BookingView.package:
                  return buildPackagesView(context);
                case BookingView.drink:
                  return buildDrinkView(context);
              }
            },
          ),
        ),
      ],
    );
  }
}
