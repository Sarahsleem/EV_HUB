import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets/images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/theming/theming_change/cubit/theme_cubit.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../logic/sign_up_cubit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _PasswordConfirmController = TextEditingController();

  bool _isChecked = false;
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _PasswordConfirmController.dispose();

    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (BuildContext context, SignUpState state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2,vertical:2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   // verticalSpace(20.h),
                    Center(
                      child: SizedBox(
                        // height: 72.h,
                      //  width: 280.w,
                        child: Column(

                          children: [
                           Image.asset( ImagesManager.logo)
                          ],
                        ),
                      ),
                    ),
                    verticalSpace(16),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          verticalSpace(16),

                        ],
                      ),
                    ),
                //    SignUpStateUi(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
