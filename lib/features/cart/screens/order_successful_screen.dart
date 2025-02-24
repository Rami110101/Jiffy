import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/generic_widgets/custom_button.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/strings.dart';
import '../../../core/utils/text_styles.dart';
import '../../layout/screens/layout.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RPadding(
          padding: REdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.check_circle,
                  color: AppColors.primary, size: 200.0),
              20.verticalSpace,
              Text(
                AppStrings.orderSuccessful.tr(),
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              10.verticalSpace,
              Text(
                AppStrings.thankYouForPurchase.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              250.verticalSpace,
              CustomButton(
                label: AppStrings.confirm.tr(),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LayoutScreen(initialIndex: 2),
                    ),
                    (route) => false,
                  );
                },
                color: AppColors.primary,
                labelTextStyle: AppTextStyle.f15W500appWhite,
              ),
              40.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
