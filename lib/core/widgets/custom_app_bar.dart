import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/styles.dart';

class CustomAppBar extends StatelessWidget {
  final IconData barIcon;
  final String title;
  final VoidCallback onPressed;
  const CustomAppBar({super.key, required this.barIcon, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsetsDirectional.symmetric( vertical: 10.h),
      child: Row(
        children: [
            GestureDetector(onTap: onPressed, child:  Icon(barIcon, size: 25,)),
            Text(title, style: TextStyles.font18WhiteMedium,),
        ],
      ),
    );
  }
}