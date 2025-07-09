import 'dart:io';

import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/features/profie/logic/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';

import 'package:image_picker/image_picker.dart';

import '../../../../core/widgets/image_network.dart';
import '../../../../generated/l10n.dart';

class CircleAvatr extends StatefulWidget {
  final String user;
  final String image;
  const CircleAvatr({Key? key, required this.user, required this.image}) : super(key: key);

  @override
  State<CircleAvatr> createState() => _CircleAvatrState();
}

class _CircleAvatrState extends State<CircleAvatr> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Stack(
              children: [
                AppCachedNetworkImage(
                  image:widget.image ,
                  height: 120.h,
                  width: 120.w,
                  radius: 60,
                ),
                Positioned(
                  bottom: 0.h,
                  right: 0.w,
                  child: GestureDetector(
                    onTap: (){
                      context.pushNamed(Routes.editProfile,arguments: ProfileCubit.get(context).profileUser);
                    },
                    child: Image.asset(
                      'images/png/edit.png',
                      width: 27.w,
                      height: 27.h,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(widget.user, style: TextStyles.poppinsMedium17lighterGray),
            SizedBox(height: 6.h),
            Text(
              S.of(context).User,
              style: TextStyles.poppinsRegular12lighterGray,
            ),
          ],
        ),
      ),
    );
  }
}
