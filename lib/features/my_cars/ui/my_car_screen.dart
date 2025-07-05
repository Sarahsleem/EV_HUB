import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/core/theming/font_weight.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:evhub/features/new_cars/logic/new_cars_cubit.dart';
import 'package:evhub/features/wish_list/logic/wish_list_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/brands_loader.dart';
import '../../../../core/widgets/image_network.dart';
import '../../home/ui/widgets/custom_search.dart';
import '../logic/my_cars_cubit.dart';

class MyCars extends StatefulWidget {
  @override
  State<MyCars> createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    MyCarsCubit.get(context).getCars();

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

              verticalSpace(17),
              BlocBuilder<MyCarsCubit, MyCarsState>(
                builder: (context, state) {
                  if (state is MyCarsLoadingState) {
                    return SizedBox.shrink();
                  }
                  return Padding(
                    padding: EdgeInsetsDirectional.only(end: 30.w),
                    child: Text(
                      textAlign: TextAlign.end,
                      '${MyCarsCubit.get(context).myCarsList.length} Result',
                      style: TextStyles.inter16greyMedium.copyWith(
                        fontSize: 11.sp,
                      ),
                    ),
                  );
                },
              ),
              verticalSpace(13),
              BlocBuilder<MyCarsCubit, MyCarsState>(
                builder: (context, state) {
                  var cars = MyCarsCubit.get(context).myCarsList;
                  if (state is MyCarsLoadingState) {
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
                    itemCount: MyCarsCubit.get(context).myCarsList.length,
                    itemBuilder: (context, index) {
                      return Container(
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
                                        cars[index].carBrand?.isNotEmpty == true
                                            ? (cars[index].carBrand?[0]["name"])
                                            : "",
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
                                      '${cars[index].acf!["price"] == null ? 0 : NumberFormat("#,###").format(double.tryParse(cars[index].acf!["price"].toString()))} LE',
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
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          cars[index].status == 'publish'
                                              ? Colors.green
                                              : Colors.blue,
                                      radius: 8.5.r,
                                    ),
                                    horizontalSpace(5),
                                    Text(
                                      '${cars[index].status}',
                                      style: TextStyles.inter18WhiteMedium
                                          .copyWith(fontSize: 10.sp),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    AppTextButton(
                                      buttonText: 'edit',
                                      textStyle: TextStyles.inter18WhiteMedium
                                          .copyWith(fontSize: 10.sp),
                                      onPressed: () {
                                        context.pushNamed(
                                          Routes.editNewCarDtails,
                                          arguments: cars[index],
                                        );
                                      },
                                      backgroundColor: Color(0x2eD9D9D9),
                                      buttonHeight: 40,
                                      borderRadius: 39.r,
                                      horizontalPadding: 0,
                                      buttonWidth: 98,
                                    ),
                                    horizontalSpace(4),
                                    AppTextButton(
                                      buttonText: 'delete',
                                      textStyle: TextStyles.inter18WhiteMedium
                                          .copyWith(fontSize: 10.sp),
                                      onPressed: () {
                                        MyCarsCubit.get(
                                          context,
                                        ).deleteCar(cars[index].id!);
                                      },
                                      backgroundColor: Color(0x2eff0000),
                                      buttonHeight: 40,
                                      borderRadius: 39.r,
                                      horizontalPadding: 0,
                                      buttonWidth: 98,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
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
            'My cars',
            style: TextStyles.inter18WhiteMedium,
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}
