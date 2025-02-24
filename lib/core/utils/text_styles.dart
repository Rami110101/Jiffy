import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppTextStyle {
  //// Font Size 13
  static TextStyle f13W600skyBlue = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 13.sp, color: AppColors.skyBlue);

  //// Font Size 15
  static TextStyle f15W400hintText = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15.sp,
      color: AppColors.hintText.withOpacity(.68));

  static TextStyle f15W600white = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 15.sp, color: AppColors.appWhite);

  //// Font Size 16
  static TextStyle f16W400appBlack = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: AppColors.appBlack,
  );

  //// Font Size 18
  static TextStyle f18W600appBlack = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 18.sp, color: AppColors.appBlack);

  //// Font Size 24
  static TextStyle f24W600appBlack = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 24.sp, color: AppColors.appBlack);

  //// Font Size 32
  static TextStyle f32W600appBlack = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 32.sp, color: AppColors.appBlack);

  ///////////////////////////////////////////////////////// NEW
  static TextStyle f16W500homeHeadLines = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
    color: AppColors.homeHeadLines,
  );

  ////See All
  static TextStyle f11W400seeAll = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 11.sp,
    color: AppColors.seeAll,
  );

  ////Home_categories
  static TextStyle f9W500Categories = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 9.sp,
    color: AppColors.categories,
  );

  ////Let's jiffy your order
  static TextStyle f32W600appWhite = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 32.sp,
    color: AppColors.appWhite,
  );

  //text field
  static TextStyle f18W400appBlack = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 18.sp, color: AppColors.appBlack);

//OrderScreenHeadLines
  static TextStyle f25W500appWhite = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 25.sp,
    color: AppColors.appWhite,
  );

  //OrderScreenNextButton
  static TextStyle f16W600Primary = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    color: AppColors.primary,
  );

//Button Location
  static TextStyle f16W500BTNLocate = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
    color: AppColors.textButtonLocate,
  );

  //Jiffy Screen TextFieldName
  static TextStyle f15W400TextFieldName = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 15.sp, color: AppColors.appWhite);

  static TextStyle f15W500appWhite = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 15.sp, color: AppColors.appWhite);

  static TextStyle f14W400searchBarHint = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: AppColors.searchBarHint);
  static TextStyle f11W400appBlack = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 11.sp, color: AppColors.appBlack);

  //// Font Size 14
  static TextStyle f14W400appGrey = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 14.sp, color: AppColors.appGrey);

  static TextStyle f14W400onBoardSub = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    letterSpacing: 1.3,
    color: AppColors.onBoardSub,
  );
  static TextStyle f10W500offWhite = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 10.sp, color: AppColors.offWhite);

  static TextStyle f18W600offWhite = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 18.sp, color: AppColors.offWhite);

  static TextStyle f12W500offWhite = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppColors.offWhite);

  static TextStyle f15W500offWhite = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 15.sp, color: AppColors.offWhite);
}
