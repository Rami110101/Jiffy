part of '../cubit/bottom_navigation_cubit.dart';

class BottomNavigationState {
  final int pageIndex;
  final bool isNavBarVisible;

  BottomNavigationState({required this.pageIndex, this.isNavBarVisible = true});
}
