import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/features/services/logic/services_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';

class AllService extends StatelessWidget {
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
              BlocBuilder<ServicesCubit, ServicesState>(
                builder: (context, state) {
                  var listServices = ServicesCubit.get(context).listServices;
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ServiceContainer(
                        image: listServices[index].image,
                        title: listServices[index].title,
                        description: listServices[index].description,
                        onTap: () {
                          ServicesCubit.get(context).getCarAccessories();
                          context.pushNamed(Routes.serviceListDetails);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return verticalSpace(11);
                    },
                    itemCount: listServices.length,
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

class ServiceContainer extends StatelessWidget {
  const ServiceContainer({
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
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 7.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.r),
          color: Color(0x24d9d9d9),
        ),
        // height: 95.h,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 17.h),
              decoration: BoxDecoration(
                color: Color(0x54212121),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Center(
                child: Image.asset(image, height: 48.h, width: 48.w),
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
                  width: 227.w,
                  child: Text(
                    description,
                    overflow: TextOverflow.clip,
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
            'Services',
            style: TextStyles.inter18WhiteMedium,
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}
