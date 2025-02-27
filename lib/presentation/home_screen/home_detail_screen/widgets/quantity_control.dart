import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/presentation/home_screen/home_detail_screen/cubit/cart_buttons.dart';

class QuantityControl extends StatefulWidget {
  final String category;

  const QuantityControl({super.key, required this.category});

  @override
  QuantityControlState createState() => QuantityControlState();
}

class QuantityControlState extends State<QuantityControl> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    int quantity = context.watch<CartButtonCubit>().state[widget.category] ?? 0;
    return Center(
      child:
          quantity > 0
              ? Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Color(0xff3579DD)),
                  borderRadius: BorderRadius.circular(42),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<CartButtonCubit>().decreaseQuantity(
                          widget.category,
                        );
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.remove,
                            size: 18,
                            color: Color(0xff3579DD),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      '$quantity',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        context.read<CartButtonCubit>().increaseQuantity(
                          widget.category,
                        );
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 18,
                            color: Color(0xff3579DD),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color(0xff090D14),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                ),
                onPressed: () {
                  setState(() {
                    isAdded = true;
                    context.read<CartButtonCubit>().increaseQuantity(
                      widget.category,
                    );
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff3579DD)),
                    borderRadius: BorderRadius.circular(42),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: Color(0xff3579DD)),
                      SizedBox(width: 8),
                      Text(
                        "Add",
                        style: TextStyle(
                          color: Color(0xff3579DD),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
