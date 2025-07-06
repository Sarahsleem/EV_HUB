import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/features/setting/data/model/reset_password_model.dart';
import 'package:evhub/features/setting/logic/setting_cubit.dart';
import 'package:evhub/features/setting/ui/widget/reset_password_status_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../generated/l10n.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool oldPasswordVisible = false;
  bool newPasswordVisible = false;
  bool confirmPasswordVisible = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Call API or perform logic
     SettingCubit.get(context).changeMyPassword(ResetPasswordModel(oldPassword: oldPasswordController.text, newPassword: newPasswordController.text));
    }
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darkBlue,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Column(
              children: [
                CustomAppBar(),
                verticalSpace(40),
                // Old password
                TextFormField(
                  controller: oldPasswordController,
                  obscureText: !oldPasswordVisible,
                  decoration: InputDecoration(
                    labelStyle: TextStyles.font14WhiteRegular, floatingLabelStyle: TextStyles.font14WhiteRegular,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsManager.kPrimaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: S.of(context).OldPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        oldPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          oldPasswordVisible = !oldPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? S.of(context).Pleaseenteryouroldpassword : null,
                ),
                SizedBox(height: 26.h),
            
                // New password
                TextFormField(
                  controller: newPasswordController,
                  obscureText: !newPasswordVisible,
                  decoration: InputDecoration(
                    labelStyle: TextStyles.font14WhiteRegular,
                    floatingLabelStyle: TextStyles.font14WhiteRegular,
                    labelText: S.of(context).NewPassword,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorsManager.kPrimaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        newPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          newPasswordVisible = !newPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? S.of(context).Pleaseenteranewpassword : null,
                ),
                SizedBox(height: 26.h),
            
                // Confirm new password
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: !confirmPasswordVisible,
                  decoration: InputDecoration(
labelStyle: TextStyles.font14WhiteRegular,
                    floatingLabelStyle: TextStyles.font14WhiteRegular,
                    labelText:S.of(context).ConfirmNewPassword,
                    focusedBorder: OutlineInputBorder(

                      borderSide: BorderSide(color: ColorsManager.kPrimaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          confirmPasswordVisible = !confirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return S.of(context).Pleaseconfirmyournewpassword;
                    if (value != newPasswordController.text) return S.of(context).Passwordsdonotmatch;
                    return null;
                  },
                ),
                SizedBox(height: 42.h),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(

                    backgroundColor: ColorsManager.kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _submit,
                  child: Text(S.of(context).ResetPassword, style: TextStyles.inter18WhiteMedium,),
                ),
                ResetPasswordStatusUi(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_rounded, size: 16.sp),
        ),
        Center(
          child: Text(
            textAlign: TextAlign.center,
            S.of(context).ResetPassword,
            style: TextStyles.inter18WhiteMedium,
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}