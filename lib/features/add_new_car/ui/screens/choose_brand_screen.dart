import 'dart:ui';

import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:evhub/features/add_new_car/logic/add_new_car_cubit.dart';
import 'package:evhub/features/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/image_network.dart';
import '../../../../generated/l10n.dart';

class ChooseBrand extends StatelessWidget {
  const ChooseBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewCarCubit, AddNewCarState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('images/png/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child:  Stack(
              children: [
                SafeArea(
                          child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 31.w),
                          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => context.pop(),
                        icon: Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                      SizedBox(width: 24.w),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: S.of(context).AddYour,
                          style: TextStyles.inter18WhiteMedium.copyWith(
                            fontSize: 28.4.sp,
                            color: Colors.white.withOpacity(0.42),
                          ),
                        ),
                        TextSpan(
                          text: S.of(context).NewCarDetails,
                          style: TextStyles.inter18WhiteMedium.copyWith(
                            fontSize: 28.4.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(33),
                  Text(
                    S.of(context).Choosecarmodel,
                    style: TextStyles.inter18WhiteMedium.copyWith(
                      fontSize: 16.4.sp,
                    ),
                  ),
                  verticalSpace(28),

                  /// 👇 This allows scrollable brand list
                  Expanded(
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return GridView.builder(
                          itemCount: HomeCubit.get(context).carBrands.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 22.h,
                            childAspectRatio: 0.68.sp,
                          ),
                          itemBuilder: (context, index) {
                            final brand = HomeCubit.get(context).carBrands[index];
                            final isSelected =
                                AddNewCarCubit.get(context).selectedBrandIndex == index;

                            return Opacity(
                              opacity: isSelected ? 1 : 0.31,
                              child: SizedBox(
                                height: 96.8.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () => AddNewCarCubit.get(context)
                                          .chooseBrand(index, brand.id),
                                      child: AppCachedNetworkImage(
                                        fit: BoxFit.scaleDown,
                                        radius: 39.5.r,
                                        image: brand.acf.brandLogo.url,
                                        height: 75.h,
                                       // width: 75.w,
                                      ),
                                    ),
                                    Text(
                                      brand.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.inter16greyMedium.copyWith(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),


                  // AppTextButton(
                  //   buttonText: 'next',
                  //   backgroundColor: Colors.white.withOpacity(0.12),
                  //   borderWidth: 310,
                  //   buttonHeight: 55.h,
                  //   borderRadius: 30.r,
                  //   textStyle: TextStyles.inter19BlackBold.copyWith(
                  //     color: Colors.white,
                  //   ),
                  //   onPressed: () {},
                  // ),
                  // verticalSpace(10),
                ],
                          ),
                        ),
                        ),
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    SizedBox(height: 20.h),
                    Center(
                      child: AppTextButton(
                        buttonText: S.of(context).next,
                        backgroundColor: ColorsManager.darkBlue.withOpacity(0.27),
                        buttonWidth: 310,
                        buttonHeight: 55.h,
                        borderRadius: 30.r,
                        textStyle: TextStyles.inter19BlackBold.copyWith(
                          color: Colors.white,
                        ),
                        onPressed: () {
                          context.pushNamed(Routes.addNewCarDtails);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ),
        );
      },
    );
  }
}
