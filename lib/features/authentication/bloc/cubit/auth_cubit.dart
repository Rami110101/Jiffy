import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/cash/user_cash_helper.dart';
import '../../screens/login_screen.dart';
import '../states/auth_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String phone, String password) async {
    emit(LoginLoading());
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    try {
      // Retrieve user data
      final user = await UserCashHelper.getUser();

      // Check if the user exists and credentials match
      if (user != null &&
          user['phone'] == phone &&
          user['password'] == password) {
        // Set login status to true
        await UserCashHelper.saveUser(
          name: user['name']!,
          phone: user['phone']!,
          password: user['password']!,
          email: user['email'],
          profilePicPath: user['profilePic'],
        );
        emit(LoginSuccess());
      } else {
        emit(LoginFailure('Invalid phone or password'));
      }
    } catch (e) {
      emit(LoginFailure('An error occurred. Please try again.'));
    }
  }

// Future<void> loginUser(
//     {required String phone, required String password}) async {
//   emit(LoginLoading());
//   await Future.delayed(Duration(seconds: 2)); // Simulate network delay
//
//   final user = await SharedPrefHelper.getUser();
//   if (user != null &&
//       user['phone'] == phone &&
//       user['password'] == password) {
//     emit(LoginSuccess());
//   } else {
//     emit(LoginFailure(AppStrings.invalidPhoneOrPassword.tr()));
//   }
// }
}

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser({
    required String name,
    required String phone,
    required String password,
  }) async {
    emit(RegisterLoading());
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    await UserCashHelper.saveUser(
      name: name,
      phone: phone,
      password: password,
    );
    emit(RegisterSuccess());
  }
}

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  Future<void> resetPassword(BuildContext context) async {
    emit(ResetPasswordLoading());
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    emit(ResetPasswordSuccess());

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  Future<void> logoutUser() async {
    emit(LogoutLoading());
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    // Clear login status
    await UserCashHelper.clearLoginStatus();

    emit(LogoutSuccess());
  }
}
