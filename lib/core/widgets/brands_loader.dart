import 'package:evhub/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../helpers/spacing.dart';
import 'image_network.dart';

class BrandLoader extends StatelessWidget {
  const BrandLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: 64.h,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return CircleAvatar(
              backgroundColor: ColorsManager.borderGrey,

              radius: 30.r,
            );
          },
          separatorBuilder: (context, index) {
            return horizontalSpace(4);
          },
          itemCount: 8,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: ScrollPhysics(),
        ),
      ),
    );
  }
}