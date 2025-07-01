import 'dart:io';

import 'package:evhub/core/assets/images.dart';
import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:evhub/features/home/data/model/company_model.dart';
import 'package:evhub/features/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/image_network.dart';

class ShowroomScreen extends StatefulWidget {
  const ShowroomScreen({super.key, required this.company});
  final CompanyModel company;

  @override
  State<ShowroomScreen> createState() => _ShowroomScreenState();
}

class _ShowroomScreenState extends State<ShowroomScreen> {
    void initState() {
    super.initState();
    HomeCubit.get(context).getCarsByAuthor(widget.company.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff243C43),
      body: Stack(
        children: [
          // خلفية الصورة مع التدرج
          Stack(
            children: [
              Image.asset(
                'images/png/Rectangle 4646.png',
                fit: BoxFit.contain,
                width: double.infinity,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.0),
                        Color(0xFF243C43),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: ListView(
                shrinkWrap: true,
                children: [
                  // Top Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.white, size: 24.sp),
                      ),
                      Text(
                        'Showroom',
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                      Row(
                        children: [
                          if (widget.company.phoneNumber.isNotEmpty)
                            GestureDetector(
                              onTap: () => whatsapp(widget.company.phoneNumber),
                              child: Image.asset(
                                'images/png/chat.png',
                                width: 39.w,
                                height: 39.h,
                              ),
                            ),
                          if (widget.company.phoneNumber.isNotEmpty)
                            GestureDetector(
                              onTap: () async {
                                final phoneUrl =
                                    Uri.parse("tel:${widget.company.phoneNumber}");
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

                  SizedBox(height: 140.h),

                  // صورة الحساب
                  CircleAvatar(
                    radius: 35.r,
                    backgroundImage: widget.company.profileImage.isNotEmpty
                        ? NetworkImage(widget.company.profileImage)
                        : const AssetImage('images/png/user_placeholder.png')
                            as ImageProvider,
                  ),

                  SizedBox(height: 12.h),

                  Center(
                    child: Text(
                      widget.company.displayName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),

                  if (widget.company.bio.isNotEmpty)
                    Center(
                      child: Text(
                        widget.company.bio,
                        style:
                            TextStyle(fontSize: 16.sp, color: Colors.white70),
                      ),
                    ),

                  SizedBox(height: 20.h),

                  if (widget.company.location.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: Colors.white),
                        SizedBox(width: 4.w),
                        Text(
                          "Tap to view on map",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                  SizedBox(height: 20.h),

                  if (widget.company.location.isNotEmpty)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      height: 120.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        image: const DecorationImage(
                          image: AssetImage('images/png/map.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: AppTextButton(
                          buttonText: "Location",
                          borderRadius: 16.8.r,
                          textStyle: TextStyles.lato9SemiBoldWhite,
                          backgroundColor: const Color(0xad22323b),
                          buttonWidth: 101,
                          buttonHeight: 16.h,
                          onPressed: () async {
                            final Uri url = Uri.parse(widget.company.location);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              print('Could not launch $url');
                            }
                          },
                        ),
                      ),
                    ),

                  SizedBox(height: 20.h),

                  if (widget.company.userEmail.isNotEmpty)
                    GestureDetector(
                      onTap: () async {
                        final Uri url = Uri.parse("mailto:${widget.company.userEmail}");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Cannot open email')),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('images/png/world.png',
                              width: 16.w, height: 16.h),
                          horizontalSpace(4.w),
                          Text(
                            widget.company.userEmail,
                            style: TextStyle(
                              color: Colors.white70,
                              decoration: TextDecoration.underline,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  //    verticalSpace(16),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 21.w),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'Electric Cars',
                  //         style: TextStyles.lato15SemiBoldBlack,
                  //       ),
                  //       horizontalSpace(4),
                  //       GestureDetector(
                  //         child: Row(
                  //           children: [
                  //             GestureDetector(
                  //               onTap: () {
                  //                 context.pushNamed(
                  //                   Routes.carsScreen,
                  //                   arguments: HomeCubit.get(context).cars,
                  //                 );
                  //               },
                  //               child: Text(
                  //                 'See all',
                  //                 style: TextStyles.lato13RegularGrey,
                  //               ),
                  //             ),
                  //             Icon(
                  //               Icons.arrow_forward_ios_rounded,
                  //               color: ColorsManager.gry,
                  //               size: 18.sp,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  
                  verticalSpace(12),
                  BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    if (state is HomeLoadingCarsByAuthorState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is HomeSuccessCarsByAuthorState) {
      var cars = state.authorCars;
      return SizedBox(
        height: 217.h,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
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
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19.r),
                  color: const Color(0xffEFEFEF),
                ),
                height: 217.h,
                width: 165.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 11.0.h,
                        left: 11.w,
                        right: 11.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 80.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cars[index].title ?? '',
                                  style: TextStyles.lato17BoldDarkBlue.copyWith(
                                    fontSize: 14.sp,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  cars[index].carBrand?[0]["name"] ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.latogrey12Medium,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            NumberFormat("#,###").format(
                              double.tryParse(
                                    cars[index].acf?["price"]?.toString() ?? '',
                                  ) ??
                                  0,
                            ),
                            style: TextStyles.lato12MediumDarkBlue,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    AppCachedNetworkImage(
                      image: cars[index].featuredImage ?? '',
                      height: 110.h,
                      fit: BoxFit.cover,
                      radius: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('   Explore',
                            style: TextStyles.lato12MediumDarkBlue),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 9.h,
                            horizontal: 11.w,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff22323B),
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
              ),
            );
          },
        ),
      );
    } else if (state is HomeErrorCarsByAuthorState) {
      return Center(
        child: Text(
          "❌ Error: ${state.message}",
          style: const TextStyle(color: Colors.white),
        ),
      );
    }

    return const SizedBox.shrink();
  },
),

                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

whatsapp(String num) async {
  num = num.replaceAll(RegExp(r'[^0-9]'), '');

  if (num.startsWith('00')) {
    num = num.substring(2);
  } else if (num.startsWith('0') && num.length == 11) {
    num = num.substring(1);
  }

  if (!num.startsWith('20')) {
    num = '20$num';
  }

  final url = 'https://wa.me/$num';
  final uri = Uri.parse(url);


      launchUrl(uri, mode: LaunchMode.externalApplication);


}
String removeHtmlTags(String htmlText) {
  final tagRegExp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
  final spanClassRegExp = RegExp(r'class="[^"]*"');
  final dirAttrRegExp = RegExp(r'dir="[^"]*"');

  // Remove HTML tags and attributes
  return htmlText
      .replaceAll(spanClassRegExp, '')
      .replaceAll(dirAttrRegExp, '')
      .replaceAll(tagRegExp, '')
      .replaceAll('&nbsp;', ' ')
      .trim();
}
