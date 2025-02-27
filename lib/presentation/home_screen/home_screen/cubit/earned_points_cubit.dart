import 'package:flutter_bloc/flutter_bloc.dart';

class EarnedPointsCubit extends Cubit<int> {
  EarnedPointsCubit() : super(3222);

  void incrementPoints() {
    emit(state + 20);
  }
}
