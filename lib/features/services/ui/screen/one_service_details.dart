import 'dart:io';

import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/image_network.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key, required this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xff243C43) ,
      body: Stack(
        children: [
          // Background Image
      Stack(
      //  mainAxisAlignment: MainAxisAlignment.end,
        children: [
          (data.acf.cover != null && data.acf.cover.url != null)
              ? AppCachedNetworkImage(
                height: 252.h,
                width:double.infinity,
                image: data.acf.cover.url!,
                fit: BoxFit.contain,
                          radius: 0,
              )
              : Container(
            color: Color(0xff243C43),
            child: SizedBox(

            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height:double.infinity, // adjust as needed
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.0),    // Transparent black (0%)
                    Color(0xFF243C43),              // Dark green (100%)
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
                physics: ScrollPhysics(),
                children: [
                  // Top Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                      Text(
                        data.type.replaceAll('-', ' '),
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                      Row(
                        children: [
                          // WhatsApp
                          GestureDetector(
                            onTap: () async {
                            whatsapp(data.acf.whatsapp);
                            },
                            child: Image.asset(
                              'images/png/chat.png',
                              width: 39.w,
                              height: 39.h,
                            ),
                          ),

                          // Phone Call
                          GestureDetector(
                            onTap: () async {
                              final phoneNumber =data.acf.phoneNumber;
                              final phoneUrl = Uri.parse("tel:$phoneNumber");

                              if (await canLaunchUrl(phoneUrl)) {
                                await launchUrl(phoneUrl, mode: LaunchMode.externalApplication);
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
                  CircleAvatar(
                    radius: 35.r,
                    child: AppCachedNetworkImage(
                      image: data.featuredImage,
                      height: 70.h,
                      width: 75.w,
                      radius: 35.r,
                    ),
                  ),
                  // Logo
                  // CircleAvatar(
                  //   radius: 30.r,
                  //   backgroundColor: Colors.black,
                  //   backgroundImage: AssetImage('assets/images/protect_me_logo.png'), // replace with actual logo
                  // ),
                  SizedBox(height: 12.h),

                  // Title
                  Center(
                    child: Text(
                      data.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Subtitle
                  Center(
                    child: Text(
                      data.type.replaceAll('-', ' '),
                      style: TextStyle(fontSize: 16.sp, color: Colors.white70),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Location Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.white),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 182.w,
                        child: Text(
                          data.acf.address,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  // const Text(
                  //   "Espana Plaza Mall",
                  //   style: TextStyle(color: Colors.white70),
                  // ),
                  SizedBox(height: 20.h),

                  // Description
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Text(
                      removeHtmlTags(data.content),
                      style: TextStyles.inter12WhiteRegular.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Rating
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: List.generate(
                  //     5,
                  //     (index) => Icon(
                  //       index < 4 ? Icons.star : Icons.star_border,
                  //       color: Colors.amber,
                  //       size: 20,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 16.h),

                  // Map Card
                  Container(
                    padding: EdgeInsets.only(bottom: 9.h),
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    height: 120.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      image: DecorationImage(
                        image: AssetImage(
                          'images/png/map.png',
                        ), // replace with real map or image
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AppTextButton(
                        buttonText: "Location",
                        borderRadius: 16.8.r,
                        textStyle: TextStyles.lato9SemiBoldWhite,
                        onPressed: () async {
                          final Uri url = Uri.parse(data.acf.addressLocation);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url, mode: LaunchMode.externalApplication);
                          } else {
                            // You can show a snackbar or alert here
                            print('Could not launch $url');
                          }
                        },

                        backgroundColor: Color(0xad22323b),
                        buttonWidth: 101,
                        buttonHeight: 16.h,
                      ),
                    ),

                    // Website
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () async {
                      final rawUrl = data.acf.website?.trim();
                      if (rawUrl == null || rawUrl.isEmpty) {
                        print("No URL found");
                        return;
                      }

                      final Uri url = Uri.parse(rawUrl);
                      print("Attempting to launch $url");

                      if (await canLaunchUrl(url)) {
                        final success = await launchUrl(url, mode: LaunchMode.externalApplication);
                        if (!success) {
                          print("Fallback to in-app webview");
                          await launchUrl(url, mode: LaunchMode.inAppWebView);
                        }
                      } else {
                        print("Could not launch $url");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Could not open the website')),
                        );
                      }
                    },

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/png/world.png', width: 16.w, height: 16.h),
                        horizontalSpace(4.w),
                        Text(
                          "www.${data.title}.com",
                          style: TextStyle(
                            color: Colors.white70,
                            decoration: TextDecoration.underline,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
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
