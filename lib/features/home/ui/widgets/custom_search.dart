import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 16),
      decoration: BoxDecoration(
        color: Color(0x5ffffff),
        borderRadius: BorderRadius.circular(54.r),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.search,
                color: ColorsManager.borderGrey,
                size: 34.sp,
              ),
              Text(
                 S.of(context).Searchforanything,
                style: TextStyles.latoGrey16SemiBold,)
            ],
          ),
          Spacer(),
          Padding(
            padding:  EdgeInsets.all(6.0.w),
            child: CircleAvatar(
              radius: 22.5.r,
              backgroundColor: Color(0x5ffffff),
              child: Icon(
                size: 31.sp,
                Icons.filter_alt_outlined,
                color: ColorsManager.borderGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}