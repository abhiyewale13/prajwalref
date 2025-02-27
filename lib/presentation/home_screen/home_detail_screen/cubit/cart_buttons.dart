import 'package:flutter_bloc/flutter_bloc.dart';

class CartButtonCubit extends Cubit<Map<String, int>> {
  CartButtonCubit() : super({});

  void increaseQuantity(String itemName) {
    var newState = Map<String, int>.from(state);
    newState[itemName] = (newState[itemName] ?? 0) + 1;
    emit(newState);
  }

  void decreaseQuantity(String itemName) {
    var newState = Map<String, int>.from(state);
    if ((newState[itemName] ?? 0) > 0) {
      newState[itemName] = newState[itemName]! - 1;
      emit(newState);
    }
  }

  void updateQuantity(String itemName, int quantity) {
    var newState = Map<String, int>.from(state);
    newState[itemName] = quantity;
    emit(newState);
  }

  void resetQuantity(String itemName) {
    var newState = Map<String, int>.from(state);
    newState[itemName] = 0;
    emit(newState);
  }

  void clearCart() {
    emit({});
  }
}
