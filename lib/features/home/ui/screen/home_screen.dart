import 'package:evhub/core/assets/images.dart';
import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:evhub/core/widgets/app_text_form_field.dart';
import 'package:evhub/features/home/logic/home_cubit.dart';
import 'package:evhub/features/home/ui/widgets/ADS_widget.dart';
import 'package:evhub/features/home/ui/widgets/Ads_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    HomeCubit.get(context).getAds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darkBlue,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 49.w,
                      height: 49.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        border: Border.all(
                          color: ColorsManager.borderGrey,
                          width: 2.w,
                        ),
                      ),
                      child: Center(child: Icon(Icons.location_on_rounded)),
                    ),
                    horizontalSpace(11),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Location',
                          style: TextStyles.latoWhite12Bold,
                        ),
                        Text(
                          'Sheikh Zayed City',
                          style: TextStyles.latoWhite16Bold,
                        ),
                      ],
                    ),
                  ],
                ),
                CircleAvatar(
                  child: Image.asset('images/png/pirson.png'),
                  radius: 25.r,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Battery Low?\nFind a Charger',
                  style: TextStyles.latoWhite16Bold,
                ),
                horizontalSpace(11),
                Image.asset(ImagesManager.charge, width: 40.w, height: 40.h),
              ],
            ),
          ),
          verticalSpace(8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: AppTextFormField(
              prefexIcon: Icon(
                CupertinoIcons.search,
                color: ColorsManager.borderGrey,
                size: 34.sp,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0x5ffffff),
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(54.r),
              ),
              hintText: 'Search for anything',
              backgroundColor: Color(0x5ffffff),
              hintStyle: TextStyles.latoGrey16SemiBold,
              borderRadius: 54.r,
              suffixIcon: Padding(
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
            ),
          ),
          verticalSpace(17),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 28.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.r),
                topRight: Radius.circular(50.r),
              ),
            ),
            child: Column(
              children: [
                verticalSpace(8),
                Center(
                  child: Container(
                    height: 6.h,
                    width: 41.w,
                    decoration: BoxDecoration(
                      color: ColorsManager.lighterGray,
                      borderRadius: BorderRadius.circular(36.r),
                    ),
                    child: SizedBox(width: 41.w, height: 5.h),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 10.h,
                  ),
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoadingADSState) {
                        return AdsLoader();
                      }
                      return AdsSlider(ads: HomeCubit.get(context).ads);
                    },
                  ),
                ),
                verticalSpace(6),
                SizedBox(
                  height: 56.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsetsDirectional.only(start: 6.w),
                        decoration: BoxDecoration(
                          color: ColorsManager.lightDarkBlue,
                          borderRadius: BorderRadius.circular(48.3.r),
                        ),
                        height: 56.h,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 27.r,
                              backgroundColor: Color(0x3dd9d9d9),
                              child: Image.asset(
                                HomeCubit.get(context).features[index].image,
                                height: 25.h,
                                width: 25.w,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            horizontalSpace(6),
                            Text(
                              HomeCubit.get(context).features[index].title,
                              style: TextStyles.inter12WhiteRegular,
                            ),
                            horizontalSpace(11),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return horizontalSpace(6);
                    },
                    itemCount: 3,
                  ),
                ),
                verticalSpace(16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Electric Cars',
                        style: TextStyles.lato15SemiBoldBlack,
                      ),
                      horizontalSpace(4),
                      GestureDetector(
                        child: Row(
                          children: [
                            Text(
                              'See all',
                              style: TextStyles.lato13RegularGrey,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: ColorsManager.gry,
                              size: 18.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(12),
                Container(
                  //padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19.r),
                    color: Color(0xffEFEFEF),
                  ),
                  height: 217.h,
                  width: 165.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       // verticalSpace(11),
                    Padding(
                      padding:  EdgeInsets.only(top: 11.0.h,left: 11.w,right: 11.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text('Tesla',style: TextStyles.lato17BoldDarkBlue,),
                          Text('4M',style: TextStyles.lato12MediumDarkBlue,),

                      ]),
                    ),
                        Image.asset('images/png/imageCar.png'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text('      Explore',style: TextStyles.lato12MediumDarkBlue,),
                            Container(padding:EdgeInsets.symmetric(vertical: 9.h,horizontal: 11.w),decoration:BoxDecoration(color: ColorsManager.darkBlue,borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r),bottomRight: Radius.circular(19.r))),child: Text('add to Fav',style: TextStyles.latoWhite12Bold,),)
                        ])

                  ]),
                ),
                verticalSpace(170)
                //Image.asset(ImagesManager.logo),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
