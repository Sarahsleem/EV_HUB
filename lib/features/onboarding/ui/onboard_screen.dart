import 'package:evhub/core/assets/images.dart';
import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theming/styles.dart';

class OnBoardScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(

           crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(15),
            Image.asset(ImagesManager.splash,width: 100.w,height: 100.h,),
              verticalSpace(25),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: SizedBox(
                  width: 285.w,
                  //height: 89.h,
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(

                      children: [
                        TextSpan(

                          text: 'Seamless EV',
                          style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 44.sp),

                        ),
                        TextSpan(
                          text: ',services anytime.',
                          style: TextStyle(fontSize: 35.sp,color: ColorsManager.lightGrey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              verticalSpace(20),
              Image.asset(ImagesManager.logo)

            ],),
        ),
      ),);
  }

}