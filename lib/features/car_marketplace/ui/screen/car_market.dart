import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/core/theming/font_weight.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:evhub/core/widgets/brands_loader.dart';
import 'package:evhub/features/car_marketplace/logic/cubit/car_market_cubit_cubit.dart';
import 'package:evhub/features/home/ui/widgets/ADS_widget.dart';
import 'package:evhub/features/home/ui/widgets/Ads_loader.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/app_text_form_field.dart';

import '../../../../core/widgets/image_network.dart';
import '../../../../generated/l10n.dart';
import '../../../home/logic/home_cubit.dart';

class CarMarketScreen extends StatefulWidget {
  @override
  State<CarMarketScreen> createState() => _CarMarketScreenState();
}

class _CarMarketScreenState extends State<CarMarketScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load initial data
    _loadData();
  }

  Future<void> _loadData() async {
    // Load all necessary data here
    await HomeCubit.get(context).getBrands();
    await CarMarketCubitCubit.get(context).getUsersByRole("showroom");
    // Add any other data loading calls you need
  }

  Future<void> _onRefresh() async {
    await _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/png/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                controller: _scrollController,
                children: [
                  CustomAppBar(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: CustomSearch(),
                  ),
                  verticalSpace(20),
                  Row(
                    children: [
                      Text(
                        S.of(context).newcars,
                        style: TextStyles.inter18WhiteMedium,),
                      Spacer(),
                      Image.asset(
                        "images/png/transport 1.png",
                        height: 24.h,
                        width: 24.w,
                      ),
                    ],
                  ),
                  verticalSpace(13),
                  Container(
                    height: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C2B33),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        // "See All" Button
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18.w,
                            vertical: 10.h,
                          ),
                          child: BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              if (state is HomeLoadingADS1State) {
                                return AdsLoader();
                              } else if (HomeCubit.get(
                                context,
                              ).ads1.isNotEmpty) {
                                return AdsSlider(
                                  ads: HomeCubit.get(context).ads1,
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF2F3E47),
                            shape: BoxShape.circle,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              context.pushNamed( Routes.newCars);
                            },
                            child: const Center(
                              child: Text(
                                "See\nAll",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Brand logos
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            if (state is HomeLoadingBrandsState) {
                              return Center(child: BrandLoader());
                            } else if (HomeCubit.get(
                              context,
                            ).carBrands.isNotEmpty) {
                              return SizedBox(
                                height: 64.h,
                                child: LazyLoadScrollView(
                                  isLoading: state is LoadMoreBrandsState,
                                  scrollDirection: Axis.horizontal,
                                  onEndOfPage:
                                      HomeCubit.get(context).loadMoreBrands,
                                  child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      final brand =
                                          HomeCubit.get(
                                            context,
                                          ).carBrands[index];
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
                                        HomeCubit.get(
                                          context,
                                        ).visibleBrandsCount,
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
                      ],
                    ),
                  ),
                  verticalSpace(20),
                  Row(
                    children: [
                      Text(
                        S.of(context).newcars,
                        style: TextStyles.inter18WhiteMedium.copyWith(
                          fontSize: 21,
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        "images/png/transport 2.png",
                        height: 24.h,
                        width: 24.w,
                      ),
                    ],
                  ),
                  verticalSpace(13),
                  Container(
                    height: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C2B33),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18.w,
                            vertical: 10.h,
                          ),
                          child: BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              if (state is HomeLoadingADS1State) {
                                return AdsLoader();
                              } else if (HomeCubit.get(
                                context,
                              ).ads1.isNotEmpty) {
                                return AdsSlider(
                                  ads: HomeCubit.get(context).ads1,
                                );
                                print("elhamduallah");
                              }
                              print("leh");
                              return Container();
                            },
                          ),
                        ),
                        // "See All" Button
                        Container(
                          width: 60,
                          height: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF2F3E47),
                            shape: BoxShape.circle,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.usedCars);
                            },
                            child: const Center(
                              child: Text(
                                "See\nAll",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Brand logos
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            if (state is HomeLoadingBrandsState) {
                              return Center(child: BrandLoader());
                            } else if (HomeCubit.get(
                              context,
                            ).carBrands.isNotEmpty) {
                              return SizedBox(
                                height: 64.h,
                                child: LazyLoadScrollView(
                                  isLoading: state is LoadMoreBrandsState,
                                  scrollDirection: Axis.horizontal,
                                  onEndOfPage:
                                      HomeCubit.get(context).loadMoreBrands,
                                  child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      final brand =
                                          HomeCubit.get(
                                            context,
                                          ).carBrands[index];
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
                                        HomeCubit.get(
                                          context,
                                        ).visibleBrandsCount,
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18.w,
                            vertical: 10.h,
                          ),
                          child: BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              if (state is HomeLoadingADS1State) {
                                return AdsLoader();
                              } else if (HomeCubit.get(
                                context,
                              ).ads1.isNotEmpty) {
                                return AdsSlider(
                                  ads: HomeCubit.get(context).ads1,
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    S.of(context).showrooms,
                    style: TextStyles.inter18WhiteMedium.copyWith(fontSize: 21),
                  ),
                  BlocBuilder<CarMarketCubitCubit, CarMarketCubitState>(
                    builder: (context, state) {
                      final cubit = context.read<CarMarketCubitCubit>();
                      if (state is CarMarketLoadingUsersState) {
                        return const SizedBox(
                          height: 100,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (state is CarMarketErrorUsersState) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Error: ${state.message}",
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: cubit.visibleUsersCount,
                          itemBuilder: (context, index) {
                            final company = cubit.companyUsers[index];
                            return _buildShowroomCard(
                              company.profileImage,
                              Colors.white,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShowroomCard(String imageUrl, Color bgColor) {
    return Container(
      width: 100.w,
      height: 100.h,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: AppCachedNetworkImage(
            image: imageUrl,
            width: 70.w,
            height: 70.h,
            fit: BoxFit.contain,
            radius: 12,
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
            'Car Marketplaces',
            style: TextStyles.inter18WhiteMedium,
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}

Widget _buildShowroomCard(String imageUrl, Color bgColor) {
  return Container(
    width: 100.w,
    height: 100.h,
    margin: const EdgeInsets.only(right: 12),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: AppCachedNetworkImage(
          image: imageUrl,
          width: 70.w,
          height: 70.h,
          fit: BoxFit.contain,
          radius: 12,
        ),
      ),
    ),
  );
}
