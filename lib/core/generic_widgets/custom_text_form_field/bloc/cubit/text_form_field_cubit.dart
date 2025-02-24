import 'package:competition/core/functions/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/text_form_field_states.dart';

class TextFieldCubit extends Cubit<TextFieldStates> {
  TextFieldCubit() : super(InitialTextFieldState());

  final Map<String, bool> _visibilityStates =
      {}; // Map to store visibility states
  String? nameError;
  String? phoneError;
  String? passwordError;
  String? confirmPasswordError;

  void togglePasswordVisibility(String fieldKey) {
    _visibilityStates[fieldKey] = !(_visibilityStates[fieldKey] ?? false);
    emit(ChangeVisibilityState(_visibilityStates));
  }

  bool isPasswordVisible(String fieldKey) {
    return _visibilityStates[fieldKey] ?? false;
  }

  void validateName(String value) {
    nameError = Validators.requiredValidator(value);
    emit(ValidationState(
      nameError: nameError,
      phoneError: phoneError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
    ));
  }

  void validatePhone(String value) {
    phoneError = Validators.phoneValidator(value);
    emit(ValidationState(
      nameError: nameError,
      phoneError: phoneError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
    ));
  }

  void validatePassword(String value) {
    passwordError = Validators.passwordValidator(value);
    emit(ValidationState(
      nameError: nameError,
      phoneError: phoneError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
    ));
  }

  void validateConfirmPassword(String value, String password) {
    if (value.isEmpty) {
      confirmPasswordError = 'Confirm password is required';
    } else if (value != password) {
      confirmPasswordError = 'Passwords do not match';
    } else {
      confirmPasswordError = null;
    }
    emit(ValidationState(
      nameError: nameError,
      phoneError: phoneError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
    ));
  }
}
