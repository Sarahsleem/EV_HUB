import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/features/login/logic/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/show_dialog_error.dart';
import '../../../navbar/logic/nav_bar_cubit.dart';

class SignInStateUi extends StatelessWidget {
  const SignInStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit,SignInState>(
      listener: (context, state) async {
        if (state is SignInLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => PopScope(
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.kPrimaryColor,
                ),
              ),
            ),
          );
        }
        // Handle LoginSuccess state
        else if (state is SignInSuccess) {
          // NavBarCubit.get(context).changeIndex(0);
          // if (Navigator.canPop(context)) {
          //   Navigator.pop(context);
          // }
          context.pushReplacementNamed(Routes.navigationBar);
          //context.pushNamed(Routes.verifyCode);
        }

        // Handle LoginError and show the dialog here
        if (state is SignInFailed) {
          Navigator.pop(context);
          ShowDialogError.showErrorDialog(
              context,
              "attention", // Pass the "attention" title here
              'Invalid phone or password',
              'Try again'
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
