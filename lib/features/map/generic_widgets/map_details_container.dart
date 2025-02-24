import 'package:competition/core/generic_widgets/svg_icon.dart';
import 'package:competition/core/utils/colors.dart';
import 'package:competition/core/utils/strings.dart';
import 'package:competition/core/utils/text_styles.dart';
import 'package:competition/features/layout/screens/layout.dart';
import 'package:competition/features/map/core/cubit/get_loction/get_loction_cubit.dart';
import 'package:competition/features/ship/bloc/cubit_ship.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/assets.dart';

class MapDetailsContainer extends StatelessWidget {
  const MapDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetLoctionCubit, GetLoctionState>(
      builder: (context, state) {
        if (state is! GetLoctionSuccess) {
          return _buildErrorContainer(AppStrings.notFoundMessage.tr());
        }

        final getLoctionCubit = context.read<GetLoctionCubit>();
        final markers = getLoctionCubit.markers;

        if (markers.isEmpty) {
          return _buildErrorContainer(AppStrings.notFoundMessage.tr());
        }

        final senderMarkers = markers.where((m) {
          final markerIcon = m.child as Icon;
          final colorValue = (markerIcon.color as Color).value;

          return colorValue == Colors.red.value; // Use `.value` to compare
        }).toList();

        final recipientMarkers = markers.where((m) {
          final markerIcon = m.child as Icon;
          final colorValue = (markerIcon.color as Color).value;

          return colorValue == Colors.green.value;
        }).toList();

        if (senderMarkers.isEmpty || recipientMarkers.isEmpty) {
          return _buildErrorContainer(AppStrings.notFoundMessage.tr());
        }

        final senderPoint = senderMarkers.first.point;
        final recipientPoint = recipientMarkers.first.point;

        final distance =
            getLoctionCubit.calculateDistance(senderPoint, recipientPoint);
        final duration = getLoctionCubit.formatDuration(distance);

        return _buildDetailsContainer(distance, duration, context);
      },
    );
  }

  Widget _buildErrorContainer(String message) {
    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Container(
        padding: REdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [
            BoxShadow(spreadRadius: 1, blurRadius: 1, color: AppColors.appBlack)
          ],
        ),
        child: Text(message,
            style: TextStyle(fontSize: 16.sp, color: AppColors.offWhite)),
      ),
    );
  }

  Widget _buildDetailsContainer(
      double distance, String duration, BuildContext context) {
    final shipCubit = context.read<ShipScreenCubit>();

    return Positioned(
      bottom: 60,
      left: 16,
      right: 16,
      child: Container(
        width: double.infinity, // Full width
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(19.r),
          boxShadow: const [
            BoxShadow(spreadRadius: 1, blurRadius: 1, color: AppColors.appBlack)
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, color: AppColors.offWhite, size: 25),
                5.horizontalSpace,
                Text(AppStrings.sender.tr(),
                    style: AppTextStyle.f18W600offWhite),
                Text(" -> ", style: AppTextStyle.f18W600offWhite),
                const Icon(Icons.person, color: AppColors.offWhite, size: 25),
                5.horizontalSpace,
                Text(AppStrings.recipient.tr(),
                    style: AppTextStyle.f18W600offWhite),
              ],
            ),
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.location_on, color: AppColors.appWhite),
                8.horizontalSpace,
                Text(
                  (distance / 1000).toStringAsFixed(1) + AppStrings.km.tr(),
                  style: AppTextStyle.f15W500offWhite,
                ),
                8.horizontalSpace,
                Text("|", style: AppTextStyle.f18W600offWhite),
                8.horizontalSpace,
                const Icon(Icons.timer, color: AppColors.appWhite),
                8.horizontalSpace,
                Text((distance / 2).toStringAsFixed(1),
                    style: AppTextStyle.f15W500offWhite),
                8.horizontalSpace,
                Text("|", style: AppTextStyle.f18W600offWhite),
                8.horizontalSpace,
                const SvgIcon(
                    assetPath: AppAssets.weightIcon, color: AppColors.appWhite),
                8.horizontalSpace,
                Text(
                    "${shipCubit.state.itemWeight}" +
                        ' ' +
                        AppStrings.gram.tr(),
                    style: AppTextStyle.f15W500offWhite),
              ],
            ),
            12.verticalSpace,
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LayoutScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.offWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 40.w),
                  shadowColor: AppColors.appBlack),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: AppColors.primary,
                        boxShadow: const [
                          BoxShadow(
                              color: AppColors.appBlack,
                              blurRadius: 1,
                              spreadRadius: 1)
                        ]),
                    child: const Icon(
                      size: 30,
                      Icons.home,
                      color: AppColors.offWhite,
                    ),
                  ),
                  8.horizontalSpace,
                  Text(
                    AppStrings.continueHome.tr(),
                    style: AppTextStyle.f16W600Primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
