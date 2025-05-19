import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/theming/font_weight.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:evhub/features/new_cars/logic/new_cars_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/brands_loader.dart';
import '../../../../core/widgets/image_network.dart';
import '../../../home/logic/home_cubit.dart';

class NewCarScreen extends StatefulWidget {
  @override
  State<NewCarScreen> createState() => _NewCarScreenState();
}

class _NewCarScreenState extends State<NewCarScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    HomeCubit.get(context).getBrands().then((_) {
      NewCarsCubit.get(context).getNewCarsByBrand();
    });

    // HomeCubit.get(context).getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/png/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              CustomAppBar(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: CustomSearch(),
              ),
              verticalSpace(17),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 15.w),
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadingBrandsState) {
                      return Center(child: BrandLoader());
                    }
                    return SizedBox(
                      height: 64.h,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return AppCachedNetworkImage(
                            fit: BoxFit.contain,
                            radius: 30.r,
                            image:
                                HomeCubit.get(
                                  context,
                                ).carBrands[index].acf.brandLogo.url,
                            height: 64.h,
                            width: 64.w,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return horizontalSpace(4);
                        },
                        itemCount: HomeCubit.get(context).carBrands.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                      ),
                    );
                  },
                ),
              ),
              verticalSpace(17),
              ListView.separated(
                separatorBuilder: (context,index){
                  return verticalSpace(12);
                },
                padding: EdgeInsets.symmetric(horizontal: 27.w),
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 23.h),
                    decoration: BoxDecoration(
                      color: Color(0xff1C2F39),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Volkswagen',
                                  style: TextStyles.inter18WhiteMedium.copyWith(
                                    fontSize: 15.3.sp,
                                  ),
                                ),
                                Text(
                                  'Golf E',
                                  style: TextStyles.inter13greyRegular.copyWith(
                                    fontSize: 15.3.sp,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'starts From',
                                  style: TextStyles.inter13greyRegular,
                                ),
                                Text(
                                  '3,000,000 LE',
                                  style: TextStyles.inter13greyRegular.copyWith(
                                    fontSize: 15.3.sp,
                                    fontWeight: FontWeightHelper.medium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        verticalSpace(160),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width:225.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(59.r),
                                color: Color(0x2ed9d9d9),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text('Explore',textAlign: TextAlign.center,),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor:Color(0xff1B262C),
                              child: Icon(
                                CupertinoIcons.heart_fill,
                                color: Color(0xa8ffffff),
                                size: 20.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearch extends StatelessWidget {
  const CustomSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      prefexIcon: Icon(
        CupertinoIcons.search,
        color: ColorsManager.borderGrey,
        size: 34.sp,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0x5ffffff), width: 1.3),
        borderRadius: BorderRadius.circular(54.r),
      ),
      hintText: 'Search for anything',
      backgroundColor: Color(0x61435f72),
      hintStyle: TextStyles.latoGrey16SemiBold,
      borderRadius: 54.r,
      suffixIcon: Padding(
        padding: const EdgeInsets.all(6.0),
        child: CircleAvatar(
          radius: 22.5.r,
          backgroundColor: Colors.transparent,
          child: Icon(
            size: 31.sp,
            Icons.filter_alt_outlined,
            color: ColorsManager.borderGrey,
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_rounded, size: 16.sp),
        ),
        Center(
          child: Text(
            textAlign: TextAlign.center,
            'new cars',
            style: TextStyles.inter18WhiteMedium,
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}
