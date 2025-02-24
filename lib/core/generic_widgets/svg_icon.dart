import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;
  final VoidCallback? onPressed; // Add this for clickable icons

  const SvgIcon({
    Key? key,
    required this.assetPath,
    this.width,
    this.height,
    this.color,
    this.onPressed, // Add this for clickable icons
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Wrap the icon in a GestureDetector to make it clickable
    return onPressed != null
        ? GestureDetector(
            onTap: onPressed,
            child: SvgPicture.asset(
              assetPath,
              width: width,
              height: height,
              color: color,
            ),
          )
        : SvgPicture.asset(
            assetPath,
            width: width,
            height: height,
            color: color,
          );
  }
}
