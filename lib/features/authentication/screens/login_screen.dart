import 'package:competition/core/generic_widgets/custom_button.dart';
import 'package:competition/features/authentication/screens/forget_password_screen.dart';
import 'package:competition/features/authentication/screens/signup_screen.dart';
import 'package:competition/features/layout/screens/layout.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../core/generic_widgets/custom_text_form_field/bloc/cubit/text_form_field_cubit.dart';
import '../../../core/generic_widgets/custom_text_form_field/bloc/states/text_form_field_states.dart';
import '../../../core/generic_widgets/custom_text_form_field/custom_text_field.dart';
import '../../../core/utils/assets.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/strings.dart';
import '../../../core/utils/text_styles.dart';
import '../bloc/cubit/auth_cubit.dart';
import '../bloc/states/auth_state.dart';
import '../generic_widgets/social.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  LoginScreen({super.key});

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
            child: RPadding(
              padding: REdgeInsets.symmetric(horizontal: 34.w),
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LayoutScreen(),
                      ),
                      (route) => false,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppStrings.welcomeBack.tr(),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is LoginFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.error,
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final textFieldCubit = context.read<TextFieldCubit>();

                  return BlocBuilder<TextFieldCubit, TextFieldStates>(
                    builder: (context, textFieldState) {
                      return FocusScope(
                        node: _focusScopeNode,
                        // Use FocusScopeNode for dismissing the keyboard
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),
                            Text(
                              textAlign: TextAlign.center,
                              AppStrings.letsLogin.tr(),
                              style: AppTextStyle.f18W600appBlack,
                            ),
                            SizedBox(height: 9.h),
                            Image.asset(
                              AppAssets.blueAppIcon,
                              height: 102.h,
                              width: 75.w,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              textAlign: TextAlign.center,
                              AppStrings.welcome.tr(),
                              style: AppTextStyle.f32W600appBlack,
                            ),
                            SizedBox(height: 29.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  keyboardType: TextInputType.phone,
                                  title: AppStrings.yourPhoneNumber.tr(),
                                  controller: phoneController,
                                  prefixIconPath: AppAssets.phoneIcon,
                                  errorText: textFieldCubit.phoneError,
                                ),
                                SizedBox(height: 20.h),
                                CustomTextField(
                                  fieldKey: 'firstPassword',
                                  title: AppStrings.password.tr(),
                                  controller: passwordController,
                                  prefixIconPath: AppAssets.passwordIcon,
                                  isPassword: true,
                                  errorText: textFieldCubit.passwordError,
                                ),
                                SizedBox(height: 4.h),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      AppStrings.forgotPassword.tr(),
                                      style: AppTextStyle.f13W600skyBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 69.h),
                            BlocBuilder<LoginCubit, LoginState>(
                              builder: (context, state) {
                                if (state is LoginLoading) {
                                  return SpinKitHourGlass(
                                      color: AppColors.primary);
                                }
                                return CustomButton(
                                  color: AppColors.primary,
                                  label: AppStrings.login.tr(),
                                  labelTextStyle: AppTextStyle.f15W600white,
                                  onTap: () {
                                    // Validate fields
                                    textFieldCubit
                                        .validatePhone(phoneController.text);
                                    textFieldCubit.validatePassword(
                                        passwordController.text);

                                    // Check if fields are valid
                                    if (textFieldCubit.phoneError == null &&
                                        textFieldCubit.passwordError == null) {
                                      // Proceed with login
                                      final phone = phoneController.text.trim();
                                      final password =
                                          passwordController.text.trim();
                                      context
                                          .read<LoginCubit>()
                                          .login(phone, password);
                                    }
                                  },
                                );
                              },
                            ),
                            // CustomButton(
                            //   color: AppColors.primary,
                            //   label: state is LoginLoading
                            //       ? AppStrings.loading.tr()
                            //       : AppStrings.login.tr(),
                            //   labelTextStyle: AppTextStyle.f15W600white,
                            // ),
                            SizedBox(height: 11.h),
                            SocialButton(),
                            SizedBox(height: 13.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(AppStrings.dontHaveAnAccount.tr()),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    AppStrings.signUp.tr(),
                                    style: AppTextStyle.f13W600skyBlue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
