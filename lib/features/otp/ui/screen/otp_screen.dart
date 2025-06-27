import 'package:evhub/core/db/cash_helper.dart';
import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:evhub/features/otp/logic/otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets/images.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/app_otp_text_field.dart';
import '../../data/model/otp_model.dart';

class OTPScreen extends StatefulWidget {
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final formKey = GlobalKey<FormState>();

  List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset(
            ImagesManager.logo,
            width: double.infinity,
            height: 324.h,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.r),
                  topRight: Radius.circular(50.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3d72a850),
                    offset: Offset(0, -1),
                    spreadRadius: 4,
                    blurRadius: 44,
                  ),
                ],
              ),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(11),
                      Center(child: Container(height: 5.h,width:41.w,child: SizedBox(width: 41.w,height: 5.h),decoration: BoxDecoration(color: ColorsManager.kPrimaryColor,borderRadius: BorderRadius.circular(36.r),))),
                      verticalSpace(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.arrow_back_rounded, size: 26.sp, color: ColorsManager.gry),
                          Text('OTP', style: TextStyles.latoKprimary28Bold),
                          SizedBox(width: 20.w),
                        ],
                      ),
                      verticalSpace(20),
                      Text('Verification Code', style: TextStyles.inter19BlackBold),
                      verticalSpace(10),
                      Text(
                        'We have sent the verification code to your email address',
                        style: TextStyles.inter16greyMedium,
                      ),
                      verticalSpace(52),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(otpControllers.length, (index) {
                            return OtpInputField(
                              controller: otpControllers[index],
                              focusNode: focusNodes[index],
                              validator: (value) => value == null || value.isEmpty ? "!" : null,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  OtpCubit.get(context).focusPreviousField(context);
                                } else {
                                  OtpCubit.get(context).focusNextField(context);
                                }
                              },
                            );
                          }),
                        ),
                      ),
                      verticalSpace(40),
                      AppTextButton(
                        buttonText: "Confirm",
                        textStyle: TextStyles.latoWhite16Bold,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final email=  CashHelper.getString(key: Keys.email);
                            final otpValue = otpControllers.map((controller) => controller.text).join();
                           // CashHelper.putString(key: Keys.otpValue, value: otpValue);
                            OtpCubit.get(context).sendOTP(OTPModel(
                              email:email,
                              otp: otpValue,
                            ));
                          }
                          context.pushNamedAndRemoveUntil(Routes.navigationBar, predicate: (Route<dynamic> route) => false);
                        },
                        backgroundColor: ColorsManager.kPrimaryColor,
                        borderRadius: 44.r,
                      ),
                     // verticalSpace(20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
