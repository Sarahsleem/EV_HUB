import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:evhub/core/widgets/image_network.dart';
import 'package:evhub/features/services/logic/services_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';

class ServiceListDtailsScreen extends StatefulWidget {
  const ServiceListDtailsScreen({super.key, required this.type});
final String type;
  @override
  State<ServiceListDtailsScreen> createState() => _ServiceListDtailsScreenState();
}

class _ServiceListDtailsScreenState extends State<ServiceListDtailsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TODO: implement didChangeDependencies
    ServicesCubit.get(context).loadData(widget.type);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: const AssetImage('images/png/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<ServicesCubit, ServicesState>(
            builder: (context, state) {
              final cubit = ServicesCubit.get(context);

              if (state is ServicesListLoading) {
                return Center(child: CircularProgressIndicator(color: ColorsManager.LigGthGray,));
              }

              if (state is ServicesListError) {
                return Center(child: AppTextButton(buttonText: S.of(context).tryagain, textStyle: TextStyles.lato9SemiBoldWhite, onPressed: () {  didChangeDependencies();}, buttonWidth: 200,));
              }

              final items = cubit.currentItems;

              return ListView(
                children: [
                  CustomAppBar(type: widget.type,),
                  verticalSpace(13),
                  ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ServiceDetailsContainer(
                        onTap: (){
                          context.pushNamed(Routes.oneServiceDetails, arguments: item);
                          print(item.acf.toString());
                        },
                        title: item.title??'',
                        featuredImage: item.featuredImage??'',
                        description:  item.content??'',
                      );
                    },
                    separatorBuilder: (_, __) => verticalSpace(12.8),
                    itemCount: items.length,
                  ),
                ],
              );
            },
          ),
        ),
      )

    );
  }
}

class ServiceDetailsContainer extends StatelessWidget {
  const ServiceDetailsContainer({
    super.key,
    required this.featuredImage,
    required this.title,
    this.onTap,
    required this.description,
  });

  final String featuredImage;
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
                image: featuredImage,
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
  const CustomAppBar({super.key, required this.type});
final String type;
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
            type,
            style: TextStyles.inter18WhiteMedium,
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}
