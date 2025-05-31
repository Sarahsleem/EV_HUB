import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/show_dialog_error.dart';
import '../../../navbar/logic/nav_bar_cubit.dart';
import '../../logic/sign_up_cubit.dart';

class SignupStateUi extends StatelessWidget {
  const SignupStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) async {
        if (state is SignUpLoading) {
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
        else if (state is SignUpSuccess) {
          // NavBarCubit.get(context).changeIndex(0);
          // if (Navigator.canPop(context)) {
          //   Navigator.pop(context);
          // }
          //context.pushReplacementNamed(Routes.navigationBar);
          context.pushNamed(Routes.verifyCode);
        }

        // Handle LoginError and show the dialog here
        if (state is SignUpFailed) {
          Navigator.pop(context);
          ShowDialogError.showErrorDialog(
              context,
              "attention", // Pass the "attention" title here
              'some thing went wrong '
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
