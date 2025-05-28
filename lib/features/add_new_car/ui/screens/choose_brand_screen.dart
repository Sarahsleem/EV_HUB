import 'package:evhub/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';

class ChooseBrand extends StatelessWidget {
  const ChooseBrand({super.key});

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
            padding: EdgeInsets.symmetric(horizontal: 31.w),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded,),
                  ),
                  SizedBox(width: 24.w),
                ],
              ),
              Text(
                'Choose Your Car Brand',
                style: TextStyles.inter18WhiteMedium.copyWith(fontSize: 16.4.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
