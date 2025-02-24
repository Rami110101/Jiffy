import 'package:competition/core/generic_widgets/custom_button.dart';
import 'package:competition/features/cart/generic_widgets/dummy_data.dart';
import 'package:competition/features/cart/generic_widgets/product_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/strings.dart';
import '../../../core/utils/text_styles.dart';
import '../bloc/cubit/cubit_cart.dart';
import '../bloc/states/state_cart.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..updateTotals(DummyData.products),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(AppStrings.cart.tr(),
              style: const TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Tab bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(AppStrings.scheduledOrder.tr(),
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold)),
                  Text(AppStrings.normalOrder.tr(),
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 16.h),

              // Product list
              Expanded(
                child: ListView.builder(
                  itemCount: DummyData.products.length,
                  itemBuilder: (context, index) {
                    final product = DummyData.products[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0 ||
                            DummyData.products[index - 1].category !=
                                product.category)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0.h),
                            child: Text(product.category,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey)),
                          ),
                        ProductContainer(product: product),
                      ],
                    );
                  },
                ),
              ),

              // Totals
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return Column(children: [
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppStrings.subtotal.tr()),
                        Text('\$${state.totalPrice.toStringAsFixed(2)}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppStrings.shippingFees.tr()),
                        const Text('\$21.00'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppStrings.totalWeight.tr()),
                        Text('${state.totalWeight.toStringAsFixed(0)} g'),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppStrings.total.tr(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text('\$${(state.totalPrice + 21).toStringAsFixed(2)}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    CustomButton(
                        label: AppStrings.checkout.tr(),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutScreen(),
                            ),
                          );
                        },
                        color: AppColors.primary,
                        labelTextStyle: AppTextStyle.f15W500appWhite)
                  ]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
