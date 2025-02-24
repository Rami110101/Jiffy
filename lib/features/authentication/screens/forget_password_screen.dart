import 'package:competition/core/generic_widgets/custom_button.dart';
import 'package:competition/core/generic_widgets/custom_text_form_field/custom_text_field.dart';
import 'package:competition/core/utils/strings.dart';
import 'package:competition/features/authentication/generic_widgets/pin_code_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../core/generic_widgets/custom_text_form_field/bloc/cubit/text_form_field_cubit.dart';
import '../../../core/generic_widgets/custom_text_form_field/bloc/states/text_form_field_states.dart';
import '../../../core/utils/assets.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/text_styles.dart';
import '../bloc/cubit/auth_cubit.dart';
import '../bloc/states/auth_state.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final FocusScopeNode _focusScopeNode = FocusScopeNode(); // Add FocusScopeNode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _focusScopeNode.unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: BlocBuilder<TextFieldCubit, TextFieldStates>(
            builder: (context, state) {
              final textFieldCubit = context.read<TextFieldCubit>();

              return FocusScope(
                node: _focusScopeNode, // Use FocusScopeNode
                child: SizedBox(
                  height: 852.h,
                  child: ListView(children: [
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        SizedBox(width: 48.w),
                        Text(
                          AppStrings.forgotPassword.tr(),
                          style: AppTextStyle.f18W600appBlack,
                        ),
                      ],
                    ),
                    SizedBox(height: 34.h),
                    Column(children: [
                      Text(
                        AppStrings.weNeedYourRegistrationEct.tr(),
                        style: AppTextStyle.f16W400appBlack,
                      ),
                      SizedBox(height: 34.h),
                      CustomTextField(
                        keyboardType: TextInputType.phone,
                        title: AppStrings.yourPhoneNumber.tr(),
                        controller: phoneController,
                        prefixIconPath: AppAssets.phoneIcon,
                        errorText: textFieldCubit.phoneError,
                      ),
                      SizedBox(height: 20.h),
                      CustomButton(
                          labelTextStyle: AppTextStyle.f15W600white,
                          color: AppColors.primary,
                          label: AppStrings.sendCode.tr(),
                          onTap: () {
                            // Validate phone
                            textFieldCubit.validatePhone(phoneController.text);

                            if (textFieldCubit.phoneError == null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VerificationScreen(),
                                ),
                              );
                            }
                          }),
                    ]),
                  ]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class VerificationScreen extends StatelessWidget {
  final FocusScopeNode _focusScopeNode = FocusScopeNode(); // Add FocusScopeNode

  VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              // Dismiss the keyboard when tapping outside the text fields
              _focusScopeNode.unfocus();
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FocusScope(
                node: _focusScopeNode, // Use FocusScopeNode
                child: ListView(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        SizedBox(
                          width: 48.w,
                        ),
                        Text(
                          AppStrings.verificationCode.tr(),
                          style: AppTextStyle.f18W600appBlack,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                    Text(
                      AppStrings.enterTheCodeWeSentYou.tr(),
                      style: AppTextStyle.f16W400appBlack,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 92.h,
                    ),
                    PinCodeField(),
                    SizedBox(
                      height: 18.h,
                    ),
                    SizedBox(
                      height: 94.h,
                    ),
                    CustomButton(
                        label: AppStrings.enterCode.tr(),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EnterNewPasswordScreen(),
                            ),
                          );
                        },
                        color: AppColors.primary,
                        labelTextStyle: AppTextStyle.f15W600white),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      AppStrings.resendCode.tr(),
                      style: AppTextStyle.f13W600skyBlue.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}

class EnterNewPasswordScreen extends StatelessWidget {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusScopeNode _focusScopeNode = FocusScopeNode(); // Add FocusScopeNode

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => TextFieldCubit()),
          BlocProvider(create: (_) => ResetPasswordCubit()),
        ],
        child: Scaffold(
            body: GestureDetector(
          onTap: () {
            // Dismiss the keyboard when tapping outside the text fields
            _focusScopeNode.unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: FocusScope(
              node: _focusScopeNode, // Use FocusScopeNode
              child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
                listener: (context, state) {
                  if (state is ResetPasswordSuccess) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppStrings.passwordResetSuccess.tr()),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: BlocBuilder<TextFieldCubit, TextFieldStates>(
                  builder: (context, textFieldState) {
                    final textFieldCubit = context.read<TextFieldCubit>();

                    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                      builder: (context, resetPasswordState) {
                        return ListView(
                          children: [
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.arrow_back_ios),
                                ),
                                SizedBox(width: 34.w),
                                Text(
                                  AppStrings.resetPassword.tr(),
                                  style: AppTextStyle.f18W600appBlack,
                                ),
                              ],
                            ),
                            SizedBox(height: 90.h),
                            Text(
                              AppStrings.enterNewPassword.tr(),
                              style: AppTextStyle.f18W600appBlack.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 26.h),
                            CustomTextField(
                              fieldKey: 'newPassword',
                              prefixIconPath: AppAssets.passwordIcon,
                              title: AppStrings.password.tr(),
                              isPassword: true,
                              controller: newPasswordController,
                              errorText: textFieldCubit.passwordError,
                            ),
                            SizedBox(height: 12.h),
                            CustomTextField(
                              fieldKey: 'confirmNewPassword',
                              prefixIconPath: AppAssets.passwordIcon,
                              title: AppStrings.confirmPassword.tr(),
                              isPassword: true,
                              controller: confirmPasswordController,
                              errorText: textFieldCubit.confirmPasswordError,
                            ),
                            SizedBox(height: 35.h),
                            BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                              builder: (context, state) {
                                if (state is ResetPasswordLoading) {
                                  return const SpinKitHourGlass(
                                      color: AppColors.primary);
                                }
                                return CustomButton(
                                  color: AppColors.primary,
                                  label: AppStrings.confirm.tr(),
                                  labelTextStyle: AppTextStyle.f15W600white,
                                  onTap: () {
                                    // Validate fields
                                    textFieldCubit.validatePassword(
                                        newPasswordController.text);
                                    textFieldCubit.validateConfirmPassword(
                                      confirmPasswordController.text,
                                      newPasswordController.text,
                                    );

                                    // Check if fields are valid
                                    if (textFieldCubit.passwordError == null &&
                                        textFieldCubit.confirmPasswordError ==
                                            null) {
                                      // Trigger reset password
                                      context
                                          .read<ResetPasswordCubit>()
                                          .resetPassword(context);
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        )));
  }
}
