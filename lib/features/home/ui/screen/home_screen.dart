import 'package:evhub/core/assets/images.dart';
import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:evhub/core/widgets/app_text_form_field.dart';
import 'package:evhub/core/widgets/image_network.dart';
import 'package:evhub/features/home/logic/home_cubit.dart';
import 'package:evhub/features/home/ui/widgets/ADS_widget.dart';
import 'package:evhub/features/home/ui/widgets/Ads_loader.dart';
import 'package:evhub/features/services/logic/services_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../core/widgets/brands_loader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        HomeCubit.get(context).loadHomeData();
        ServicesCubit.get(context).getServices();

      },
      child: Scaffold(
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
                    style: TextStyles.latoWhite12Bold.copyWith(fontSize: 34.sp),
                  ),
                  horizontalSpace(11),
                  Image.asset(ImagesManager.charge, width: 40.w, height: 40.h),
                ],
              ),
            ),
            verticalSpace(8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: CustomSearch(),
            ),
            verticalSpace(17),
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 28.w),
              decoration: BoxDecoration(
                color: Color(0xffFFFCFB),
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
                        if (state is HomeLoadingADS1State) {
                          return AdsLoader();
                        } else if (HomeCubit.get(context).ads1.isNotEmpty) {
                          return AdsSlider(ads: HomeCubit.get(context).ads1);
                        }
                        return Container();
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
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoadingCarsState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (HomeCubit.get(context).cars.isNotEmpty) {
                        var cars = HomeCubit.get(context).cars;
                        return SizedBox(
                          height: 217.h,
                          child: ListView.builder(
                            // separatorBuilder: (context, index) => horizontalSpace(5.w),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: cars.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(19.r),
                                  color: Color(0xffEFEFEF),
                                ),
                                height: 217.h,
                                width: 165.w,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // verticalSpace(11),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 11.0.h,
                                        left: 11.w,
                                        right: 11.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 80.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cars[index].title!,
                                                  style: TextStyles
                                                      .lato17BoldDarkBlue
                                                      .copyWith(fontSize: 14.sp),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  cars[index]
                                                      .carBrand?[0]["name"],
                                                  style:
                                                      TextStyles.latogrey12Medium,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            NumberFormat("#,###").format(
                                              double.tryParse(
                                                    cars[index].acf!["price"]
                                                        .toString(),
                                                  ) ??
                                                  'N/A',
                                            ),
                                            style:
                                                TextStyles.lato12MediumDarkBlue,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    AppCachedNetworkImage(
                                      image: cars[index].featuredImage,
                                      height: 110.h,
                                      radius: 0,
                                    ),
                                    //Image.asset('images/png/imageCar.png'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '      Explore',
                                          style: TextStyles.lato12MediumDarkBlue,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 9.h,
                                            horizontal: 11.w,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color(0xff22323B),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12.r),
                                              bottomRight: Radius.circular(19.r),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                ImagesManager.fav,
                                                height: 16.h,
                                                width: 16.w,
                                              ),
                                              Text(
                                                'add to Fav',
                                                style: TextStyles.latoWhite12Bold,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  verticalSpace(17),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Car Brands', style: TextStyles.lato15SemiBoldBlack),
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
                  verticalSpace(16),
                  // In your widget tree:
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoadingBrandsState) {
                        return Center(child: BrandLoader());
                      } else if (HomeCubit.get(context).carBrands.isNotEmpty) {
                        return SizedBox(
                          height: 64.h,
                          child: LazyLoadScrollView(
                            isLoading: state is LoadMoreBrandsState,
                            scrollDirection: Axis.horizontal,
                            onEndOfPage: HomeCubit.get(context).loadMoreBrands,
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                final brand =
                                    HomeCubit.get(context).carBrands[index];
                                return AppCachedNetworkImage(
                                  fit: BoxFit.contain,
                                  radius: 30.r,
                                  image: brand.acf.brandLogo.url,
                                  height: 64.h,
                                  width: 64.w,
                                );
                              },
                              separatorBuilder:
                                  (context, index) => horizontalSpace(4),
                              itemCount:
                                  HomeCubit.get(context).visibleBrandsCount,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                            ),
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  verticalSpace(16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Services', style: TextStyles.lato15SemiBoldBlack),
                        horizontalSpace(4),
                        GestureDetector(
                          onTap: (){
                            context.pushNamed(Routes.allService);
                          },
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
                  verticalSpace(8),
                  SizedBox(
                    height: 134.h,
                    child: BlocBuilder<ServicesCubit, ServicesState>(
                      builder: (context, state) {
                        if(state is ServicesLoading){
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.separated(
                          padding: EdgeInsetsDirectional.only(start: 18.w,end: 18.w),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                              padding: EdgeInsetsDirectional.only(start: 8.4.w,top:8.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 1.17),
                                    blurRadius: 8.98,
                                    color: Color(0x17000000),
                                    spreadRadius: 3.5,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(13.5.r),
                              ),
                              height: 114.h,
                              width: 106.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppCachedNetworkImage(
                                    fit: BoxFit.cover,
                                    radius: 13.5.r,
                                    image:
                                        ServicesCubit.get(context).serviceCenters[index].featuredImage,
                                    height: 38.h,
                                    width: 40.w,),
                                  Text(
                                    ServicesCubit.get(context).serviceCenters[index].title.rendered,
                                    overflow: TextOverflow.clip,
                                    style: TextStyles.lato17BoldDarkBlue.copyWith(
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  Text(
                                    ServicesCubit.get(context).serviceCenters[index].acf.address,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles.lato12MediumDarkBlue
                                        .copyWith(
                                          fontSize: 6.7.sp,
                                          color: Color(0xba263f4d),
                                        ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return horizontalSpace(9);
                          },
                          itemCount: ServicesCubit.get(context).serviceCenters.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                        );
                      },
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 185.h,
                        padding: EdgeInsetsDirectional.only(start: 30.w),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 84.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'sell',
                                    style: TextStyles.lato21Regulargrey,
                                  ),
                                  Text(
                                    'your car',
                                    style: TextStyles.lato21SemiBoldDarkBlue,
                                  ),
                                  AppTextButton(
                                    buttonText: 'sell now',
                                    textStyle: TextStyles.latoWhite12Bold,
                                    onPressed: () {
                                      context.pushNamed(Routes.addNewChooseBrand);
                                    },
                                    backgroundColor: Color(0xff263F4D),
                                    buttonHeight: 23,
                                    borderRadius: 13.r,
                                    horizontalPadding: 0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Image.asset(ImagesManager.sellCar, height: 185.h),
                      ),
                    ],
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
                        } else if (HomeCubit.get(context).ads2.isEmpty) {
                          return SizedBox.shrink();
                        }
                        return AdsSlider(ads: HomeCubit.get(context).ads2);
                      },
                    ),
                  ),
                  verticalSpace(60),
                  //Image.asset(ImagesManager.logo),
                ],
              ),
            ),
          ],
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
    );
  }
}
