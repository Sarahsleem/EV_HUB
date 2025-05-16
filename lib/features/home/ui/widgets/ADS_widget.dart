import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/widgets/image_network.dart';
import '../../../../core/widgets/web_page_view.dart';
import '../../data/model/Ads_model.dart';

class AdsSlider extends StatefulWidget {
  final List<AdsModel> ads;

  const AdsSlider({super.key, required this.ads});

  @override
  State<AdsSlider> createState() => _AdsSliderState();
}

class _AdsSliderState extends State<AdsSlider> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 170.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.ads.length,
            itemBuilder: (context, index) {
              final ad = widget.ads[index];
              return GestureDetector(
                // onTap: () async {
                //   if (ad.link != null) {
                //     await launchURL(ad.link!, context);
                //   }
                // },
                onTap: () {
                  context.pushNamed(Routes.webPage, arguments: ad.link);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => WebViewPage(url: ad.link),
                  //   ),
                  // );
                                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: AppCachedNetworkImage(
                    image: ad.featuredImage ?? '',
                    height: 170.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        verticalSpace(10),
        SmoothPageIndicator(
          controller: _pageController,
          count: widget.ads.length,
          effect: WormEffect(
            dotHeight: 8.h,
            dotWidth: 8.w,
            activeDotColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}