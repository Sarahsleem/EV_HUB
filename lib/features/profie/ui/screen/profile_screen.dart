import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/networking/dio_factory.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:evhub/features/navbar/logic/nav_bar_cubit.dart';
import 'package:evhub/features/profie/logic/profile_cubit.dart';
import 'package:evhub/features/profie/ui/widget/contact_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

import '../../../../core/db/cached_app.dart';
import '../../../../core/db/cash_helper.dart';

import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';

import '../widget/circle.dart';
import '../widget/guest.dart';
import '../widget/profile_loading_state.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    ProfileCubit.get(context).getProfile();
    print(ProfileCubit.get(context).profileUser.toString());
  }

  Future<void> _launchDeleteAccountURL(BuildContext context) async {
    context.pushNamed(
      Routes.webPage,
      arguments: 'https://evhubtl.com/delete-account',
    );

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
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Skeletonizer(
            enabled: true,
            child: UiLoadingProfileScreen(),
          );
        }
        if (ProfileCubit.get(context).profileUser != null) {
          return Scaffold(
            body: Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Image.asset(
                    'images/png/gradient (3) 1 (3).png', // ضع هنا مسار الصورة المناسبة لك
                    fit: BoxFit.cover,
                  ),
                ),

                // Overlay for slight darkening if needed
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(
                      0.5,
                    ), // optional: تعتيم للخلفية لتحسين التباين
                  ),
                ),

                // Main content
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      CircleAvatr(

                        user: ProfileCubit.get(context).profileUser!.name!, image: ProfileCubit.get(context).profileUser!.image??''
                      ),
                      SizedBox(height: 14),
                      ContactDetails(
                        title: S.of(context).YourEmail,
                        content: ProfileCubit.get(context).profileUser!.email!,
                        img: 'images/png/mail-01.svg',
                      ),
                      SizedBox(height: 14),
                      ContactDetails(
                        title: S.of(context).phonenumber,
                        content:
                            ProfileCubit.get(
                              context,
                            ).profileUser!.phoneNumber ??
                            '',
                        img: 'images/png/call.svg',
                      ),
                      // SizedBox(height: 14),
                      // ContactDetails(
                      //   title: 'City',
                      //   content: ProfileCubit.get(context).profileUser!.role!,
                      //   img: '',
                      // ),
                     // SizedBox(height: 140),
                      // GestureDetector(
                      //   onTap: () => _launchDeleteAccountURL(context),
                      //   child: Center(
                      //     child: Text(
                      //       'Delete Your Account',
                      //       style: TextStyles.latoBold12red,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}

// BlocBuilder<ProfileCubit, ProfileState>(
// builder: (context, state) {
// if (state is ProfileLoading) {
// return const Skeletonizer(
// enabled: true,
// child: UiLoadingProfile(),
// );
// }
// if (ProfileCubit.get(context).profileUser != null) {
// return Padding(
// padding: EdgeInsets.symmetric(horizontal: 26.0.w),
// child: Row(
// children: [
// AppCachedNetworkImage(image:ProfileCubit.get(context).profileUser!.profilePicture, width: 54, height: 54, radius: 200,
//
// ),
// horizontalSpace(17),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// ProfileCubit.get(context).profileUser!.name!,
// style: TextStyles.poppinsRegular16contantGray,
// ),
// Text(
// ProfileCubit.get(context).profileUser!.email!,
// style: TextStyles.poppinsRegular16LightGray,
// ),
// ],
// )
// ],
// ),
// );
// }
// return GuestProfile();
// },
// ),
