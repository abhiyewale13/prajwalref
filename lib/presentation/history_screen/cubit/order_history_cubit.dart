import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/presentation/cart/model/cart_model.dart';

class OrderHistoryCubit extends Cubit<List<CartItem>> {
  OrderHistoryCubit() : super([]);

  void addOrder(List<CartItem> items) {
    emit([...state, ...items]);
  }
}
