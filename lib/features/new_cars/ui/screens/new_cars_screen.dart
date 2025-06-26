import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/theming/font_weight.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:evhub/features/new_cars/logic/new_cars_cubit.dart';
import 'package:evhub/features/wish_list/logic/wish_list_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/brands_loader.dart';
import '../../../../core/widgets/image_network.dart';
import '../../../home/logic/home_cubit.dart';
import '../../../home/ui/widgets/custom_search.dart';

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
     // WishListCubit.get(context).getFavorites();
      //NewCarsCubit.get(context).getNewCarsByBrand();
    });

    // HomeCubit.get(context).getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/png/background.png'),
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
                child: BlocBuilder<NewCarsCubit, NewCarsState>(
  builder: (context, state) {
    return BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadingBrandsState) {
                      return Center(child: BrandLoader());
                    }  if (HomeCubit.get(
                      context,
                    ).carBrands.isEmpty) {
                      return const Center(child: Text('No brands available.'));
                    }
                    else {
                      return SizedBox(
                      height: 74.h,
                      child: LazyLoadScrollView(
                        isLoading:  state is LoadMoreBrandsState,
                        scrollDirection: Axis.horizontal,
                        onEndOfPage: HomeCubit.get(context).loadMoreBrands,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                NewCarsCubit.get(context).chooseBrand(
                                  HomeCubit.get(context).carBrands[index].id,
                                );
                                NewCarsCubit.get(context).getNewCarsByBrand();
                              },
                              child: Opacity(
                                opacity: NewCarsCubit.get(
                                  context,
                                ).selectedBrandId==HomeCubit.get(
                                  context,
                                ).carBrands[index].id

                                    ?1:0.31,
                                child: Container(
                                  height: 64.h,
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.r),
                                    // border: Border.all(
                                    //   color:
                                    //   NewCarsCubit.get(
                                    //     context,
                                    //   ).selectedBrandId==HomeCubit.get(
                                    //                 context,
                                    //               ).carBrands[index].id
                                    //
                                    //           ? ColorsManager.kPrimaryColor
                                    //           : ColorsManager.borderGrey,
                                    //   width: 1.3,
                                    // ),
                                  ),
                                  child: AppCachedNetworkImage(
                                    fit: BoxFit.contain,
                                    radius: 30.r,
                                    image:
                                        HomeCubit.get(
                                          context,
                                        ).carBrands[index].acf.brandLogo.url,
                                    height: 64.h,
                                    width: 64.w,
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return horizontalSpace(4);
                          },
                          itemCount: HomeCubit.get(context).visibleBrandsCount,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                        ),
                      ),
                    );
                    }
                  },
                );
  },
),
              ),
              verticalSpace(17),
              BlocBuilder<NewCarsCubit, NewCarsState>(
                builder: (context, state) {
                  if (state is NewCarsLoadingState) {
                    return SizedBox.shrink();
                  }
                  return Padding(
                    padding: EdgeInsetsDirectional.only(end: 30.w),
                    child: Text(
                      textAlign: TextAlign.end,
                      '${NewCarsCubit.get(context).newCars.length} Result',
                      style: TextStyles.inter16greyMedium.copyWith(
                        fontSize: 11.sp,
                      ),
                    ),
                  );
                },
              ),
              verticalSpace(13),
              BlocBuilder<NewCarsCubit, NewCarsState>(
                builder: (context, state) {
                  var cars = NewCarsCubit.get(context).newCars;
                  if (state is NewCarsLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  else if(cars.isEmpty){
                    return Center(child: Text('No Cars Found'),);
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return verticalSpace(12);
                    },
                    padding: EdgeInsets.symmetric(horizontal: 27.w),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: cars.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.pushNamed( Routes.carDetails, arguments:cars[index]);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 23.h,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff1C2F39),
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cars[index].title ?? '',
                                          style: TextStyles.inter18WhiteMedium
                                              .copyWith(fontSize: 15.3.sp),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          cars[index].carBrand?[0]["name"],
                                          style: TextStyles.inter13greyRegular
                                              .copyWith(fontSize: 15.3.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'starts From',
                                        style: TextStyles.inter13greyRegular,
                                      ),
                                      Text(
                                        '${NumberFormat("#,###").format(double.tryParse(cars[index].acf!["price"].toString()) ?? 'N/A')} LE',
                                        style: TextStyles.inter13greyRegular
                                            .copyWith(
                                              fontSize: 15.3.sp,
                                              fontWeight: FontWeightHelper.medium,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              verticalSpace(10),
                              AppCachedNetworkImage(
                                image: cars[index].featuredImage,
                                height: 160.h,
                                width: 304.w,
                                radius: 20.r,
                              ),
                              verticalSpace(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 225.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(59.r),
                                      color: Color(0x2ed9d9d9),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        'Explore',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  BlocBuilder<WishListCubit, WishListState>(
                                    builder: (context, state) {
                                      final cubit = WishListCubit.get(context);
                                      final isFavorite = cubit.favCars.any((car) => car.id == cars[index].id);

                                      return GestureDetector(
                                        onTap: () {
                                          if (isFavorite) {
                                            cubit.removeFromFavorites(cars[index].id!);
                                            cubit.favCars.removeWhere((car) => car.id == cars[index].id);
                                          } else {
                                            cubit.addToFavorites(cars[index].id!);
                                            cubit.favCars.add(cars[index]);
                                          }
                                          //cubit.emit(GetFavoritesSuccessState(cubit.favCars));
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: const Color(0xff1B262C),
                                          child: Icon(
                                            CupertinoIcons.heart_fill,
                                            color: isFavorite ? Colors.red : const Color(0xa8ffffff),
                                            size: 20.sp,
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
