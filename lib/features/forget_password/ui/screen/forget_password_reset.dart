import 'package:evhub/core/assets/images.dart';
import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:evhub/core/theming/font_weight.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:evhub/core/widgets/app_text_form_field.dart';
import 'package:evhub/features/forget_password/logic/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';
import '../widgets/reset_states_ui.dart';
class ForgetPasswordReset extends StatefulWidget {
  final String email;

  const ForgetPasswordReset({super.key, required this.email});

  @override
  State<ForgetPasswordReset> createState() => _ForgetPasswordResetState();
}

class _ForgetPasswordResetState extends State<ForgetPasswordReset> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF8F8F8),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_sharp, color: Color(0xff333333)),
        ),
      ),
      backgroundColor: const Color(0xffF8F8F8),
      body: ListView(
        children: [
          Image.asset(
            ImagesManager.forgetpasReset,
            width: 174.w,
            height: 174.h,
          ),
          verticalSpace(42),
          Text(
            'Reset your password',
            style: TextStyles.lato15SemiBoldBlack.copyWith(fontSize: 21.sp),
            textAlign: TextAlign.center,
          ),
          verticalSpace(21),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(
              'Here’s a tip: Use a combination of Numbers, Uppercase, lowercase and Special characters.',
              style: TextStyles.workSans15RegularBlack,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextFormField(
                    controller: passwordController,
                    hintText: 'New password',
                    borderRadius: 32,
                    isObscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: ColorsManager.darkBlack,
                        size: 19.sp,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
                      if (!passwordRegex.hasMatch(value)) {
                        return 'Password must contain uppercase, lowercase, number, and special char';
                      }
                      return null;
                    },
                  ),
                  verticalSpace(20),
                  AppTextFormField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm password',
                    borderRadius: 32,
                    isObscureText: _obscureConfirmPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        color: ColorsManager.darkBlack,
                        size: 19.sp,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          verticalSpace(50),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: AppTextButton(
              buttonText: 'Reset Password',
              borderRadius: 106.r,
              backgroundColor: const Color(0xff9dabb4),
              textStyle: TextStyles.inter16greyMedium.copyWith(
                color: Colors.white,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ForgetPasswordCubit.get(context).changePassword(
                    widget.email,
                    passwordController.text,
                  );
                }
              },
            ),
          ),
          const ResetPasswordStateUi(),
        ],
      ),
    );
  }
}
