import 'dart:convert';
import 'dart:io';

import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:evhub/core/widgets/app_text_form_field.dart';
import 'package:evhub/core/widgets/image_network.dart';
import 'package:evhub/features/car_details/data/user_model.dart';
import 'package:evhub/features/profie/data/models/profile_model.dart';
import 'package:evhub/features/profie/data/models/updated_profle_model.dart';
import 'package:evhub/features/profie/logic/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../generated/l10n.dart';
import '../widget/update_profile_status.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.userModel});
  final ProfileModel userModel;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? _image;
  String? _base64Image;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      final bytes = await pickedFile.readAsBytes();
      _base64Image = base64Encode(bytes);
    }
  }

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                verticalSpace(30),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 60.r,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child:
                        _image == null
                            ? AppCachedNetworkImage(
                              image: widget.userModel.image,
                              height: 120.h,
                              width: 120.w,
                              radius: 60,
                            )
                            : null,
                  ),
                ),
                verticalSpace(20),
                AppTextFormField(
                  hintText: widget.userModel.name ?? '',
                  controller: nameController,
                ),
                verticalSpace(20),
                AppTextFormField(
                  hintText: widget.userModel.email ?? '',
                  controller: emailController,
                ),
                verticalSpace(20),
                AppTextFormField(
                  hintText: widget.userModel.phoneNumber ?? '',
                  controller: phoneController,
                ),
                verticalSpace(60),
                AppTextButton(
                  buttonText: S.of(context).Submit,
                  backgroundColor: ColorsManager.kPrimaryColor,
                  borderRadius: 20.r,
                  buttonWidth: 100,
                  textStyle: TextStyles.inter18WhiteMedium,
                  onPressed: () {
                    ProfileCubit.get(context).updateProfile(
                      UpdatedProfileModel(
                        name:
                            nameController.text == ''
                                ? widget.userModel.name
                                : nameController.text,
                        email:
                            emailController.text == ''
                                ? widget.userModel.email
                                : emailController.text,
                        phone: phoneController.text==''?widget.userModel.phoneNumber:phoneController.text,
                        image: _base64Image??'',
                      ),
                    );
                  },
                ),
                UpdateProfileStatus(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
