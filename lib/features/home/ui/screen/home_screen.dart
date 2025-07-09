import 'dart:ui';

import 'package:evhub/core/assets/images.dart';
import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:geocoding/geocoding.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:evhub/core/widgets/app_text_form_field.dart';
import 'package:evhub/core/widgets/image_network.dart';
import 'package:evhub/features/home/logic/home_cubit.dart';
import 'package:evhub/features/home/ui/widgets/ADS_widget.dart';
import 'package:evhub/features/home/ui/widgets/Ads_loader.dart';
import 'package:evhub/features/profie/logic/profile_cubit.dart';
import 'package:evhub/features/services/logic/services_cubit.dart';
import 'package:evhub/features/wish_list/logic/wish_list_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../core/db/cash_helper.dart';
import '../../../../core/localization/cubit/localization_cubit.dart';
import '../../../../core/networking/dio_factory.dart';
import '../../../../core/widgets/brands_loader.dart';
import '../../../../ev_hub.dart';
import '../../../../generated/l10n.dart';
import '../../../home/ui/widgets/custom_search.dart';
import '../widgets/service_loader.dart';
import '../widgets/ui_profile_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _getCurrentLocation();
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  LatLng? _currentLocation;
  bool _isLocationLoading = false;
  String? errorMessage;

  // New string representation for the UI
  String _locationLabel = "";
  Future<void> _getCurrentLocation() async {
    setState(() => _isLocationLoading = true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw Exception("Location services are disabled.");

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permissions are denied.");
        }
      }

      Position position = await Geolocator.getCurrentPosition();
      _currentLocation = LatLng(position.latitude, position.longitude);

      // Get the placemark (city, country, etc.)
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark placemark = placemarks.first;
      String placeName =
          placemark.locality ??
          placemark.subAdministrativeArea ??
          placemark.administrativeArea ??
          'Unknown';

      setState(() {
        _locationLabel = placeName;

        _isLocationLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLocationLoading = false;
        errorMessage = "Failed to get current location: $e";
        _locationLabel = "....";
      });
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     HomeCubit.get(context).getBrands(); // or call getBrands() separately here
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.white,
      onRefresh: () async {
        HomeCubit.get(context).loadHomeData();
        ServicesCubit.get(context).getServices();
        ProfileCubit.get(context).getProfile();
        _getCurrentLocation();
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
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
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Icon(Icons.drag_handle_outlined),
                      ),
                      horizontalSpace(6),
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
                            S.of(context).YourLocation,
                            style: TextStyles.latoWhite12Bold,
                          ),
                          Text(
                            _isLocationLoading
                                ? 'Loading...'
                                : (_locationLabel.isNotEmpty
                                    ? _locationLabel
                                    : 'Location not available'),
                            style: TextStyles.latoWhite16Bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                  BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return AppCachedNetworkImage(
                    image: ProfileCubit.get(context).profileUser?.image??'',height: 50.h,width: 50.w,radius: 25.r,);
  },
),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(Routes.stationsScreen);
                    },
                    child: Text(
                      S.of(context).BatteryLow,
                      style: TextStyles.latoWhite12Bold.copyWith(
                        fontSize: 34.sp,
                      ),
                    ),
                  ),
                  horizontalSpace(11),
                  Image.asset(ImagesManager.charge, width: 40.w, height: 40.h),
                ],
              ),
            ),
            verticalSpace(8),
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
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 18.w),
                    height: 56.h,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(Routes.allService);
                          },
                          child: CircleAvatar(
                            backgroundColor: ColorsManager.lightDarkBlue,
                            radius: 27.r,
                            child: Text(
                              textAlign: TextAlign.center,
                              S.of(context).Seeall,
                              style: TextStyles.font12WhiteRegular,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 56.h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (index == 2) {
                                    context.pushNamed(Routes.stationsScreen);
                                  } else {
                                    context.pushNamed(
                                      Routes.serviceListDetails,
                                      arguments:
                                          HomeCubit.get(
                                            context,
                                          ).features[index].route,
                                    );
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsetsDirectional.only(
                                    start: 6.w,
                                  ),
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
                                          HomeCubit.get(
                                            context,
                                          ).features[index].image,
                                          height: 25.h,
                                          width: 25.w,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                      horizontalSpace(6),
                                      Text(
                                        HomeCubit.get(
                                          context,
                                        ).features[index].title,
                                        style: TextStyles.inter12WhiteRegular,
                                      ),
                                      horizontalSpace(11),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return horizontalSpace(6);
                            },
                            itemCount: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).ElectricCars,
                          style: TextStyles.lato15SemiBoldBlack,
                        ),
                        horizontalSpace(4),
                        GestureDetector(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.pushNamed(
                                    Routes.carsScreen,
                                    arguments: HomeCubit.get(context).cars,
                                  );
                                },
                                child: Text(
                                  S.of(context).Seeall,
                                  style: TextStyles.lato13RegularGrey,
                                ),
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
                      if (state is HomeLoadingCarsState && state.isCarLoading) {
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
                              return GestureDetector(
                                onTap: () {
                                  context.pushNamed(
                                    Routes.carDetails,
                                    arguments: cars[index],
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                  ),
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
                                                        .copyWith(
                                                          fontSize: 14.sp,
                                                        ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    cars[index]
                                                        .carBrand?[0]["name"],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyles
                                                            .latogrey12Medium,
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
                                                  TextStyles
                                                      .lato12MediumDarkBlue,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      AppCachedNetworkImage(
                                        image: cars[index].featuredImage,
                                        height: 110.h,
                                        fit: BoxFit.cover,
                                        radius: 0,
                                      ),
                                      //Image.asset('images/png/imageCar.png'),
                                      BlocBuilder<WishListCubit, WishListState>(
                                        builder: (context, state) {
                                          final cubit = WishListCubit.get(context);
                                          final carId = cars[index].id!;
                                          final isFavorite = cubit.favCars.any((car) => car.id == carId);

                                          final isUpdatingThisCar =
                                              (state is AddToFavoritesLoadingState || state is RemoveFromFavoritesLoadingState) &&
                                                  cubit.updatingCarId == carId;
                                          return GestureDetector(
                                            onTap: () {
                                              if (isFavorite) {
                                                cubit.removeFromFavorites(carId);
                                                cubit.favCars.removeWhere((car) => car.id == carId);
                                              } else {
                                                cubit.addToFavorites(carId);
                                                cubit.favCars.add(cars[index]);
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  S.of(context).Explore,
                                                  style:
                                                      TextStyles
                                                          .lato12MediumDarkBlue.copyWith(
                                                    fontSize: 10.sp,),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 9.h,
                                                    horizontal: 11.w,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff22323B),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                12.r,
                                                              ),
                                                          bottomRight:
                                                              Radius.circular(
                                                                19.r,
                                                              ),
                                                        ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        isFavorite ? ImagesManager.favFilled : ImagesManager.fav,

                                                        height: 16.h,
                                                        width: 16.w,
                                                      ),
                                                      Text(
                                                        S.of(context).addtoFav,
                                                        style:
                                                            TextStyles
                                                                .latoWhite12Bold,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
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
                        Text(
                          S.of(context).CarBrands,
                          style: TextStyles.lato15SemiBoldBlack,
                        ),
                        horizontalSpace(4),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(Routes.carBrandScreen,arguments: HomeCubit.get(context).carBrands[0].name);
                          },
                          child: Row(
                            children: [
                              Text(
                                S.of(context).Seeall,
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
                      if (state is HomeLoadingBrandsState &&
                          state.isBrandLoading) {
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
                                return GestureDetector(
                                  onTap: () {
                                    context.pushNamed(Routes.carBrandScreen,arguments: HomeCubit.get(context).carBrands[index].name);
                                  },
                                  child: AppCachedNetworkImage(
                                    fit: BoxFit.contain,
                                    radius: 30.r,
                                    image: brand.acf.brandLogo.url,
                                    height: 64.h,
                                    width: 64.w,
                                  ),
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
                        Text(
                          S.of(context).Services,
                          style: TextStyles.lato15SemiBoldBlack,
                        ),
                        horizontalSpace(4),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(Routes.allService);
                          },
                          child: Row(
                            children: [
                              Text(
                                S.of(context).Seeall,
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
                        if (state is ServicesLoading) {
                          return Center(child: ServiceLoder());
                        }
                        return ListView.separated(
                          padding: EdgeInsetsDirectional.only(
                            start: 18.w,
                            end: 18.w,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap:
                                  () => context.pushNamed(
                                    Routes.oneServiceDetails,
                                    arguments:
                                        ServicesCubit.get(
                                          context,
                                        ).serviceCenters[index],
                                  ),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10.h),
                                padding: EdgeInsetsDirectional.only(
                                  start: 8.4.w,
                                  end: 8.4.w,
                                  top: 8.h,
                                  bottom: 12.h,
                                ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AppCachedNetworkImage(
                                      fit: BoxFit.cover,
                                      radius: 13.5.r,
                                      image:
                                          ServicesCubit.get(
                                            context,
                                          ).serviceCenters[index].featuredImage,
                                      height: 38.h,
                                      width: 40.w,
                                    ),
                                    buildStarDisplay(ServicesCubit.get(
                                      context,
                                    ).serviceCenters[index].ratings?.average??0),
                                    Text(
                                      ServicesCubit.get(
                                        context,
                                      ).serviceCenters[index].title,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.lato17BoldDarkBlue
                                          .copyWith(fontSize: 13.sp),
                                    ),
                                    Text(
                                      ServicesCubit.get(
                                        context,
                                      ).serviceCenters[index].type,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.lato12MediumDarkBlue
                                          .copyWith(
                                            fontSize: 6.7.sp,
                                            color: Color(0xba263f4d),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return horizontalSpace(9);
                          },
                          itemCount:
                              ServicesCubit.get(context).serviceCenters.length,
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
                                    S.of(context).sell,
                                    style: TextStyles.lato21Regulargrey,
                                  ),
                                  Text(
                                    S.of(context).yourcar,
                                    style: TextStyles.lato21SemiBoldDarkBlue,
                                  ),
                                  AppTextButton(
                                    buttonText: S.of(context).sellnow,
                                    textStyle: TextStyles.latoWhite12Bold,
                                    onPressed: () {
                                      context.pushNamed(
                                        Routes.addNewChooseBrand,
                                      );
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
                      LocalizationCubit.get(context).locale.languageCode == 'en' ?Positioned(
                        right: 0,
                        child: Image.asset(
                          ImagesManager.sellCar,
                          height: 185.h,
                        ),
                      ):Positioned(
                        left: 0,
                        child: Transform.flip(
                          flipX: true,
                          child: Image.asset(
                            ImagesManager.sellCar,
                            height: 185.h,
                          ),
                        ),
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

// لو عندك لوجو

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      width: MediaQuery.of(context).size.width * 0.75,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          // Blur background
          // BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          //   child: Container(color: Colors.transparent),
          // ),

          // Drawer content
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: const Color(0xFF0F2A36).withOpacity(0.93),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    // Profile
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(Routes.profile);
                      },
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoading) {
                            return UiLoadingProfile();
                          }
                          return Row(
                            children: [
                              AppCachedNetworkImage(
                                image: ProfileCubit.get(
                                  context,
                              ).profileUser?.image ?? "",
                                height: 54.h,
                                width: 54.w,
                                radius: 28.r,),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ProfileCubit.get(
                                          context,
                                        ).profileUser?.name ??
                                        "",
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                   "${ProfileCubit
                                        .get(
                                      context,
                                    )
                                        .profileUser
                                        ?.email}" ??
                                        "",
                                    overflow: TextOverflow.clip,
                                    softWrap: true,
                                    style: GoogleFonts.lato(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Menu
                    ..._buildMenuItem(
                      context,
                      S.of(context).Home,
                      Icons.home_outlined,
                      () {
                        context.pop();
                      },
                    ),
                    ..._buildMenuItem(
                      context,
                      S.of(context).myCars,
                      Icons.directions_car,
                      () {
                        context.pushNamed(Routes.myCarsScreen);
                      },
                    ),
                    ..._buildMenuItem(
                      context,
                      S.of(context).Favourite,
                      Icons.favorite_border,
                      () {
                        context.pushNamed(Routes.favouriteResult);
                      },
                    ),..._buildMenuItem(
                      context,
                      S.of(context).Blogs,
                      Icons.article_outlined,
                      () {
                        context.pushNamed(Routes.postsScreen);
                      },
                    ),
                    ..._buildMenuItem(
                      context,
                      S.of(context).HelpFAQ,
                      Icons.help_outline,
                      () {
                        context.pushNamed(Routes.qfaScreen);
                      },
                    ),
                    // ..._buildMenuItem(
                    //   context,
                    //   S.of(context).ContactUs,
                    //   Icons.call_outlined,
                    //   () {},
                    // ),
                    ..._buildMenuItem(
                      context,
                      S.of(context).Settings,
                      Icons.settings_outlined,
                      () {
                        context.pushNamed(Routes.settingsScreen);
                      },
                    ),..._buildMenuItem(
                      context,
                      S.of(context).Logout,
                      Icons.logout,
                          () {
                        // TODO: handle logout logic
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                            title:  Text(S.of(context).SureuouwanttoLogout),
                            // content:  Text(
                            //   'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                            // ),
                            actions: [
                              TextButton(
                                onPressed: () => context.pop(),
                                child:  Text(S.of(context).Cancel),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pushNamedAndRemoveUntil(Routes.signInScreen, predicate: (route) => false);
                                  CashHelper.clear();
                                  DioFactory.removeTokenIntoHeaderAfterLogout();
                                },
                                child:  Text(S.of(context).Logout),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    // const Spacer(),
                    //
                    // const Divider(
                    //   color: Color(0xFF1A7EFE),
                    //   thickness: 0.5,
                    //   height: 1,
                    // ),
                    // const SizedBox(height: 18),
                    //
                    // // Language switch
                    // Row(
                    //   children: [
                    //     const Icon(
                    //       Icons.language,
                    //       color: Colors.white70,
                    //       size: 18,
                    //     ),
                    //     const SizedBox(width: 10),
                    //     Text(
                    //       S.of(context).English,
                    //       style: GoogleFonts.lato(color: Colors.white),
                    //     ),
                    //     const Spacer(),
                    //     Text(
                    //       S.of(context).Arabic,
                    //       style: GoogleFonts.lato(color: Colors.white),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Function() on,
  ) {
    return [
      GestureDetector(
        onTap: on,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: Colors.white, size: 22),
          horizontalTitleGap: 12,
          title: Text(
            title,
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 14.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: on,
        ),
      ),
      const SizedBox(height: 4),
    ];
  }
}
Widget buildStarDisplay(num rating) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(5, (index) {
      return Icon(
        index < rating ? Icons.star : Icons.star_border,
        color: Color(0xff1A76FE),
        size: 10,
      );
    }),
  );
}