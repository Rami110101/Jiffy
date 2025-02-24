import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color color;
  final TextStyle labelTextStyle;
  CustomButton({
    Key? key,
    required this.label,
    required this.onTap,
    required this.color,
    required this.labelTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            label,
            style: labelTextStyle,
          ),
        ),
      ),
    );
  }
}
