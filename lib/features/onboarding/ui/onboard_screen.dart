import 'package:evhub/core/assets/images.dart';
import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/styles.dart';

class OnBoardScreen extends StatelessWidget{
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ListView(
shrinkWrap: true,
           physics: ScrollPhysics(),
           // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(15),
            Image.asset(ImagesManager.splash,width: 100.w,height: 100.h,),
              verticalSpace(20),
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
                          style: TextStyle(color: Color(0xff71a750),fontWeight: FontWeight.bold,fontSize: 62.sp),

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

              Image.asset(ImagesManager.logo),
              SwipeButton.expand(
                height: 72.h,
                activeTrackColor: Color(0xff101a21),
                activeThumbColor: Colors.white,
                thumbPadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                thumb: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                  child: Image.asset(ImagesManager.swipe,width: 23.w,height: 23.h,fit: BoxFit.scaleDown,),
                ),
                // thumb: Icon(
                //   Icons.car_repair,
                //   color: Color(0xff71a750),
                // ),
                elevationThumb: 2,
                elevationTrack: 1,
                child: Text(
                  "Swipe to Explore",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onSwipe: () {
                  //context.pushReplacementNamed(Routes.verifyCode);
                  context.pushReplacementNamed(Routes.signInScreen);

                },
              )
            ],),
        ),
      ),);
  }

}