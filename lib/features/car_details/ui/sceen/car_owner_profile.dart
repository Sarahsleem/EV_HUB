import 'package:evhub/core/helpers/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/font_weight.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/image_network.dart';
import '../../../../generated/l10n.dart';
import '../../../home/logic/home_cubit.dart';
import '../../../services/ui/screen/one_service_details.dart';
import '../../../used_cars/ui/screen/used_car.dart';
import '../../../wish_list/logic/wish_list_cubit.dart';
import '../../data/user_model.dart';

class CarOwnerProfile extends StatefulWidget {
   CarOwnerProfile({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<CarOwnerProfile> createState() => _CarOwnerProfileState();
}

class _CarOwnerProfileState extends State<CarOwnerProfile> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    HomeCubit.get(context).getCarsByAuthor(widget.userModel.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff243C43),
      body: SafeArea(child: ListView(children: [
        Padding(
          padding:EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white, size: 24.sp),
              ),

              Row(
                children: [
                  if (widget.userModel.phoneNumber.isNotEmpty)
                    GestureDetector(
                      onTap: () => whatsapp(widget.userModel.phoneNumber),
                      child: Image.asset(
                        'images/png/chat.png',
                        width: 39.w,
                        height: 39.h,
                      ),
                    ),
                  if (widget.userModel.phoneNumber.isNotEmpty)
                    GestureDetector(
                      onTap: () async {
                        final phoneUrl =
                        Uri.parse("tel:${widget.userModel.phoneNumber}");
                        if (await canLaunchUrl(phoneUrl)) {
                          await launchUrl(phoneUrl,
                              mode: LaunchMode.externalApplication);
                        } else {
                          print('❌ Could not launch phone call');
                        }
                      },
                      child: Image.asset(
                        'images/png/Phone_fill.png',
                        width: 32.w,
                        height: 32.h,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 140.h),

        // صورة الحساب
        CircleAvatar(
          radius: 35.r,
          backgroundImage:widget.userModel.profileImage.isNotEmpty
              ? NetworkImage(widget.userModel.profileImage)
              : const AssetImage('images/png/user_placeholder.png')
          as ImageProvider,
        ),

        SizedBox(height: 12.h),

        Center(
          child: Text(
            widget.userModel.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingCarsByAuthorState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeSuccessCarsByAuthorState) {
              var cars = state.authorCars;
              return SizedBox(
                // height: 27.h,
                child: ListView.separated(
                  separatorBuilder: (context, index) => verticalSpace(12.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
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
                                      S.of(context).StartFrom,
                                      style: TextStyles.inter13greyRegular,
                                    ),
                                    Text(
                                      formatLocalizedPrice(cars[index].acf?["price"], S.of(context).LE),
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
                                cars[index].acf!["km"]==null?SizedBox.shrink():Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [Image.asset("images/png/carused.png",height: 22.h,width: 22.w),Text(formatKm(cars[index].acf!["km"]),style: TextStyles.inter18WhiteMedium,)],),
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
                                  width:  cars[index].acf!["km"]==null?225.w:140.w,
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
                ),
              );
            } else if (state is HomeErrorCarsByAuthorState) {
              return SizedBox.shrink();
            }

            return const SizedBox.shrink();
          },
        ),
      ])),
    );
  }
}
