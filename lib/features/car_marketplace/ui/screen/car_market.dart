
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
import '../../../home/ui/widgets/custom_search.dart';

class CarMarketScreen extends StatefulWidget {
  @override
  State<CarMarketScreen> createState() => _CarMarketScreenState();
}

class _CarMarketScreenState extends State<CarMarketScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // --- EDITED: Ensured all necessary data is bReing fetched ---
    // The order can be important. Fetching in parallel is better if possible.
    await Future.wait([
      HomeCubit.get(context).getAds(), // This was missing
      HomeCubit.get(context).getBrands(),
      CarMarketCubitCubit.get(context).getUsersByRole("showroom"),
       CarMarketCubitCubit.get(context). getCarAgency("caragency"),
    ]);
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/png/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                controller: _scrollController,
                children: [
                  const CustomAppBar(),
                  verticalSpace(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(Routes.searchFilter);
                      },
                      child: CustomSearch(),
                    ),
                  ),
                  //const CustomSearch(),
                  verticalSpace(20),
                  // --- SECTION: New Cars ---
                  _buildSectionHeader(
                    title: S.of(context).newcars,
                    iconPath: "images/png/transport 1.png",
                  ),
                  verticalSpace(13),
                  _buildHorizontalList(
                    seeAllRoute: Routes.newCars,
                    adsCubit: HomeCubit.get(context),
                  ),
                  verticalSpace(20),
                  // --- SECTION: Used Cars (Corrected from duplicate "New Cars") ---
                  _buildSectionHeader(
                    title: S.of(context).usedcars, // EDITED: Changed to "Used Cars"
                    iconPath: "images/png/transport 2.png",
                  ),
                  verticalSpace(13),
                  _buildHorizontalList(
                    seeAllRoute: Routes.usedCars, // EDITED: Changed route
                    adsCubit: HomeCubit.get(context),
                  ),
                  verticalSpace(20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 10.h,
                    ),
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoadingADS1State) {
                          return


                        AdsLoader();
                        } else if (HomeCubit.get(context).ads1.isNotEmpty) {
                        return AdsSlider(ads: HomeCubit.get(context).ads1);
                        }
                        return Container();
                      },
                    ),
                  ),
                  // --- SECTION: Showrooms ---
                  _buildSectionHeader(
                    title: S.of(context).showrooms,
                    // No icon for this one in the original code
                  ),
                  verticalSpace(13),
                  _buildShowroomsList(),
                  verticalSpace(20),
                  _buildSectionHeader(
                    title: S.of(context).caragrncy,
                    // No icon for this one in the original code
                  ),
                  verticalSpace(13),
                  

                       _buildcarAgencyList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGET: Section Header (to reduce repetition) ---
  Widget _buildSectionHeader({required String title, String? iconPath}) {
    return Row(
      children: [
        Text(title, style: TextStyles.inter18WhiteMedium),
        const Spacer(),
        if (iconPath != null)
          Image.asset(iconPath, height: 24.h, width: 24.w),
      ],
    );
  }

  // --- WIDGET: Horizontal List for Cars/Brands (to reduce repetition) ---
  Widget _buildHorizontalList({required String seeAllRoute, required HomeCubit adsCubit}) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1C2B33),
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // "See All" Button
            _buildSeeAllButton(onTap:
                () {
              context.pushNamed( seeAllRoute,arguments: 31);
            }),
            horizontalSpace(8),
            // Brands List
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  // EDITED: Added comprehensive state handling
                  if (state is HomeLoadingBrandsState) {
                    return Center(child: BrandLoader());
                  }
                  if (state is HomeErrorBrandsState) {
                    return Center(child: Text('Failed to load', style: TextStyles.latoGrey16SemiBold.copyWith(color: Colors.red)));
                  }
                  if (HomeCubit.get(context).carBrands.isEmpty) {
                    return Center(child: Text("No brands found", style: TextStyles.latoGrey16SemiBold));
                  }
                  return LazyLoadScrollView(
                    isLoading: state is LoadMoreBrandsState,
                    scrollDirection: Axis.horizontal,
                    onEndOfPage: HomeCubit.get(context).loadMoreBrands,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final brand = HomeCubit.get(context).carBrands[index];
                        return GestureDetector(
                          onTap: (){
                            context.pushNamed( seeAllRoute,arguments: brand.id);
                          },
                          child: AppCachedNetworkImage(
                            fit: BoxFit.contain,
                            radius: 30.r,
                            image: brand.acf.brandLogo.url,
                            height: 60.h,
                            width: 60.w,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => horizontalSpace(8),
                      itemCount: HomeCubit.get(context).visibleBrandsCount,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET: Showrooms List ---
  Widget _buildShowroomsList() {
    return BlocBuilder<CarMarketCubitCubit, CarMarketCubitState>(
      builder: (context, state) {
        final cubit = context.read<CarMarketCubitCubit>();
        // EDITED: Added comprehensive state handling
        if (state is CarMarketLoadingUsersState) {
          return const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state
        is CarMarketErrorUsersState) {
          return SizedBox(
            height: 100,
            child: Center(child: Text("Error: ${state.message}", style: const TextStyle(color: Colors.red))),
          );
        }
        if (cubit.companyUsers.isEmpty) {
          return SizedBox(
            height: 100,
            child: Center(child: Text("No showrooms found", style: TextStyles.latoGrey16SemiBold)),
          );
        }
       return SizedBox(
  height: 100,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: cubit.visibleUsersCount,
    itemBuilder: (context, index) {
      final company = cubit.companyUsers[index];
      return GestureDetector(
        onTap: () {
          context.pushNamed(
            Routes.showroom,
            arguments: company,
          );
        },
        child: _buildShowroomCard(company.profileImage, Colors.white),
      );
    },
  ),
);

      },
    );
  }


 Widget _buildcarAgencyList() {
    return BlocBuilder<CarMarketCubitCubit, CarMarketCubitState>(
      builder: (context, state) {
        final cubit = context.read<CarMarketCubitCubit>();
        // EDITED: Added comprehensive state handling
        if (state is CarMarketLoadingCarAgencyState) {
          return const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state
        is CarMarketErrorCarAgencyState) {
          return SizedBox(
            height: 100,
            child: Center(child: Text("Error: ${state.message}", style: const TextStyle(color: Colors.red))),
          );
        }
        if (cubit.caragency.isEmpty) {
          return SizedBox(
            height: 100,
            child: Center(child: Text("No showrooms found", style: TextStyles.latoGrey16SemiBold)),
          );
        }
       return SizedBox(
  height: 100,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: cubit.visibleUsersCount,
    itemBuilder: (context, index) {
      final company = cubit.caragency[index];
      return GestureDetector(
        onTap: () {
          context.pushNamed(
            Routes.showroom,
            arguments: company,
          );
        },
        child: _buildShowroomCard(company.profileImage, Colors.white),
      );
    },
  ),
);

      },
    );
  }

 
  // --- WIDGET: See All Button ---
  Widget _buildSeeAllButton({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          color: Color(0xFF2F3E47),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            "See\nAll",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }

  // --- WIDGET: Individual Showroom Card ---
  Widget _buildShowroomCard(String imageUrl, Color bgColor) {
    return 
    Container(
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



class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios_rounded, size: 20.sp, color: Colors.white),
        ),
        Expanded(
          child: Text(
            S.of(context).carMarketplaces,
            textAlign: TextAlign.center,
            style: TextStyles.inter18WhiteMedium,
          ),
        ),
        SizedBox(width: 40.w), // To balance the back button space
      ],
    );
  }
}