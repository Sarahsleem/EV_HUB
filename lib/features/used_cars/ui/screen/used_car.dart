import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/theming/font_weight.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:evhub/features/new_cars/logic/new_cars_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/brands_loader.dart';
import '../../../../core/widgets/image_network.dart';
import '../../../home/logic/home_cubit.dart';
import '../../../home/ui/widgets/custom_search.dart';

class UsedCarScreen extends StatefulWidget {
   UsedCarScreen({super.key, required this.brandId});
  final int brandId;
  @override
  State<UsedCarScreen> createState() => _UsedCarScreenState();
}

class _UsedCarScreenState extends State<UsedCarScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    HomeCubit.get(context).getBrands().then((_) {
      NewCarsCubit.get(context).chooseBrand(widget.brandId);

      NewCarsCubit.get(context).getUsedCarsByBrand(widget.brandId);
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
                child: BlocBuilder<NewCarsCubit, NewCarsState>(
                  builder: (context, state) {
                    return BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoadingBrandsState) {
                          return Center(child: BrandLoader());
                        }
                        return SizedBox(
                          height: 74.h,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  NewCarsCubit.get(context).chooseBrand(
                                    HomeCubit.get(context).carBrands[index].id,
                                  );
                                  NewCarsCubit.get(context).getUsedCarsByBrand(HomeCubit.get(context).carBrands[index].id);
                                },
                                child: Opacity(
                                  opacity:
                                      NewCarsCubit.get(
                                                context,
                                              ).selectedBrandId ==
                                              HomeCubit.get(
                                                context,
                                              ).carBrands[index].id
                                          ? 1
                                          : 0.31,
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
                            itemCount: HomeCubit.get(context).carBrands.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                          ),
                        );
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
                  } else if (cars.isEmpty) {
                    return Center(child: Text('No Cars Found'));
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return verticalSpace(12);
                    },
                    padding: EdgeInsets.symmetric(horizontal: 27.w),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: NewCarsCubit.get(context).newCars.length,
                    itemBuilder: (context, index) {
                      return GestureDetector( onTap: (){
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
                                        'price',
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [Image.asset("images/png/carused.png",height: 22.h,width: 22.w),Text(formatKm(cars[index].acf!["km"]),style: TextStyles.inter18WhiteMedium,)],),
                                      Text(
                                        'Installments',
                                        style: TextStyles.inter16greyMedium
                                            .copyWith(fontSize: 11.sp),
                                      ),
                                      Text(
                                        'Good Condition',
                                        style: TextStyles.inter16greyMedium
                                            .copyWith(fontSize: 11.sp),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 142.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(59.r),
                                      color: Color(0x2ed9d9d9),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        'Explore',
                                        style: TextStyles.inter18WhiteMedium
                                            .copyWith(fontSize: 9.7.sp),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Color(0xff1B262C),
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

// class CustomSearch extends StatelessWidget {
//   const CustomSearch({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return AppTextFormField(
//       prefexIcon: Icon(
//         CupertinoIcons.search,
//         color: ColorsManager.borderGrey,
//         size: 34.sp,
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: const BorderSide(color: Color(0x5ffffff), width: 1.3),
//         borderRadius: BorderRadius.circular(54.r),
//       ),
//       hintText: 'Search for anything',
//       backgroundColor: Color(0x61435f72),
//       hintStyle: TextStyles.latoGrey16SemiBold,
//       borderRadius: 54.r,
//       suffixIcon: Padding(
//         padding: const EdgeInsets.all(6.0),
//         child: CircleAvatar(
//           radius: 22.5.r,
//           backgroundColor: Colors.transparent,
//           child: Icon(
//             size: 31.sp,
//             Icons.filter_alt_outlined,
//             color: ColorsManager.borderGrey,
//           ),
//         ),
//       ),
//     );
//   }
// }
String formatKm(dynamic kmValue) {
  final km = double.tryParse(kmValue.toString());
  if (km == null) return '0';

  if (km >= 1000) {
    return '${(km / 1000).toStringAsFixed(0)}k';
  } else {
    return km.toStringAsFixed(0);
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
            'Used cars',
            style: TextStyles.inter18WhiteMedium,
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}
