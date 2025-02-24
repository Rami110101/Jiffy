abstract class TextFieldStates {}

class InitialTextFieldState extends TextFieldStates {}

class ChangeVisibilityState extends TextFieldStates {
  final Map<String, bool> visibilityStates;

  ChangeVisibilityState(this.visibilityStates);
}

class ValidationState extends TextFieldStates {
  final String? nameError;
  final String? phoneError;
  final String? passwordError;
  final String? confirmPasswordError;

  ValidationState({
    this.nameError,
    this.phoneError,
    this.passwordError,
    this.confirmPasswordError,
  });
}
