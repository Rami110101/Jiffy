import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../svg_icon.dart';
import 'bloc/cubit/text_form_field_cubit.dart';
import 'bloc/states/text_form_field_states.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Icon? leadingIcon;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final String? errorText;
  final String? fieldKey;
  final bool keepWhiteColorWhenFocus;

  const CustomTextField({
    Key? key,
    required this.title,
    this.isPassword = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.leadingIcon,
    this.prefixIconPath,
    this.suffixIconPath,
    this.errorText,
    this.fieldKey,
    this.keepWhiteColorWhenFocus = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldCubit, TextFieldStates>(
      builder: (context, state) {
        final cubit = context.read<TextFieldCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              focusNode: _focusNode,
              controller: widget.controller,
              obscureText: widget.isPassword &&
                  !cubit.isPasswordVisible(widget.fieldKey!),
              keyboardType: widget.keyboardType,
              style: TextStyle(fontSize: 18.sp, color: AppColors.appBlack),
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                filled: true,
                fillColor: widget.keepWhiteColorWhenFocus
                    ? AppColors.appWhite
                    : _isFocused
                        ? AppColors.primary.withOpacity(0.1)
                        : AppColors.appWhite,
                hintText: widget.title,
                hintStyle: AppTextStyle.f15W400hintText,
                prefixIcon: _buildPrefixIcon(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: AppColors.borderGrey,
                    width: 0.3.w,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: AppColors.borderGrey,
                    width: 0.3.w,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 2.w,
                  ),
                ),
                suffixIcon: _buildSuffixIcon(context, cubit),
                errorText: widget.errorText,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget? _buildPrefixIcon() {
    if (widget.prefixIconPath != null) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgIcon(
          assetPath: widget.prefixIconPath!,
          width: 18.w,
          height: 14.h,
        ),
      );
    } else if (widget.leadingIcon != null) {
      return widget.leadingIcon;
    }
    return null;
  }

  Widget? _buildSuffixIcon(BuildContext context, TextFieldCubit cubit) {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          cubit.isPasswordVisible(widget.fieldKey!)
              ? Icons.visibility_off
              : Icons.visibility,
          color: AppColors.primary,
        ),
        onPressed: () {
          cubit.togglePasswordVisibility(widget.fieldKey!);
        },
      );
    } else if (widget.suffixIconPath != null) {
      return IconButton(
        icon: SvgIcon(
          assetPath: widget.suffixIconPath!,
          width: 22.w,
          height: 22.h,
        ),
        onPressed: () {},
      );
    }
    return null;
  }
}
