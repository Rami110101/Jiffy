import 'package:competition/core/generic_widgets/custom_button.dart';
import 'package:competition/core/generic_widgets/svg_icon.dart';
import 'package:competition/core/utils/assets.dart';
import 'package:competition/features/cart/generic_widgets/dummy_data.dart';
import 'package:competition/features/cart/screens/payment_method_and_shipping_address_screens.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/strings.dart';
import '../../../core/utils/text_styles.dart';
import '../bloc/cubit/cubit_cart.dart';
import '../bloc/states/state_cart.dart';
import '../generic_widgets/product_container.dart';
import 'order_successful_screen.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..updateTotals(DummyData.products),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(AppStrings.checkout.tr(),
              style: const TextStyle(color: Colors.black)),
          elevation: 0,
          centerTitle: true,
        ),
        body: RPadding(
          padding: REdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shipping Information
              Text(
                AppStrings.shippingInformation.tr(),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              ListTile(
                leading:
                    const Icon(Icons.location_on_outlined, color: Colors.grey),
                title: Text(
                  '${AppStrings.shippingAddress.tr()} ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                    'Assad Aldeen st. Rukn’ alden, Damascus, Syria 8823412'),
                trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShippingAddressScreen(),
                        ),
                      );
                    },
                    child: const SvgIcon(assetPath: AppAssets.profileEditIcon)),
              ),
              ListTile(
                leading: const Icon(Icons.credit_card, color: Colors.grey),
                title: Text(
                  '${AppStrings.paymentMethod.tr()} ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Code: 27262638787162'),
                trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentMethodScreen(),
                        ),
                      );
                    },
                    child: const SvgIcon(assetPath: AppAssets.profileEditIcon)),
              ),
              ListTile(
                leading: const Icon(Icons.airplanemode_active_outlined,
                    color: Colors.grey),
                title: Text(
                  AppStrings.shippingTypeEconomy.tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${AppStrings.estimatedArrival.tr()} '),
              ),

              SizedBox(height: 12.h),

              // Order List
              Text(
                AppStrings.orderList.tr(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
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
                  return Column(
                    children: [
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
                          Text(
                              '\$${(state.totalPrice + 21).toStringAsFixed(2)}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      CustomButton(
                          label: AppStrings.orderCapital.tr(),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OrderSuccessfulScreen()),
                            );
                          },
                          color: AppColors.primary,
                          labelTextStyle: AppTextStyle.f15W500appWhite)
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
