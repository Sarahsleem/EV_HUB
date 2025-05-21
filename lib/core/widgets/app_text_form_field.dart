import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';
import '../theming/styles.dart';
import '../theming/theming_change/cubit/theme_cubit.dart';


class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final double? borderRadius;
  final Widget? prefexIcon;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    this.validator,
    this.onTap,
    this.onFieldSubmitted,
    this.readOnly,
    this.borderRadius,
    this.prefexIcon, this.focusNode, this.inputFormatters, this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onTap: onTap,
      readOnly: readOnly ?? false,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
fillColor: backgroundColor??Colors.transparent,
        filled: backgroundColor != null ? true : false,
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.only(left: 10.w, right: 10.w, bottom: 25.h,),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.kPrimaryColor,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(borderRadius?.r ?? 16.0.r),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.lighterGray,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(borderRadius?.r ?? 16.0.r),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(borderRadius?.r ?? 16.0.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(borderRadius?.r ?? 16.0.r),
        ),
        hintStyle: hintStyle ?? TextStyles.lato15RegularLightgray,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefexIcon,
      //  fillColor: backgroundColor ?? ColorsManager.moreLightGray,
     //   filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: TextStyles.lato15RegularLightgray,
      validator: validator ??
              (value) {
            if (value == null || value.isEmpty) {
              return "Must not be empty";
            }
            return null;
          },
    );
  }
}