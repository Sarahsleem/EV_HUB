import 'package:evhub/core/assets/images.dart';
import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/core/theming/font_weight.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:evhub/core/widgets/app_text_form_field.dart';
import 'package:evhub/features/forget_password/logic/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';
import '../widgets/email_states_ui.dart';

class ForgetPasswordEmail extends StatefulWidget {
  @override
  State<ForgetPasswordEmail> createState() => _ForgetPasswordEmailState();
}

class _ForgetPasswordEmailState extends State<ForgetPasswordEmail> {
  TextEditingController controller =TextEditingController();
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
        children: [
          Image.asset(
            ImagesManager.forgetpasemail,
            width: 174.w,
            height: 174.h,
          ),
          verticalSpace(42),
          Text(
            'Forgot Password?',
            style: TextStyles.lato15SemiBoldBlack.copyWith(fontSize: 21.sp),
            textAlign: TextAlign.center,
          ),
          verticalSpace(21),
          Text(
            'Don’t worry, it happens to the best of us.',
            style: TextStyles.workSans15RegularBlack,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
            child: AppTextFormField(
              controller: controller,
              hintText: 'jollyburta@me.com',
              borderRadius: 32,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff333333)),
                borderRadius: BorderRadius.circular(32.r),
              ),
            ),
          ),
          verticalSpace(50),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.w),
            child: AppTextButton(
              buttonText: 'Continue ',
              borderRadius: 106.r,
              backgroundColor: Color(0xff9dabb4),
              textStyle: TextStyles.inter16greyMedium.copyWith(
                color: Colors.white,
              ),
              onPressed: () {
                ForgetPasswordCubit.get(context).sentEmail(controller.text);
              },
            ),
          ),
          SendEmailStateUi()
        ],
      ),
    );
  }
}
