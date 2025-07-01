import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';

class AddRequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 7.w),
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
          ),
          Positioned(
            bottom: 30.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 8.h),
              height: 245.h,
              width: 380.w,
              decoration: BoxDecoration(
                color: Color(0xff4c5859),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  Container(
                    height: 6.h,
                    width: 42.w,
                    child: SizedBox(),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  verticalSpace(16),
                  AddContainer(
                    image: 'images/png/cellcar.png',
                    title: 'Sell your Car',
                    onTap: () => context.pushNamed(Routes.addNewChooseBrand),
                  ),
                  verticalSpace(6),
                  AddContainer(
                    onTap: () => context.pushNamed(Routes.chooseservice),
                    image: 'images/png/cellservice.png',
                    title: 'Add Your Service ',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddContainer extends StatelessWidget {
  const AddContainer({super.key, required this.image, required this.title, this.onTap});
  final String image;
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 7.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.r),
          color: Color(0x6122323b),
        ),
       // height: 95.h,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 17.h),
              decoration: BoxDecoration(
                color: Color(0x54212121),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Image.asset(image, height: 48.h, width: 48.w),
            ),
            horizontalSpace(12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.clip,
                  style: TextStyles.lato21SemiBoldDarkBlue.copyWith(
                    color: Colors.white,
                  ),
                ),
                verticalSpace(7),
                SizedBox(
                  width: 227.w,
                  child: Text(
                    'Car insurance covers your vehicle and damages in case of accidents or theft.',
                    overflow: TextOverflow.clip,
                    style: TextStyles.lato9SemiBoldWhite,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
