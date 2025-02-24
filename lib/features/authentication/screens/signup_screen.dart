import 'package:competition/core/utils/assets.dart';
import 'package:competition/features/authentication/screens/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../core/generic_widgets/custom_button.dart';
import '../../../core/generic_widgets/custom_text_form_field/bloc/cubit/text_form_field_cubit.dart';
import '../../../core/generic_widgets/custom_text_form_field/bloc/states/text_form_field_states.dart';
import '../../../core/generic_widgets/custom_text_form_field/custom_text_field.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/strings.dart';
import '../../../core/utils/text_styles.dart';
import '../bloc/cubit/auth_cubit.dart';
import '../bloc/states/auth_state.dart';
import '../generic_widgets/social.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusScopeNode _focusScopeNode = FocusScopeNode(); // Add FocusScopeNode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            _focusScopeNode.unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: FocusScope(
                node: _focusScopeNode,
                child: BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: Colors.green,
                            content:
                                Text(AppStrings.registrationSuccessfully.tr())),
                      );
                    } else if (state is RegisterFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  builder: (context, state) {
                    final textFieldCubit = context.read<TextFieldCubit>();

                    return BlocBuilder<TextFieldCubit, TextFieldStates>(
                      builder: (context, textFieldState) {
                        return Column(
                          children: [
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.arrow_back_ios),
                                ),
                                SizedBox(width: 64.w),
                                Text(
                                  AppStrings.letsSignUp.tr(),
                                  style: AppTextStyle.f18W600appBlack,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.createA.tr(),
                                      style: AppTextStyle.f24W600appBlack,
                                    ),
                                    Text(
                                      AppStrings.newAccount.tr(),
                                      style: AppTextStyle.f24W600appBlack,
                                    ),
                                  ],
                                ),
                                const Spacer(flex: 2),
                                Image.asset(
                                  AppAssets.blueAppIcon,
                                  height: 102.h,
                                  width: 75.w,
                                ),
                                const Spacer(),
                              ],
                            ),
                            SizedBox(height: 38.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  title: AppStrings.name.tr(),
                                  controller: nameController,
                                  leadingIcon: const Icon(
                                    Icons.person,
                                    color: AppColors.primary,
                                  ),
                                  errorText: textFieldCubit.nameError,
                                ),
                                SizedBox(height: 12.h),
                                CustomTextField(
                                  keyboardType: TextInputType.phone,
                                  title: AppStrings.yourPhoneNumber.tr(),
                                  controller: phoneController,
                                  prefixIconPath: AppAssets.phoneIcon,
                                  errorText: textFieldCubit.phoneError,
                                ),
                                SizedBox(height: 12.h),
                                CustomTextField(
                                  fieldKey: 'password',
                                  title: AppStrings.password.tr(),
                                  controller: passwordController,
                                  prefixIconPath: AppAssets.passwordIcon,
                                  isPassword: true,
                                  errorText: textFieldCubit.passwordError,
                                ),
                                SizedBox(height: 12.h),
                                CustomTextField(
                                  fieldKey: 'confirmPassword',
                                  title: AppStrings.confirmPassword.tr(),
                                  controller: confirmPasswordController,
                                  prefixIconPath: AppAssets.passwordIcon,
                                  isPassword: true,
                                  errorText:
                                      textFieldCubit.confirmPasswordError,
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            BlocBuilder<RegisterCubit, RegisterState>(
                              builder: (context, state) {
                                if (state is RegisterLoading) {
                                  return SpinKitHourGlass(
                                      color: AppColors.primary);
                                }
                                return CustomButton(
                                  labelTextStyle: AppTextStyle.f15W600white,
                                  color: AppColors.primary,
                                  label: state is RegisterLoading
                                      ? AppStrings.loading.tr()
                                      : AppStrings.create.tr(),
                                  onTap: () {
                                    // Validate fields
                                    textFieldCubit
                                        .validateName(nameController.text);
                                    textFieldCubit
                                        .validatePhone(phoneController.text);
                                    textFieldCubit.validatePassword(
                                        passwordController.text);
                                    textFieldCubit.validateConfirmPassword(
                                      confirmPasswordController.text,
                                      passwordController.text,
                                    );

                                    // Check if fields are valid
                                    if (textFieldCubit.nameError == null &&
                                        textFieldCubit.phoneError == null &&
                                        textFieldCubit.passwordError == null &&
                                        textFieldCubit.confirmPasswordError ==
                                            null) {
                                      // Proceed with registration
                                      context
                                          .read<RegisterCubit>()
                                          .registerUser(
                                            name: nameController.text.trim(),
                                            phone: phoneController.text.trim(),
                                            password:
                                                passwordController.text.trim(),
                                          );
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 11.h),
                            const SocialButton(),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
