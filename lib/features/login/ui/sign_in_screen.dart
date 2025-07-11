import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/features/login/ui/widgets/sign_in_states_ui.dart';
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
import '../../../core/routing/routes.dart';
import '../../../core/widgets/phone_text_field.dart';
import '../../../generated/l10n.dart';
import '../../signup/data/models/sign_up_model.dart';
import '../../signup/logic/sign_up_cubit.dart';
import '../../signup/ui/widgets/sign_up_states.dart';
import '../data/models/sign_in_model.dart';
import '../logic/sign_in_cubit.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordsignUpController =
      TextEditingController();
  final TextEditingController _phoneSignUpController = TextEditingController();
  final TextEditingController _PasswordConfirmController =
      TextEditingController();

  bool _isChecked = false;
  @override
  void dispose() {
    _passwordController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (BuildContext context, SignInState state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // verticalSpace(20.h),
                    Center(
                      child: Column(
                        children: [
                          Image.asset(ImagesManager.car),

                          Text(
                            S.of(context).login,
                            style: TextStyles.lato28BoldGreen,
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 25,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).enteryourmobilenumber,
                              style: TextStyles.lato14RegularDark,
                            ),
                            verticalSpace(8),
                            PhoneTextForm(
                              controller: _phoneController,
                              onChanged:
                                  SignInCubit.get(context).changeSignInPhone,
                            ),
                            //  verticalSpace(16),
                            Text(
                              S.of(context).enteryourpassword,
                              style: TextStyles.lato14RegularDark,
                            ),
                            verticalSpace(8),
                            AppTextFormField(
                              maxLine: 1,
                              // onFieldSubmitted: (value) async {
                              //   if (formKey.currentState!.validate()) {
                              //     // Perform login
                              //     await SignInCubit.get(context).login(
                              //       SignIn(
                              //         phone: _phoneController.text,
                              //         password: _passwordController.text,
                              //       ),
                              //     );
                              //   }
                              // },
                              borderRadius: 16.5,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 15.h,
                              ),
                              controller: _passwordController,
                              hintText: S.of(context).password,
                              // isObscureText: AuthCubit.get(context).isObscureText2,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password must not be empty';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },

                              suffixIcon: GestureDetector(
                                onTap: () {
                                  SignInCubit.get(context).obscureText1();
                                },
                                child: Icon(
                                  SignInCubit.get(context).isObscureText1
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            verticalSpace(16),
                            Center(
                              child: AppTextButton(
                                borderRadius: 10,
                                buttonHeight: 58.h,
                                buttonWidth: 327,
                                backgroundColor: Color(0xff101a21),
                                buttonText: S.of(context).signin,
                                textStyle: TextStyles.lato16SemiBoldLight,
                                onPressed: () async {
                                  // Check if the form is valid before proceeding
                                  if (formKey.currentState!.validate()) {
                                    // Perform login
                                    await SignInCubit.get(context).login(
                                      SignIn(
                                        phone: _phoneController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
verticalSpace(8),
                            GestureDetector(
                              onTap: (){
                                context.pushNamed(Routes.forgetPasswordEmail);
                              },
                              child: Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                                children: [Text(

                                  'forgot password?',
                                  style: TextStyles.lato15RegularLightgray,
                                ),],
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).donthaveaccount,
                                  style:
                                      ThemeCubit.get(context).themeMode ==
                                              ThemeMode.light
                                          ? TextStyles.lato16RegularhintGray
                                          : TextStyles.lato16RegularhintGray,
                                ),
                                BlocBuilder<SignUpCubit, SignUpState>(
                                  builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        final signUpCubit = SignUpCubit.get(
                                          context,
                                        ); // خده من السياق الصحيح

                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled:
                                              true, // ✅ allow full height
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          builder: (BuildContext context) {
                                            return BlocProvider.value(
                                              value:
                                                  signUpCubit, // مرره للـ BottomSheet
                                              child: DraggableScrollableSheet(
                                                expand: false,
                                                initialChildSize: 0.85,
                                                minChildSize: 0.6,
                                                maxChildSize: 0.95,
                                                builder: (
                                                  context,
                                                  scrollController,
                                                ) {
                                                  return SingleChildScrollView(
                                                    controller:
                                                        scrollController,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                          16,
                                                          16,
                                                          16,
                                                          MediaQuery.of(context)
                                                                  .viewInsets
                                                                  .bottom +
                                                              16,
                                                        ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Center(
                                                          child: Container(
                                                            width: 40,
                                                            height: 6,
                                                            decoration:
                                                                BoxDecoration(
                                                                  color: Color(
                                                                    0xFF72A850,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        3,
                                                                      ),
                                                                ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 12),

                                                        Row(
                                                          children: [
                                                            IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_back_ios_new,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                  context,
                                                                ).pop(); // Close bottom sheet
                                                              },
                                                            ),
                                                            Expanded(
                                                              child: Center(
                                                                child: Text(
                                                                  S
                                                                      .of(
                                                                        context,
                                                                      )
                                                                      .signup,
                                                                  style:
                                                                      TextStyles
                                                                          .lato28BoldGreen,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 48,
                                                            ), // To balance the back button space
                                                          ],
                                                        ),

                                                        Form(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                S
                                                                    .of(context)
                                                                    .enteryourname,
                                                                style:
                                                                    TextStyles
                                                                        .lato14RegularDark,
                                                              ),
                                                              AppTextFormField(
                                                                contentPadding:
                                                                    EdgeInsets.all(
                                                                      12.h,
                                                                    ),
                                                                hintText:
                                                                    S
                                                                        .of(
                                                                          context,
                                                                        )
                                                                        .name,
                                                                controller:
                                                                    _nameController,
                                                                validator: (
                                                                  value,
                                                                ) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return S
                                                                        .of(
                                                                          context,
                                                                        )
                                                                        .namecannotbeempty;
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              verticalSpace(16),
                                                              Text(
                                                                S
                                                                    .of(context)
                                                                    .enteryourmobilenumber,
                                                                style:
                                                                    TextStyles
                                                                        .lato14RegularDark,
                                                              ),
                                                              verticalSpace(8),
                                                              PhoneTextForm(
                                                                controller:
                                                                    _phoneController,
                                                                onChanged:
                                                                    signUpCubit
                                                                        .changeSignUpPhone,
                                                              ),

                                                              Text(
                                                                S
                                                                    .of(context)
                                                                    .enteryourpassword,
                                                                style:
                                                                    TextStyles
                                                                        .lato14RegularDark,
                                                              ),
                                                              verticalSpace(8),
                                                              AppTextFormField(
                                                                contentPadding:
                                                                    EdgeInsets.all(
                                                                      12.h,
                                                                    ),
                                                                hintText:
                                                                    S
                                                                        .of(
                                                                          context,
                                                                        )
                                                                        .email,
                                                                controller:
                                                                    _emailController,
                                                                validator: (
                                                                  value,
                                                                ) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return S
                                                                        .of(
                                                                          context,
                                                                        )
                                                                        .emailcannotbeempty;
                                                                  }
                                                                  final emailRegex =
                                                                      RegExp(
                                                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                                                      );
                                                                  if (!emailRegex
                                                                      .hasMatch(
                                                                        value,
                                                                      )) {
                                                                    return S
                                                                        .of(
                                                                          context,
                                                                        )
                                                                        .Enteravalidemailaddress;
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              verticalSpace(16),
                                                              Text(
                                                                S
                                                                    .of(context)
                                                                    .enteryourpassword,
                                                                style:
                                                                    TextStyles
                                                                        .lato14RegularDark,
                                                              ),
                                                              verticalSpace(8),
                                                              AppTextFormField(
                                                                maxLine: 1,
                                                                onFieldSubmitted: (value){
                                                                  () async {
                                                                    //context.pushNamed(Routes.navigationBar);
                                                                    if (formKey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      await signUpCubit.signUp(
                                                                        SignUp(
                                                                          name:
                                                                          _nameController.text,
                                                                          email:
                                                                          _emailController.text,
                                                                          phone:
                                                                          _phoneController.text,
                                                                          password:
                                                                          _passwordController.text,
                                                                        ),
                                                                      );
                                                                    }
                                                                  };
                                                                },
                                                                borderRadius:
                                                                    16.5,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          15.w,
                                                                      vertical:
                                                                          15.h,
                                                                    ),
                                                                controller:
                                                                    _passwordController,
                                                                hintText:
                                                                    S
                                                                        .of(
                                                                          context,
                                                                        )
                                                                        .password,
                                                                validator: (
                                                                  value,
                                                                ) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Password must not be empty';
                                                                  }
                                                                  if (value
                                                                          .length <
                                                                      6) {
                                                                    return 'Password must be at least 6 characters long';
                                                                  }
                                                                  return null;
                                                                },
                                                                suffixIcon: GestureDetector(
                                                                  onTap: () {
                                                                    signUpCubit
                                                                        .obscureText1();
                                                                  },
                                                                  child: Icon(
                                                                    signUpCubit
                                                                            .isObscureText1
                                                                        ? Icons
                                                                            .visibility_off
                                                                        : Icons
                                                                            .visibility,
                                                                  ),
                                                                ),
                                                              ),
                                                              verticalSpace(16),
                                                              Center(
                                                                child: AppTextButton(
                                                                  borderRadius:
                                                                      10,
                                                                  buttonHeight:
                                                                      58.h,
                                                                  buttonWidth:
                                                                      327,
                                                                  buttonText:
                                                                      S
                                                                          .of(
                                                                            context,
                                                                          )
                                                                          .signup,
                                                                  textStyle:
                                                                      TextStyles
                                                                          .lato16SemiBoldLight,
                                                                  onPressed: () async {
                                                                    //context.pushNamed(Routes.navigationBar);
                                                                    if (formKey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      await signUpCubit.signUp(
                                                                        SignUp(
                                                                          name:
                                                                              _nameController.text,
                                                                          email:
                                                                              _emailController.text,
                                                                          phone:
                                                                              _phoneController.text,
                                                                          password:
                                                                              _passwordController.text,
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                              SignupStateUi()

                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        S.of(context).signup,
                                        style: TextStyles.lato16BoldBlack.copyWith(
                                          // decoration: TextDecoration.underline,
                                          // decorationColor: TextStyles.lato16BoldBlack.color,
                                          //   color:Color(0xFF992232),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                    SignInStateUi()
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
