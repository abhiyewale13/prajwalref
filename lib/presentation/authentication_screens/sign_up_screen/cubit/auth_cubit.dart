import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  final String? email; 
  AuthState({this.email});
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(email: null));

  void setUserEmail(String? email) { 
    emit(AuthState(email: email ?? ""));
  }
}
