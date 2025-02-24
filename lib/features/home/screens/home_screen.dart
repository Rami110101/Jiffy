import 'package:competition/core/generic_widgets/svg_icon.dart';
import 'package:competition/core/utils/text_styles.dart';
import 'package:competition/features/home/generic_widgets/image_silder.dart';
import 'package:competition/features/notifications/screens/notifications_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../core/utils/assets.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/strings.dart';
import '../../cart/screens/cart_screen.dart';
import '../../layout/screens/layout.dart';
import '../bloc/cubit/cubit_home.dart';
import '../bloc/states/state_home.dart';
import '../generic_widgets/custom_search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..fetchCategories(),
      child: Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                  child: SpinKitHourGlass(color: AppColors.primary));
            } else if (state is HomeFailure) {
              return Center(child: Text(state.error));
            } else if (state is HomeSuccess) {
              return _buildHomeContent(
                context,
                state.categories,
                state.recommended,
                state.mostRequested,
                state.sliderImagePaths,
              );
            } else {
              return const Center(child: Text(AppStrings.initializing));
            }
          },
        ),
      ),
    );
  }

  Widget _buildHomeContent(
    BuildContext context,
    List<Map<String, dynamic>> categories,
    List<String> recommended,
    List<String> mostRequested,
    List<String> sliderImagePaths,
  ) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 350.h,
          collapsedHeight: 125.h,
          pinned: true,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double currentHeight = constraints.maxHeight;
              final bool isExpanded = currentHeight > 160.h;

              return Stack(
                children: [
                  FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(29.r),
                          bottomRight: Radius.circular(29.r),
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SvgIcon(
                                              assetPath: AppAssets.cartIcon,
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CartScreen()));
                                              },
                                            ),
                                            SizedBox(width: 16.w),
                                            const SvgIcon(
                                                assetPath:
                                                    AppAssets.favouriteIcon),
                                            SizedBox(width: 16.w),
                                            SvgIcon(
                                              assetPath:
                                                  AppAssets.notificationICon,
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NotificationsScreen()));
                                              },
                                            ),
                                          ],
                                        ),
                                        if (isExpanded) ...[
                                          SizedBox(height: 64.h),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${AppStrings.lets.tr()}\n",
                                                  style: AppTextStyle
                                                      .f32W600appWhite,
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${AppStrings.jiffYour.tr()}\n",
                                                  style: AppTextStyle
                                                      .f32W600appWhite,
                                                ),
                                                TextSpan(
                                                  text: AppStrings.order.tr(),
                                                  style: AppTextStyle
                                                      .f32W600appWhite,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    if (isExpanded)
                                      Positioned(
                                        right: -10.w,
                                        top: -25.h,
                                        child: SizedBox(
                                          width: 300.w,
                                          height: 280.h,
                                          child: Image.asset(
                                            AppAssets.homeMainDroneImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              CustomSearchBar(
                                hintText: AppStrings.searchBar.tr(),
                                onSearch: (query) {
                                  // Handle search query
                                },
                                onScanPressed: () {
                                  // Handle scan icon press
                                },
                              ),
                              SizedBox(height: 8.h)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!isExpanded)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(29.r),
                            bottomRight: Radius.circular(29.r),
                          ),
                        ),
                        child: SafeArea(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgIcon(
                                      assetPath: AppAssets.cartIcon,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CartScreen()));
                                      },
                                    ),
                                    SizedBox(width: 16.w),
                                    const SvgIcon(
                                        assetPath: AppAssets.favouriteIcon),
                                    SizedBox(width: 16.w),
                                    SvgIcon(
                                      assetPath: AppAssets.notificationICon,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CartScreen()));
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18.h),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      top: -50.h,
                                      right: 50.w,
                                      child: Image.asset(
                                        AppAssets.homePackageImage,
                                        width: 100.w,
                                        height: 80.h,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.h),
                                      child: CustomSearchBar(
                                        hintText: AppStrings.searchBar.tr(),
                                        onSearch: (query) {
                                          // Handle search query
                                        },
                                        onScanPressed: () {
                                          // Handle scan icon press
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                24.verticalSpace
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Positioned Image
                    ),
                ],
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Column(
              children: [
                // Request Your Order Section
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SvgIcon(
                            assetPath: AppAssets.requestYourOrderIcon,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            AppStrings.requestYourOrder.tr(),
                            style: AppTextStyle.f16W500homeHeadLines,
                          ),
                        ],
                      ),
                      SizedBox(
                        child: InkWell(
                          child: Image.asset(
                            AppAssets.homeRequestOrder,
                            fit: BoxFit.fitWidth,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LayoutScreen(initialIndex: 1),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Categories Section
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            const SvgIcon(
                              assetPath: AppAssets.categoriesIcon,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              AppStrings.categories.tr(),
                              style: AppTextStyle.f16W500homeHeadLines,
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            AppStrings.seeAll.tr(),
                            style: AppTextStyle.f11W400seeAll,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 105.h,
                      child: ListView.separated(
                        padding: REdgeInsets.all(2),
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                width: 75.w,
                                height: 75.h,
                                decoration: BoxDecoration(
                                  color: AppColors.appWhite,
                                  // border: Border.all(
                                  //     color: AppColors.searchBarHint,
                                  //     width: .2.w),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.searchBarHint,
                                      blurRadius: 1.r,
                                      spreadRadius: .01.r,
                                      offset: Offset(0.1, 0.1),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Image.asset(
                                    categories[index]['image'],
                                    // fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                categories[index]['text'],
                                style: AppTextStyle.f9W500Categories,
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return 10.horizontalSpace;
                        },
                      ),
                    ),
                  ],
                ),

                // Image Slider
                Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            const SvgIcon(
                              assetPath: AppAssets.homeOfferIcon,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              AppStrings.ourOffers.tr(),
                              style: AppTextStyle.f16W500homeHeadLines,
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            AppStrings.seeAll.tr(),
                            style: AppTextStyle.f11W400seeAll,
                          ),
                        ),
                      ],
                    ),
                    ImageSlider(imageUrls: sliderImagePaths),
                  ],
                ),

                // Recommended List
                Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            const SvgIcon(
                              assetPath: AppAssets.homeRecommendedIcon,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              AppStrings.recommended.tr(),
                              style: AppTextStyle.f16W500homeHeadLines,
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            AppStrings.seeAll.tr(),
                            style: AppTextStyle.f11W400seeAll,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 130.h,
                      child: ListView.separated(
                        padding: REdgeInsets.all(2),
                        scrollDirection: Axis.horizontal,
                        itemCount: recommended.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.primary),
                            width: 155.w,
                            child: Image.asset(
                              recommended[index],
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return 8.horizontalSpace;
                        },
                      ),
                    ),
                  ],
                ),

                //Emergency Section
                Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            const SvgIcon(
                              assetPath: AppAssets.emergencyIcon,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              AppStrings.emergency.tr(),
                              style: AppTextStyle.f16W500homeHeadLines,
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            AppStrings.seeAll.tr(),
                            style: AppTextStyle.f11W400seeAll,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: Image.asset(
                        AppAssets.emergencyImage,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),

                // Most Requested Section
                Column(
                  children: [
                    Row(
                      children: [
                        const SvgIcon(
                          assetPath: AppAssets.mostRequestedIcon,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          AppStrings.mostRequested.tr(),
                          style: AppTextStyle.f16W500homeHeadLines,
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            AppStrings.seeAll.tr(),
                            style: AppTextStyle.f11W400seeAll,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 160.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        itemCount: mostRequested.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.primary),
                            width: 120.w,
                            child: Image.asset(
                              mostRequested[index],
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return 8.horizontalSpace;
                        },
                      ),
                    ),
                  ],
                ),

//Discount Section
                Column(
                  children: [
                    Row(
                      children: [
                        const SvgIcon(
                          assetPath: AppAssets.discountIcon,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          AppStrings.discount.tr(),
                          style: AppTextStyle.f16W500homeHeadLines,
                        ),
                      ],
                    ),
                    SizedBox(
                      child: Image.asset(
                        AppAssets.discountImage,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),

                100.verticalSpace,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
