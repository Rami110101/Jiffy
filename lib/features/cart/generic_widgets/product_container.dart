import 'package:competition/core/generic_widgets/svg_icon.dart';
import 'package:competition/core/utils/assets.dart';
import 'package:competition/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/product_model.dart';

class ProductContainer extends StatelessWidget {
  final Product product;

  const ProductContainer({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      child: RPadding(
        padding: REdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(product.imageUrl, width: 50.w, height: 50.h),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(product.brand,
                      style: const TextStyle(color: AppColors.appGrey)),
                  Row(
                    children: [
                      Text('\$${product.price.toStringAsFixed(2)}'),
                      8.verticalSpace,
                      SvgIcon(
                        assetPath: AppAssets.weightIcon,
                        width: 13.w,
                        height: 13.h,
                      ),
                      4.verticalSpace,
                      Text('${product.weight} g',
                          style: const TextStyle(color: AppColors.appGrey)),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: AppColors.appGrey),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
