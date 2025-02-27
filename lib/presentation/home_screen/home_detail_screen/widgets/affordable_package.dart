import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/presentation/cart/cubit/cart_cubit.dart';
import 'package:task2/presentation/cart/model/cart_model.dart';
import 'package:task2/presentation/cart/view/cart_screen.dart';
import 'package:task2/presentation/home_screen/home_detail_screen/cubit/booking_cubit.dart';
import 'package:task2/presentation/home_screen/home_detail_screen/cubit/cart_buttons.dart';
import 'package:task2/presentation/home_screen/home_detail_screen/model/affordable_package_model.dart';
import 'package:task2/presentation/home_screen/home_detail_screen/model/booking_model.dart';
import 'package:task2/presentation/home_screen/home_detail_screen/widgets/quantity_control.dart';

Widget buildPackagesView(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  double padding = size.width * 0.03;
  double fontSize = size.width * 0.05;

  return BlocBuilder<CartButtonCubit, Map<String, int>>(
    builder: (context, cartState) {
      print("Cart State: $cartState");

      return Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available Packages',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontFamily: 'Switzer',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: affordablePackages.length,
                    itemBuilder: (context, index) {
                      final package = affordablePackages[index];
                      return PackageItem(package: package);
                    },
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: cartState.values.any((quantity) => quantity > 0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Container(
                  color: Color(0xff090D14),
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: size.width * 0.05,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        context,
                        label: "Next",
                        color: Colors.transparent,
                        textColor: Color(0xff3579DD),
                        onTap: () {
                           context.read<BookingCubit>().changeView(BookingView.drink);

                        },
                      ),

                      SizedBox(width: 10),
                      _buildActionButton(
                        context,
                        label: "Clear",
                        color: Color(0xff3579DD),
                        textColor: Colors.white,
                        onTap: () {
                          final cartCubit = context.read<CartCubit>();
                          cartCubit.clearCart(context);
                          
                          

                          cartState.forEach((packageName, quantity) {
                            if (quantity > 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Cart is Cleared",
                                ),
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.red,
                              ),
                            );
                          }

                        
                       

                        },
                      );
                        }
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

class PackageItem extends StatelessWidget {
  final AffordablePackageModel package;

  const PackageItem({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: size.width * 0.2,
            height: size.height * 0.1,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                package.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.restaurant, color: Colors.white);
                },
              ),
            ),
          ),
          SizedBox(width: size.width * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                package.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontFamily: 'Switzer',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                package.price,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: fontSize,
                  fontFamily: 'Switzer',
                ),
              ),
            ],
          ),
          Spacer(),
          QuantityControl(category: package.title),
        ],
      ),
    );
  }
}

Widget _buildActionButton(
  BuildContext context, {
  required String label,
  required Color color,
  required Color textColor,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: const BorderSide(color: Color(0xff3579DD)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      onPressed: onTap,
      child: Text(label, style: TextStyle(color: textColor, fontSize: 16)),
    ),
  );
}
