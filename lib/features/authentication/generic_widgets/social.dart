import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/assets.dart';
import '../../../core/utils/strings.dart';
import '../../../core/utils/text_styles.dart';
import 'custom_button_with_icon.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(),
            ),
            RPadding(
              padding: REdgeInsets.symmetric(horizontal: 6),
              child: Text(
                AppStrings.or.tr(),
                style: AppTextStyle.f13W600skyBlue.copyWith(
                  color: const Color(0xFF202244).withOpacity(.5),
                ),
              ),
            ),
            const Expanded(
              child: Divider(
                height: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: 11.h),
        CustomButtonWithIcon(
          label: AppStrings.signInWithGoogle.tr(),
          color: Colors.white,
          labelTextStyle: AppTextStyle.f16W400appBlack,
          iconPath: AppAssets.googleIcon,
          spacingWidth: 52.w,
          iconSize: 26,
        ),
        SizedBox(height: 14.h),
        CustomButtonWithIcon(
          label: AppStrings.signInWithApple.tr(),
          color: Colors.white,
          labelTextStyle: AppTextStyle.f16W400appBlack,
          iconPath: AppAssets.appleIcon,
          spacingWidth: 52.w,
          iconSize: 26,
        ),
      ],
    );
  }
}
