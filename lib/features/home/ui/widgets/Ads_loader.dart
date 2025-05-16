import 'package:skeletonizer/skeletonizer.dart';


import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/image_network.dart';

class AdsLoader extends StatelessWidget {
  const AdsLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true, // show shimmer
      child: Card(
        color: ColorsManager.offWhite,
        margin: const EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AppCachedNetworkImage(image: '',width: double.infinity,height: 160,radius: 10,),
        ),
      ),
    );
  }
}
