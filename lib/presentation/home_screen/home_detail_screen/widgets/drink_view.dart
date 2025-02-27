import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/presentation/cart/cubit/cart_cubit.dart';
import 'package:task2/presentation/cart/model/cart_model.dart';
import 'package:task2/presentation/cart/view/cart_screen.dart';
import 'package:task2/presentation/home_screen/home_detail_screen/cubit/cart_buttons.dart';
import 'package:task2/presentation/home_screen/home_detail_screen/model/drink_model.dart';
import 'package:task2/presentation/home_screen/home_detail_screen/widgets/quantity_control.dart';

Widget buildDrinkView(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  double padding = size.width * 0.03;
  double fontSize = size.width * 0.05;

  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Drinks',
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
                itemCount: drinks.length,
                itemBuilder: (context, index) {
                  final package = drinks[index];
                  return _buildDrinkItem(context, package);
                },
              ),
            ),
          ],
        ),
      ),

      BlocBuilder<CartButtonCubit, Map<String, int>>(
        builder: (context, state) {
          bool showDrinkButtons = state.values.any((quantity) => quantity > 0);

          return Visibility(
            visible: showDrinkButtons,
            child: Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Container(
                  color: Color(0xff090D14),
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: size.width * 0.05,
                  ),
                  child: Row(
                    // spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        context,
                        label: "Add to Cart",
                        color: Colors.transparent,
                        textColor: Color(0xff3579DD),
                        onTap: () {
                          final cartCubit = context.read<CartCubit>();
                          bool itemAdded = false;
                          state.forEach((itemName, quantity) {
                            if (quantity > 0) {
                              final item = drinks.firstWhere(
                                (d) =>
                                    d.title.trim().toLowerCase() ==
                                    itemName.trim().toLowerCase(),
                                orElse:
                                    () => DrinkModel(
                                      imageUrl: '',
                                      title: '',
                                      price: '0',
                                    ),
                              );
                              if (item.title.isNotEmpty) {
                                cartCubit.addToCart(
                                  CartItem(
                                    name: item.title,
                                    description: "Drink",
                                    price: double.parse(
                                      item.price.replaceAll(
                                        RegExp(r'[^\d.]'),
                                        '',
                                      ),
                                    ),
                                    quantity: quantity,
                                    image: item.imageUrl,
                                  ),
                                  context,
                                );
                                itemAdded = true;
                              } else {
                                print("Item not found: $itemName");
                              }
                            }
                          });

                          if (itemAdded) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Items added to cart!"),
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(width: 10),
                      _buildActionButton(
                        context,
                        label: "Buy Now",
                        color: Color(0xff3579DD),
                        textColor: Colors.white,
                        onTap: () {
                          final cartCubit = context.read<CartCubit>();
                          bool itemAdded = false;

                          state.forEach((itemName, quantity) {
                            if (quantity > 0) {
                              final drink = drinks.firstWhere(
                                (d) =>
                                    d.title.trim().toLowerCase() ==
                                    itemName.trim().toLowerCase(),
                                orElse:
                                    () => DrinkModel(
                                      imageUrl: '',
                                      title: '',
                                      price: '0',
                                    ),
                              );

                              if (drink.title.isNotEmpty) {
                                cartCubit.addToCart(
                                  CartItem(
                                    name: drink.title,
                                    description: "Drink",
                                    price: double.parse(
                                      drink.price.replaceAll(
                                        RegExp(r'[^\d.]'),
                                        '',
                                      ),
                                    ),
                                    quantity: quantity,
                                    image: drink.imageUrl,
                                  ),
                                  context,
                                );
                                itemAdded = true;
                              } else {
                                print(
                                  "Error: Drink '$itemName' not found in the drinks list",
                                );
                              }
                            }
                          });

                          if (itemAdded) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShoppingCartScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please select at least one drink before buying!",
                                ),
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}

Widget _buildDrinkItem(BuildContext context, DrinkModel drinks) {
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
              drinks.imageUrl,
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
              drinks.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontFamily: 'Switzer',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              drinks.price,
              style: TextStyle(
                color: Colors.grey,
                fontSize: fontSize,
                fontFamily: 'Switzer',
              ),
            ),
          ],
        ),
        Spacer(),
        QuantityControl(category: drinks.title),
      ],
    ),
  );
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
        padding: EdgeInsets.symmetric(vertical: 12),
        side: BorderSide(color: Color(0xff3579DD)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      onPressed: onTap,
      child: Text(label, style: TextStyle(color: textColor, fontSize: 16)),
    ),
  );
}
