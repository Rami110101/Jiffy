import 'package:competition/core/generic_widgets/custom_button.dart';
import 'package:competition/core/utils/colors.dart';
import 'package:competition/core/utils/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/strings.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? _selectedPaymentMethod = AppStrings.mastercard.tr();

  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': AppStrings.mastercard.tr(), 'icon': Icons.credit_card},
    {'name': AppStrings.visa.tr(), 'icon': Icons.credit_card},
    {'name': AppStrings.chase.tr(), 'icon': Icons.credit_card},
    {'name': AppStrings.maestro.tr(), 'icon': Icons.credit_card},
    {'name': AppStrings.googlePlay.tr(), 'icon': Icons.credit_card},
    {'name': AppStrings.applePay.tr(), 'icon': Icons.credit_card},
    {'name': AppStrings.cashApp.tr(), 'icon': Icons.credit_card},
    {'name': AppStrings.venmo.tr(), 'icon': Icons.credit_card},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.paymentMethod.tr()),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: RPadding(
        padding: REdgeInsets.all(12.0),
        child: ListView(
          children: [
            ..._paymentMethods.map((method) => _buildRadioTile(
                  method['name'],
                  method['icon'],
                  _selectedPaymentMethod,
                  (value) => setState(() => _selectedPaymentMethod = value),
                )),
            200.verticalSpace,
            CustomButton(
              label: AppStrings.apply.tr(),
              onTap: () {
                Navigator.of(context).pop();
              },
              color: AppColors.primary,
              labelTextStyle: AppTextStyle.f15W500appWhite,
            ),
          ],
        ),
      ),
    );
  }
}

class ShippingAddressScreen extends StatefulWidget {
  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  String? _selectedAddress = AppStrings.home.tr();

  final List<Map<String, dynamic>> _addresses = [
    {
      'name': AppStrings.home.tr(),
      'details': 'Asrad Aldeen st. Rukn Aldeen, Damascus, Syria B82412',
      'icon': Icons.location_on
    },
    {
      'name': AppStrings.friendsHouse.tr(),
      'details': 'Asiad Aldeen st. Rukn Aldeen, Damascus, Syria B85221',
      'icon': Icons.location_on
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.shippingAddress.tr()),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: RPadding(
        padding: REdgeInsets.all(12.0),
        child: ListView(
          children: [
            ..._addresses.map((address) => _buildRadioTile(
                  address['name'],
                  address['icon'],
                  _selectedAddress,
                  (value) => setState(() => _selectedAddress = value),
                  subtitle: address['details'],
                )),
            20.verticalSpace,
            CustomButton(
              label: AppStrings.addShippingAddress.tr(),
              onTap: () {},
              color: AppColors.primary.withOpacity(.1),
              labelTextStyle: AppTextStyle.f15W500appWhite
                  .copyWith(color: AppColors.primary),
            ),
            400.verticalSpace,
            CustomButton(
              label: AppStrings.apply.tr(),
              onTap: () {
                Navigator.of(context).pop();
              },
              color: AppColors.primary,
              labelTextStyle: AppTextStyle.f15W500appWhite,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildRadioTile(
  String title,
  IconData icon,
  String? groupValue,
  Function(String?) onChanged, {
  String? subtitle,
}) {
  return ListTile(
    leading: Icon(icon, color: Colors.grey),
    title: Text(title),
    subtitle: subtitle != null ? Text(subtitle) : null,
    trailing: Radio<String>(
      value: title,
      groupValue: groupValue,
      onChanged: onChanged,
    ),
  );
}
