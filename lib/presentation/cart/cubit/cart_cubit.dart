import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:task2/presentation/cart/model/cart_model.dart';
import 'package:task2/presentation/home_screen/home_detail_screen/cubit/cart_buttons.dart';

class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super([]);

  void addToCart(CartItem item, BuildContext context) {
    List<CartItem> updatedCart = List.from(state);

    int index = updatedCart.indexWhere(
      (cartItem) => cartItem.name == item.name,
    );

    if (index != -1) {
      updatedCart[index] = updatedCart[index].copyWith(
        quantity: updatedCart[index].quantity + item.quantity,
      );
    } else {
      updatedCart.add(item);
    }

    emit(updatedCart);

    context.read<CartButtonCubit>().updateQuantity(item.name, item.quantity);
  }

  void removeFromCart(String itemName, BuildContext context) {
    List<CartItem> updatedCart = List.from(state);
    updatedCart.removeWhere((item) => item.name == itemName);
    emit(updatedCart);

    context.read<CartButtonCubit>().resetQuantity(itemName);
  }

  void updateQuantity(String itemName, int newQuantity, BuildContext context) {
    List<CartItem> updatedCart = List.from(state);
    int index = updatedCart.indexWhere((item) => item.name == itemName);

    if (index != -1) {
      if (newQuantity > 0) {
        updatedCart[index] = updatedCart[index].copyWith(quantity: newQuantity);
      } else {
        updatedCart.removeAt(index);
      }
    }

    emit(updatedCart);

    context.read<CartButtonCubit>().updateQuantity(itemName, newQuantity);
  }

  double getTotalPrice() {
    return state.fold(0, (total, item) => total + (item.price * item.quantity));
  }

  void clearCart(BuildContext context) {
    emit([]);

    context.read<CartButtonCubit>().clearCart();
  }
}
