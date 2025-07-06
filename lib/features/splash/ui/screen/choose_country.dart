import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets/images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../generated/l10n.dart';

class ChooseCountry extends StatelessWidget {
  const ChooseCountry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                ImagesManager.splash,
                width: 100.w,
                height: 100.h,
              ),
            ),
            verticalSpace(20),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 18.w, bottom: 25.h),
              //height: 89.h,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Choose\n',
                      style: TextStyles.latoBold40Green,
                    ),
                    TextSpan(
                      text: 'Country',
                      style: TextStyles.latoBold40Green.copyWith(
                        color: Color(0xffA8A8A8),
                        fontSize: 62.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(child: Text(S.of(context).Soon,textAlign: TextAlign.center, style: TextStyles.lato17BoldDarkBlue.copyWith(color: Color(
                0x75000000)))),
            verticalSpace(20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 21.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'images/png/gorden.png',
                    width: 109.w,
                    height: 77.h,
                  ),
                  Image.asset('images/png/sar.png', width: 109.w, height: 77.h),
                  Image.asset('images/png/kuw.png', width: 109.w, height: 77.h),
                ],
              ),
            ),
            verticalSpace(99),
            Center(
              child: Image.asset(
                'images/png/egy.png',
                width: 109.w,
                height: 77.h,
              ),
            ),
            verticalSpace(100),
            Center(
              child: AppTextButton(
                buttonText: S.of(context).Start,
                textStyle: TextStyles.lato12MediumDarkBlue.copyWith(color: Colors.white,fontSize: 20.sp),
                onPressed: () {
                  context.pushNamed(Routes.onboardingScreen);
                },
                buttonWidth: 155,
                backgroundColor: Color(0xff72A850),
                buttonHeight: 42.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
