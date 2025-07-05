import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/db/cash_helper.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/localization/cubit/localization_cubit.dart';
import '../../../core/networking/dio_factory.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  Future<void> _launchDeleteAccountURL(BuildContext context) async {
    context.pushNamed(Routes.webPage,arguments: 'https://evhubtl.com/delete-account');

    // final deleteappUrl = Uri.parse("https://evhubtl.com/delete-account");
    //
    // if (await canLaunchUrl(deleteappUrl)) {
    //   await launchUrl(deleteappUrl, mode: LaunchMode.externalApplication);
    // } else {
    //   print('❌ Could not launch WhatsApp');
    // }
    // final url = Uri.parse('https://evhubtl.com/delete-account');
    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("done")),
    //   );
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // لدعم العربية
      child: Scaffold(
        backgroundColor: ColorsManager.darkBlue,
        body: SafeArea(
          child: ListView(
            children: [
          CustomAppBar(),
               SizedBox(height: 16.h),
              LanguageListTile(),

              //const Divider(height: 0),
              // ListTile(
              //   trailing: const Icon(Icons.logout, color: Colors.red),
              //   leading:  Text(
              //     S.of(context).Logout,
              //     style: TextStyle(color: Colors.red),
              //   ),
              //   onTap: () {
              //     // TODO: handle logout logic
              //     showDialog(
              //       context: context,
              //       builder:
              //           (context) => AlertDialog(
              //             title:  Text(S.of(context).SureuouwanttoLogout),
              //             // content:  Text(
              //             //   'هل أنت متأكد أنك تريد تسجيل الخروج؟',
              //             // ),
              //             actions: [
              //               TextButton(
              //                 onPressed: () => context.pop(),
              //                 child:  Text(S.of(context).Cancel),
              //               ),
              //               TextButton(
              //                 onPressed: () {
              //                   context.pushNamedAndRemoveUntil(Routes.signInScreen, predicate: (route) => false);
              //                   CashHelper.clear();
              //                   DioFactory.removeTokenIntoHeaderAfterLogout();
              //                 },
              //                 child:  Text(S.of(context).Logout),
              //               ),
              //             ],
              //           ),
              //     );
              //   },
              // ),

             verticalSpace(30), GestureDetector(
                  onTap: () => context.pushNamed(Routes.resetPassword) ,
                  child: Center(
                    child: Text(
                      S.of(context).ResetPassword,
                      style: TextStyles.latoBold12red.copyWith(color: Colors.white),
                    ),
                  )),verticalSpace(20),
              GestureDetector(
                onTap: () => _launchDeleteAccountURL(context) ,
                child: Center(
                  child: Text(
                    S.of(context).DeleteYourAccount,
                    style: TextStyles.latoBold12red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



class LanguageListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(S.of(context).Language, style: TextStyles.inter16greyMedium),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LocalizationCubit.get(context).locale.languageCode == 'en'
                ? S.of(context).English
                : S.of(context).Arabic,
            style: TextStyles.inter13greyRegular,
          ),
          horizontalSpace(8),
          Icon(
            Icons.arrow_forward_ios,
            size: 20.sp,
            color: ColorsManager.offWhite,
          ),
        ],
      ),
      onTap: () {
        LocalizationCubit.get(context).toggleLanguage();
      },
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
            S.of(context).Settings,
            style: TextStyles.inter18WhiteMedium,
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}
