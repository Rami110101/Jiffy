import 'package:competition/core/utils/assets.dart';
import 'package:competition/core/utils/strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/colors.dart';
import '../generic_widgets/bottom_navigation_bar/bloc/cubit/bottom_navigation_cubit.dart';

class LayoutScreen extends StatefulWidget {
  final int initialIndex;

  LayoutScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<BottomNavigationCubit>()
        .changePageIndex(newPageIndex: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (BuildContext context, BottomNavigationState state) {
        List<BottomNavigationBarItem> navBarItems = [
          context.read<BottomNavigationCubit>().bottomNavBarCustomItem(
                title: AppStrings.home.tr(),
                icon: AppAssets.navBarHome,
                color: state.pageIndex == 0
                    ? AppColors.primary
                    : AppColors.appGrey,
              ),
          context.read<BottomNavigationCubit>().bottomNavBarCustomItem(
                title: AppStrings.ship.tr(),
                icon: AppAssets.navBarJiffy,
                color: state.pageIndex == 1
                    ? AppColors.primary
                    : AppColors.appGrey,
              ),
          context.read<BottomNavigationCubit>().bottomNavBarCustomItem(
                title: AppStrings.myOrder.tr(),
                icon: AppAssets.navBarOrder,
                color: state.pageIndex == 2
                    ? AppColors.primary
                    : AppColors.appGrey,
              ),
          context.read<BottomNavigationCubit>().bottomNavBarCustomItem(
                title: AppStrings.profile.tr(),
                icon: AppAssets.navBarProfile,
                color: state.pageIndex == 3
                    ? AppColors.primary
                    : AppColors.appGrey,
              ),
        ];

        return Scaffold(
          body: Stack(
            children: [
              context
                  .read<BottomNavigationCubit>()
                  .bottomNavBarScreens[state.pageIndex],
              if (state.isNavBarVisible)
                RPadding(
                  padding: REdgeInsets.all(18.0),
                  child: Align(
                    alignment: Alignment(0, 1),
                    child: Container(
                      height: 78.h,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.2),
                            offset: const Offset(0.1, 0.1),
                            blurRadius: 4.r,
                            spreadRadius: 1.r,
                          ),
                        ],
                      ),
                      child: BottomNavigationBar(
                        currentIndex: state.pageIndex,
                        onTap: (index) {
                          context
                              .read<BottomNavigationCubit>()
                              .changePageIndex(newPageIndex: index);
                        },
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: Colors.white,
                        items: navBarItems,
                        selectedItemColor: AppColors.primary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
