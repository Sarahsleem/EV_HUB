import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';

class ServiceLoder extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Skeletonizer(
     enabled: true,
     child: SizedBox(
       height: 134.h,
       child: ListView.separated(
         padding: EdgeInsetsDirectional.only(
           start: 18.w,
           end: 18.w,
         ),
         itemBuilder: (context, index) {
           return Container(
             margin: EdgeInsets.symmetric(vertical: 10.h),
             padding: EdgeInsetsDirectional.only(
               start: 8.4.w,
               end: 8.4.w,
               top: 8.h,
               bottom: 12.h,
             ),
             decoration: BoxDecoration(
               color: Colors.white,
               // boxShadow: [
               //   BoxShadow(
               //     offset: Offset(0, 1.17),
               //     blurRadius: 8.98,
               //     color: Color(0x17000000),
               //     spreadRadius: 3.5,
               //   ),
               // ],
               borderRadius: BorderRadius.circular(13.5.r),
             ),
             height: 114.h,
             width: 106.w,
             child: Column(
               mainAxisAlignment:
               MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Container(
                   height: 38.h,
                   width: 40.w,
                     decoration: BoxDecoration(
                       color: Colors.grey[200],
                       shape: BoxShape.rectangle,
                       borderRadius: BorderRadius.circular(13.5.r),
                     )
                 ),

                 Container(
                   width: 15.w,
                   height: 5.h,
                   decoration: BoxDecoration(
                     color: Colors.grey[200],
                     borderRadius: BorderRadius.circular(4),
                   ),
                 ),
                 Container(
                   width: 22.w,
                   height: 8.h,
                   decoration: BoxDecoration(
                     color: Colors.grey[200],
                     borderRadius: BorderRadius.circular(4),
                   ),
                 ),
               ],
             ),
           );
         },
         separatorBuilder: (context, index) {
           return horizontalSpace(9);
         },
         itemCount:
         4,
         scrollDirection: Axis.horizontal,
         shrinkWrap: true,
         physics: ScrollPhysics(),
       ),
     ),
   );
  }

}