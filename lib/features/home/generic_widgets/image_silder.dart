import 'package:carousel_slider/carousel_slider.dart';
import 'package:competition/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imageUrls;

  const ImageSlider({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150.h,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 1,
      ),
      items: imageUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return RPadding(
              padding: REdgeInsets.all(2.0),
              child: Container(
                width: 370.w,
                height: 130.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.primary,
                  image: DecorationImage(
                    image: AssetImage(url),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
