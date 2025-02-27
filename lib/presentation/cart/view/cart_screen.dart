import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task2/presentation/cart/cubit/cart_cubit.dart';
import 'package:task2/presentation/cart/model/cart_model.dart';
import 'package:task2/presentation/history_screen/cubit/order_history_cubit.dart';
import 'package:task2/presentation/payment/view/payment_screen.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xff090D14),
      body: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, cartItems) {
          double totalPrice = context.read<CartCubit>().getTotalPrice();
          bool isCartEmpty = cartItems.isEmpty;

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding * 1.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: SvgPicture.asset(
                            'assets/sign_up_assets/back.svg',
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Text(
                          "Shopping Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Switzer',
                            fontSize: fontSize * 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  if (isCartEmpty) ...[
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              "assets/empty_state/empty_cart.svg",
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              "Cart empty",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize,
                                fontFamily: 'Switzer',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              "Your cart is empty.",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: fontSize * 0.75,
                                fontFamily: 'Switzer',
                              ),
                            ),
                            Text(
                              "Start adding items to enjoy shopping!",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: fontSize * 0.75,
                                fontFamily: 'Switzer',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: padding,
                          horizontal: padding,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff1E1C16),
                          border: Border.all(
                            color: Color(0xffE09C35),
                            width: 0.4,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.info, color: Color(0xffE09C35)),
                            SizedBox(width: size.width * 0.02),
                            Text(
                              "Product more than 2 days are automatically lost",
                              style: TextStyle(
                                color: Color(0xffE09C35),
                                fontSize: fontSize * 0.65,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return CartItemTile(item: item);
                        },
                      ),
                    ),
                    Text(
                      "Order Summary",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                        fontFamily: 'Switzer',
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: padding,
                          horizontal: padding,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff161C25),
                          border: Border.all(
                            color: Color(0xff3579DD),
                            width: 0.4,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/home_assets/promo.svg',
                              fit: BoxFit.scaleDown,
                              colorFilter: ColorFilter.mode(
                                Color(0xff3579DD),
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: size.width * 0.02),
                            Text(
                              "Add promos before you order",
                              style: TextStyle(
                                color: Color(0xff3579DD),
                                fontSize: fontSize * 0.65,
                                fontFamily: 'Switzer',
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xff3579DD),
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Container(
                      padding: EdgeInsets.all(padding),
                      color: const Color(0xff090D14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "items",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: fontSize,
                                  fontFamily: 'Switzer',
                                ),
                              ),
                              Text(
                                "AED ${totalPrice.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Switzer',
                                  fontSize: fontSize,
                                ),
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey, thickness: 0.1),
                          SizedBox(height: size.height * 0.01),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff3579DD),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: padding * 1,
                              ),
                            ),
                            onPressed: () {
                              final cartCubit = context.read<CartCubit>();
                              final orderHistoryCubit =
                                  context.read<OrderHistoryCubit>();

                              orderHistoryCubit.addOrder(cartCubit.state);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentScreen(),
                                ),
                              );
                            },
                            child: Center(
                              child: Text(
                                "Proceed to Pay",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.white,
                                  fontFamily: 'Switzer',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  final CartItem item;

  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: padding * 0.1,
        horizontal: padding * 1.6,
      ),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item.image,
              width: size.width * 0.2,
              height: size.height * 0.1,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: size.width * 0.05),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Switzer',
                ),
              ),
              SizedBox(height: size.height * 0.001),
              Text(
                item.description,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: fontSize * 0.6,
                  fontFamily: 'Switzer',
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                "AED ${item.price}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontFamily: 'Switzer',
                ),
              ),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: padding * 0.1,
                  vertical: padding * 0.1,
                ),
                decoration: BoxDecoration(
                  color: Color(0xff161C25),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<CartCubit>().updateQuantity(
                          item.name,
                          item.quantity - 1,
                          context,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.remove,
                          color: Color(0xff3579DD),
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    Text(
                      "${item.quantity}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                        fontFamily: 'Switzer',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    GestureDetector(
                      onTap: () {
                        context.read<CartCubit>().updateQuantity(
                          item.name,
                          item.quantity + 1,
                          context,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Color(0xff3579DD),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
