import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/features/forget_password/logic/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets/images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/font_weight.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_otp_text_field.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../widgets/verify_states_ui.dart';

class ForgetPasswordOTP extends StatefulWidget {
  final String email;
  const ForgetPasswordOTP({Key? key, required this.email}) : super(key: key);
  @override
  State<ForgetPasswordOTP> createState() => _ForgetPasswordOTPState();
}

class _ForgetPasswordOTPState extends State<ForgetPasswordOTP> {
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
      appBar: AppBar(
        backgroundColor: Color(0xffF8F8F8),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_sharp, color: Color(0xff333333)),
        ),
      ),
      backgroundColor: Color(0xffF8F8F8),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        children: [
          Image.asset(ImagesManager.checkEmail, width: 174.w, height: 174.h),
          verticalSpace(42),
          Text(
            'Check your mail',
            style: TextStyles.lato15SemiBoldBlack.copyWith(fontSize: 21.sp),
            textAlign: TextAlign.center,
          ),
          verticalSpace(21),
          Text(
            'We just sent an OTP to your registered email address',
            style: TextStyles.workSans15RegularBlack,
            textAlign: TextAlign.center,
          ),
          verticalSpace(31),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(otpControllers.length, (index) {
                return OtpInputField(
                  controller: otpControllers[index],
                  focusNode: focusNodes[index],
                  validator:
                      (value) => value == null || value.isEmpty ? "!" : null,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      ForgetPasswordCubit.get(
                        context,
                      ).focusPreviousField(context);
                    } else {
                      ForgetPasswordCubit.get(context).focusNextField(context);
                    }
                  },
                );
              }),
            ),
          ),
          verticalSpace(21),
          Center(
            child: Text('00:30', style: TextStyles.workSans15RegularBlack),
          ),
          verticalSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Didnt get a code?',
                style: TextStyles.workSans15RegularBlack,
              ),
              GestureDetector(
                child: Text(' Resend', style: TextStyles.workSans15RegularBlack.copyWith(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          verticalSpace(50),
          AppTextButton(
            buttonText: 'Verify OTP ',
            borderRadius: 106.r,
            backgroundColor: Color(0xff9dabb4),
            textStyle: TextStyles.inter16greyMedium.copyWith(
              color: Colors.white,
            ),
            onPressed: () {
              ForgetPasswordCubit.get(context).verifyCode(widget.email, otpControllers.map((e) => e.text).join().toString());
              //context.pushNamed(Routes.forgetPasswordReset);
            },
          ),
          verifyStateUi()
        ],
      ),
    );
  }
}
