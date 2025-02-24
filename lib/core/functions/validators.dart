import 'package:competition/core/utils/strings.dart';
import 'package:easy_localization/easy_localization.dart';

class Validators {
  static String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.thisFieldIsRequired.tr();
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailIsRequired.tr();
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return AppStrings.enterValidEmail.tr();
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordIsRequired.tr();
    }
    if (value.length < 8) {
      return AppStrings.passwordMinLength.tr();
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.phoneNumberIsRequired.tr();
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return AppStrings.phoneNumberLength.tr();
    }
    return null;
  }
}
