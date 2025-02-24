import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/generic_widgets/svg_icon.dart';
import '../../../../../home/screens/home_screen.dart';
import '../../../../../my_order/screens/my_order_screen.dart';
import '../../../../../profile/screens/profile_screen.dart';
import '../../../../../ship/ship_screen.dart';

part '../states/bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationState(pageIndex: 0));

  List<Widget> bottomNavBarScreens = [
    const HomeScreen(),
    const ShipScreen(),
    MyOrderScreen(),
    ProfileScreen(),
  ];

  BottomNavigationBarItem bottomNavBarCustomItem({
    required String title,
    String? icon,
    Color? color,
    double? iconWidth,
  }) {
    return BottomNavigationBarItem(
        tooltip: title,
        label: title,
        icon: SvgIcon(
          assetPath: icon!,
          width: 24.w,
          height: 24.h,
          color: color,
        ));
  }

  void changePageIndex(
      {required int newPageIndex, bool isNavBarVisible = true}) {
    emit(
      BottomNavigationState(
          pageIndex: newPageIndex, isNavBarVisible: isNavBarVisible),
    );
  }
}
