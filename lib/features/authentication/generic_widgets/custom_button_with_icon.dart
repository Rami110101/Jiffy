import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final String label;
  final Color color;
  final TextStyle labelTextStyle;
  final String iconPath;
  final double buttonWidth;
  final double buttonHeight;
  final double? iconSize;
  final double? spacingWidth;

  CustomButtonWithIcon({
    Key? key,
    required this.label,
    required this.color,
    required this.labelTextStyle,
    required this.iconPath,
    this.buttonWidth = 325, // Default width
    this.buttonHeight = 52, // Default height
    this.iconSize, // Default icon size
    this.spacingWidth, // Default spacing width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: buttonWidth.w,
        height: buttonHeight.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 0),
              blurRadius: .1,
              spreadRadius: .1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 19),
              child: SvgPicture.asset(
                iconPath,
                width: iconSize,
                height: iconSize,
              ),
            ),
            SizedBox(
              width: spacingWidth,
            ),
            Text(
              label,
              style: labelTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
