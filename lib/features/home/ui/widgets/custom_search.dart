import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16),
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
                ' Search for anything ',
                style: TextStyles.latoGrey16SemiBold,)
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(6.0),
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