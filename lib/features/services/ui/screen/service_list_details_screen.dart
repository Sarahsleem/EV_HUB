import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/widgets/image_network.dart';
import 'package:evhub/features/services/logic/services_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';

class ServiceListDtailsScreen extends StatelessWidget {
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
              verticalSpace(13),
              ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return ServiceDetailsContainer(
                    title:
                        ServicesCubit.get(context).carAccessories[index].title,
                    image:
                        ServicesCubit.get(
                          context,
                        ).carAccessories[index].featured_image,
                    description:
                        ServicesCubit.get(
                          context,
                        ).carAccessories[index].content,
                  );
                },
                separatorBuilder: (context, index) {
                  return verticalSpace(12.8);
                },
                itemCount: ServicesCubit.get(context).carAccessories.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceDetailsContainer extends StatelessWidget {
  const ServiceDetailsContainer({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
    required this.description,
  });

  final String image;
  final String title;
  final String description;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 11.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.r),
          color: Color(0xdd9d9d9),
        ),
        // height: 95.h,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AppCachedNetworkImage(
                image: image,
                height: 113.h,
                width: 119.w,
              ),
            ),
            horizontalSpace(11),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 217.w,
                  child: Text(
                    title,
                    overflow: TextOverflow.clip,
                    style: TextStyles.lato21SemiBoldDarkBlue.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                verticalSpace(7),
                SizedBox(
                  width: 197.w,
                  child: Text(
                    removeHtmlTags(description),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.lato9SemiBoldWhite,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
            'Car Protection',
            style: TextStyles.inter18WhiteMedium,
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}
