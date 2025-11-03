import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_week01/src/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  final String? emailError;
  final String? passwordError;
  // thông báo lỗi chung
  final String? generalError;

  LoginFailure({this.emailError, this.passwordError, this.generalError});
}

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit({required this.authRepository}) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    // Validation cơ bản trước khi gọi Firebase
    if (!_isValidEmail(email)) {
      emit(
        LoginFailure(
          emailError: "Email không hợp lệ",
          generalError: "Vui lòng nhập email hợp lệ",
        ),
      );
      return;
    }

    if (!_isValidPassword(password)) {
      emit(
        LoginFailure(
          passwordError: "Mật khẩu phải có ít nhất 6 ký tự",
          generalError: "Mật khẩu không hợp lệ",
        ),
      );
      return;
    }

    emit(LoginLoading());

    try {
      final user = await authRepository.signIn(
        email: email,
        password: password,
      );

      if (user != null) {
        emit(LoginSuccess(user));
      } else {
        emit(
          LoginFailure(generalError: "Đăng nhập thất bại. Vui lòng thử lại."),
        );
      }
    } catch (e) {
      emit(LoginFailure(generalError: e.toString()));
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }
}
