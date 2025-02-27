import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task2/presentation/cart/model/cart_model.dart';
import 'package:task2/presentation/history_screen/cubit/order_history_cubit.dart';
import 'package:task2/presentation/receipt/receipt_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
          child: BlocBuilder<OrderHistoryCubit, List<CartItem>>(
            builder: (context, orderHistory) {
              if (orderHistory.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        "assets/empty_state/no_history.svg",
                      ),
                    ),
                    Text(
                      "No History",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize * 1.6,
                        fontFamily: 'Switzer',
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "No purchases have been made by you at the moment",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: fontSize * 0.7,
                        fontFamily: 'Switzer',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: padding * 3, bottom: padding),
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Align(
                    alignment: Alignment.center,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: size.height * 0.6),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff202938),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            padding: EdgeInsets.only(
                              top: padding * 5,
                              left: padding,
                              right: padding,
                              bottom: padding,
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: orderHistory.length,
                              separatorBuilder:
                                  (context, index) => Divider(
                                    color: Color(0xff202938),
                                    thickness: 1,
                                  ),
                              itemBuilder: (context, index) {
                                final item = orderHistory[index];
                                return ListTile(
                                  leading: Image.asset(
                                    item.image,
                                    width: 50,
                                    height: 50,
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Switzer',
                                          fontSize: fontSize * 0.8,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Qty: ${item.quantity}",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontFamily: 'Switzer',
                                          fontSize: fontSize * 0.6,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Text(
                                    "AED ${item.price}",
                                    style: TextStyle(
                                      fontSize: fontSize * 0.9,
                                      color: Colors.white,
                                      fontFamily: 'Switzer',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          Positioned(
                            top: 15,
                            right: 15,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: Text(
                                    "UPCOMING ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSize * 0.7,
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.width * 0.02),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReceiptScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xff367ADD),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: Text(
                                      "view receipt",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize * 0.7,
                                      ),
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
