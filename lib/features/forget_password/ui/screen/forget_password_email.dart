import 'package:evhub/core/assets/images.dart';
import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/theming/font_weight.dart';
import 'package:evhub/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';

class ForgetPasswordEmail extends StatelessWidget {
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
            style: TextStyles.lato15SemiBoldBlack.copyWith(
              fontWeight: FontWeightHelper.regular,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 21.h),
            child: AppTextFormField(hintText: 'jollyburta@me.com',borderRadius: 32,enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff333333,),),borderRadius: BorderRadius.circular(32.r)),),
          )
        ],
      ),
    );
  }
}
