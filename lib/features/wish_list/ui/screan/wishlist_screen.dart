import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/theming/font_weight.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:evhub/features/new_cars/logic/new_cars_cubit.dart';
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
import '../../../../generated/l10n.dart';
import '../../../home/logic/home_cubit.dart';
import '../../../home/ui/widgets/custom_search.dart';
import '../../../used_cars/ui/screen/used_car.dart';
import '../../logic/wish_list_cubit.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    WishListCubit.get(context).getFavorites();
    // HomeCubit.get(context).getBrands().then((_) {
    //   WishListCubit.get(context).getWishListByBrand(13);
    // });

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
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed(Routes.searchFilter);
                  },
                  child: CustomSearch(),
                ),
              ),

              verticalSpace(17),
              BlocBuilder<WishListCubit, WishListState>(
                builder: (context, state) {
                  if (state is GetFavoritesLoadingState) {
                    return SizedBox.shrink();
                  }
                  return Padding(
                    padding: EdgeInsetsDirectional.only(end: 30.w),
                    child: Text(
                      textAlign: TextAlign.end,
                      '${WishListCubit.get(context).favCars.length} Result',
                      style: TextStyles.inter16greyMedium.copyWith(
                        fontSize: 11.sp,
                      ),
                    ),
                  );
                },
              ),
              verticalSpace(13),
              BlocBuilder<WishListCubit, WishListState>(
                builder: (context, state) {
                  var cars = WishListCubit.get(context).favCars;
                  if (state is GetFavoritesLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (cars.isEmpty) {
                    return Center(child: Text(S.of(context).NoCarsFound));
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return verticalSpace(12);
                    },
                    padding: EdgeInsets.symmetric(horizontal: 27.w),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: WishListCubit.get(context).favCars.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            Routes.carDetails,
                            arguments: cars[index],
                          );
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          cars[index].carBrand?[0]  ["name"],
                                          style: TextStyles.inter13greyRegular
                                              .copyWith(fontSize: 15.3.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.of(context).StartFrom,
                                        style: TextStyles.inter13greyRegular,
                                      ),
                                      Text(
                                        '${NumberFormat("#,###").format(double.tryParse(cars[index].acf!["price"].toString()) ?? 'N/A')} LE',
                                        style: TextStyles.inter13greyRegular
                                            .copyWith(
                                              fontSize: 15.3.sp,
                                              fontWeight:
                                                  FontWeightHelper.medium,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  cars[index].acf!["km"] == 0
                                      ? SizedBox.shrink()
                                      : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                "images/png/carused.png",
                                                height: 22.h,
                                                width: 22.w,
                                              ),
                                              Text(
                                                formatKm(
                                                  cars[index].acf!["km"],
                                                ),
                                                style:
                                                    TextStyles
                                                        .inter18WhiteMedium,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            S.of(context).Used,
                                            style: TextStyles.inter16greyMedium
                                                .copyWith(fontSize: 11.sp),
                                          ),
                                          Text(
                                            S.of(context).GoodCondition,
                                            style: TextStyles.inter16greyMedium
                                                .copyWith(fontSize: 11.sp),
                                          ),
                                        ],
                                      ),
                                  Container(
                                    width:
                                        cars[index].acf!["km"] == 0
                                            ? 225.w
                                            : 140.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(59.r),
                                      color: Color(0x2ed9d9d9),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        S.of(context).Explore,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  BlocBuilder<WishListCubit, WishListState>(
                                    builder: (context, state) {
                                      final cubit = WishListCubit.get(context);
                                      final carId = cars[index].id!;
                                      final isFavorite = cubit.favCars.any(
                                        (car) => car.id == carId,
                                      );

                                      final isUpdatingThisCar =
                                          (state
                                                  is AddToFavoritesLoadingState ||
                                              state
                                                  is RemoveFromFavoritesLoadingState) &&
                                          cubit.updatingCarId == carId;

                                      return GestureDetector(
                                        onTap: () {
                                          if (isFavorite) {
                                            cubit.removeFromFavorites(carId);
                                            cubit.favCars.removeWhere(
                                              (car) => car.id == carId,
                                            );
                                          } else {
                                            cubit.addToFavorites(carId);
                                            cubit.favCars.add(cars[index]);
                                          }
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: const Color(
                                            0xff1B262C,
                                          ),
                                          child:
                                              isUpdatingThisCar
                                                  ? const SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                        ),
                                                  )
                                                  : Icon(
                                                    CupertinoIcons.heart_fill,
                                                    color:
                                                        isFavorite
                                                            ? Colors.red
                                                            : const Color(
                                                              0xa8ffffff,
                                                            ),
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
            'Favourite',
            style: TextStyles.inter18WhiteMedium,
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}
