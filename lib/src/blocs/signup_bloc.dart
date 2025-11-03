import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_week01/src/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final User user;

  SignUpSuccess(this.user);
}

class SignUpFailure extends SignUpState {
  final String? emailError;
  final String? passwordError;
  final String? generalError;

  SignUpFailure({this.emailError, this.passwordError, this.generalError});
}

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpCubit({required this.authRepository}) : super(SignUpInitial());

  Future<void> signUp({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
    String? username,
  }) async {
    // Validation
    if (!_isValidEmail(email)) {
      emit(
        SignUpFailure(
          emailError: "Email không hợp lệ",
          generalError: "Vui lòng nhập email hợp lệ",
        ),
      );
      return;
    }

    if (!_isValidPassword(password)) {
      emit(
        SignUpFailure(
          passwordError:
              "Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ hoa, chữ thường và số",
          generalError: "Mật khẩu không đủ mạnh",
        ),
      );
      return;
    }

    emit(SignUpLoading());

    try {
      final user = await authRepository.signUp(
        email: email,
        password: password,
      );

      if (user != null) {
        // Có thể cập nhật displayName nếu cần
        if (firstName != null || lastName != null) {
          await user.updateDisplayName('$firstName $lastName'.trim());
        }
        emit(SignUpSuccess(user));
      } else {
        emit(
          SignUpFailure(generalError: "Đăng ký thất bại. Vui lòng thử lại."),
        );
      }
    } catch (e) {
      emit(SignUpFailure(generalError: e.toString()));
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    // Kiểm tra mật khẩu: ít nhất 6 ký tự, có chữ hoa, chữ thường, và số
    return password.length >= 6 &&
        RegExp(r'(?=.*[a-z])').hasMatch(password) &&
        RegExp(r'(?=.*[A-Z])').hasMatch(password) &&
        RegExp(r'(?=.*\d)').hasMatch(password);
  }
}
