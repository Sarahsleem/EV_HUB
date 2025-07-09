import 'package:evhub/core/helpers/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/font_weight.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/brands_loader.dart';
import '../../../../core/widgets/image_network.dart';
import '../../../../generated/l10n.dart';
import '../../../search/logic/search_cubit.dart';
import '../../../used_cars/ui/screen/used_car.dart';
import '../../../wish_list/logic/wish_list_cubit.dart';
import '../../data/model/car_model.dart';
import '../../logic/home_cubit.dart';

class CarBrandScreen extends StatefulWidget {
   CarBrandScreen({super.key, required this.carsResult});
  final String carsResult;
  @override
  State<CarBrandScreen> createState() => _CarBrandScreenState();
}

class _CarBrandScreenState extends State<CarBrandScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    HomeCubit.get(context)..getCarsByBrands(widget.carsResult);
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
              verticalSpace(10),
              // CustomAppBar(brand: widget.carsResult,),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoadingBrandsState) {
                    return Center(child: BrandLoader());
                  }  if (HomeCubit.get(
                    context,
                  ).carBrands.isEmpty) {
                    return  SizedBox.shrink();
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
                                HomeCubit.get(context).chooseBrand(
                                  HomeCubit.get(context).carBrands[index].id,
                                );
                                HomeCubit.get(context).getCarsByBrands( HomeCubit.get(context).carBrands[index].name);                              },
                              child: Opacity(
                                opacity: HomeCubit.get(
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
              ),

              verticalSpace(10),

              BlocBuilder<HomeCubit,HomeState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      dropdownColor: ColorsManager.darkBlue,
                      underline: SizedBox(),
                      icon: Icon(CupertinoIcons.sort_down_circle),
                      value: HomeCubit.get(context).selectedSort,
                      // isExpanded: true,
                      items:  HomeCubit.get(context).sortOptions
                          .map((sort) => DropdownMenuItem(
                        value: sort,
                        child: Text(sort),
                      ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          HomeCubit.get(context).selectedSort = value;
                          HomeCubit.get(context).sortBy(value);
                        }
                      },
                    ),
                  );
                },
              ),
              BlocBuilder<HomeCubit,HomeState>(
  builder: (context, state) {
    return Padding(
                padding: EdgeInsetsDirectional.only(end: 30.w),
                child: Text(
                  textAlign: TextAlign.end,
                  '${HomeCubit.get(context).carsByBrand.length} ${S.of(context).Results}',
                  style: TextStyles.inter16greyMedium.copyWith(
                    fontSize: 11.sp,
                  ),
                ),
              );
  },
),

              verticalSpace(13),
              BlocBuilder<HomeCubit,HomeState>(
                builder: (context, state) {
                  if(HomeCubit.get(context).carsByBrand.isEmpty){
                    return Center(child: Text(S.of(context).NoCarsFound),);
                  }
                  else if(state is CarByBrandLoading){
                    return Center(child: CircularProgressIndicator( color: ColorsManager.kPrimaryColor,),);
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return verticalSpace(12);
                    },
                    padding: EdgeInsets.symmetric(horizontal: 27.w),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount:HomeCubit.get(context).carsByBrand.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          context.pushNamed( Routes.carDetails, arguments:HomeCubit.get(context).carsByBrand[index]);

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
                                         HomeCubit.get(context).carsByBrand[index].title ?? '',
                                          style: TextStyles.inter18WhiteMedium
                                              .copyWith(fontSize: 15.3.sp),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          HomeCubit.get(context).carsByBrand[index].carBrand?[0]["name"],
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
                                        S.of(context).StartFrom,
                                        style: TextStyles.inter13greyRegular,
                                      ),
                                      Text(
                                        formatLocalizedPrice(HomeCubit.get(context).carsByBrand[index].acf!["price"], S.of(context).LE),
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
                                image:  HomeCubit.get(context).carsByBrand[index].featuredImage,
                                height: 160.h,
                                width: 304.w,
                                radius: 20.r,
                              ),
                              verticalSpace(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  HomeCubit.get(context).carsByBrand[index].acf!["km"]==null?SizedBox.shrink():Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [Image.asset("images/png/carused.png",height: 22.h,width: 22.w),Text(formatKm( HomeCubit.get(context).carsByBrand[index].acf!["km"]),style: TextStyles.inter18WhiteMedium,)],),
                                      Text(
                                        S.of(context).New,
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
                                    width:   HomeCubit.get(context).carsByBrand[index].acf!["km"]==null?225.w:140.w,
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
                                      final isFavorite = cubit.favCars.any((car) => car.id ==  HomeCubit.get(context).carsByBrand[index].id);

                                      return GestureDetector(
                                        onTap: () {
                                          if (isFavorite) {
                                            cubit.removeFromFavorites( HomeCubit.get(context).carsByBrand[index].id!);
                                            cubit.favCars.removeWhere((car) => car.id ==  HomeCubit.get(context).carsByBrand[index].id);
                                          } else {
                                            cubit.addToFavorites( HomeCubit.get(context).carsByBrand[index].id!);
                                            cubit.favCars.add( HomeCubit.get(context).carsByBrand[index]);
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
  const CustomAppBar({super.key, required this.brand});
final String brand;
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
            textAlign: TextAlign.center, brand,
            style: TextStyles.inter18WhiteMedium,
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}