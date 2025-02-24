import 'package:competition/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeField extends StatefulWidget {
  PinCodeField({super.key});

  @override
  State<PinCodeField> createState() => _PinCodeFieldState();
}

class _PinCodeFieldState extends State<PinCodeField> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      keyboardType: TextInputType.number,
      length: 4,
      obscureText: false,
      animationType: AnimationType.fade,
      mainAxisAlignment: MainAxisAlignment.center,
      pinTheme: PinTheme(
          inactiveColor: Colors.black12,
          selectedColor: AppColors.primary,
          activeColor: AppColors.primary,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(12),
          fieldHeight: 48.h,
          fieldWidth: 48.w,
          activeFillColor: Colors.white,
          fieldOuterPadding: EdgeInsets.symmetric(horizontal: 16)),
      animationDuration: Duration(milliseconds: 300),
      controller: controller,
      appContext: context,
    );
  }
}
