import 'package:competition/core/utils/assets.dart';
import 'package:competition/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/generic_widgets/svg_icon.dart';
import '../../../core/utils/colors.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final Function(String) onSearch;
  final VoidCallback? onScanPressed;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.onSearch,
    this.onScanPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 359.w,
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          // Search Icon
          SvgIcon(
            assetPath: AppAssets.searchIcon,
            width: 26.w,
            height: 26.h,
            color: AppColors.searchBarHint,
          ),
          SizedBox(width: 8.w),
          // Text Field
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyle.f14W400searchBarHint,
                border: InputBorder.none,
              ),
              onChanged: onSearch,
            ),
          ),
          // Scan Icon
          SvgIcon(
            assetPath: AppAssets.scanIcon,
            // Replace with your scan icon path
            width: 26.w,
            height: 26.h,
            color: AppColors.searchBarHint,
            onPressed: onScanPressed,
          ),
        ],
      ),
    );
  }
}
