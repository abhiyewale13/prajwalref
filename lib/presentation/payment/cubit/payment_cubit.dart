import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<String?> {
  PaymentCubit() : super(null);

  void selectPaymentMethod(String method) {
    emit(method);
  }
}
