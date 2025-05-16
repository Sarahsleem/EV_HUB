import 'package:evhub/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors.dart';
import '../../logic/nav_bar_cubit.dart';

class NavBarContainer extends StatelessWidget {
  const NavBarContainer({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Stack(
            children: [
              SizedBox(
                child: Container(
                  width: 248.w,
                  height: 72.h,
                  margin: EdgeInsets.symmetric(
                    horizontal: 68.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff254052),
                    borderRadius: BorderRadius.circular(33.9.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      width: 64.84.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (index) {
                          final isSelected =
                              NavBarCubit.get(context).selectedIndex ==
                              index;
                          return GestureDetector(
                            onTap: () {
                              pageController.jumpToPage(index);
                              NavBarCubit.get(context).changeIndex(index);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                  color: isSelected?Color(
                                  0xba212c33):Colors.transparent),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    isSelected
                                        ? NavBarCubit.get(
                                          context,
                                        ).navIconYellow[index]
                                        : NavBarCubit.get(context).navIcon[index],
                                    height: 24.h,
                                    width: 24.w,
                                  ),
                                  isSelected?Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
                                    child: Text(NavBarCubit.get(
                                      context,
                                    ).navTitle[index],style: TextStyles.inter14WhiteSemiBold,),
                                  ):SizedBox.shrink()
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    // child: Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: List.generate(
                    //     NavBarCubit.get(context).navIcon.length,
                    //     (index) {
                    //       final isSelected =
                    //           NavBarCubit.get(context).selectedIndex == index;
                    //       return GestureDetector(
                    //         onTap: () {
                    //           pageController.jumpToPage(index);
                    //           NavBarCubit.get(context).changeIndex(index);
                    //         },
                    //         child: Image.asset(
                    //           isSelected
                    //               ? NavBarCubit.get(context).navIconYellow[index]
                    //               : NavBarCubit.get(context).navIcon[index],
                    //           height: 25.h,
                    //           width: 25.w,
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
