import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/features/forget_password/logic/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/snak_bar.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/show_dialog_error.dart';
import '../../../navbar/logic/nav_bar_cubit.dart';

class SendEmailStateUi extends StatelessWidget {
  const SendEmailStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) async {
        if (state is LoadingSendEmail) {
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
        else if (state is SuccesSendEmail) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          //context.pushReplacementNamed(Routes.navigationBar);
          context.pushNamed(Routes.forgetPasswordOTP,arguments: state.email);
          showSnackBar(context: context, text: state.msg);

        }

        // Handle LoginError and show the dialog here
        if (state is ErrorSendEmail) {
          Navigator.pop(context);
          // ShowDialogError.showErrorDialog(
          //     context,
          //     "attention", // Pass the "attention" title here
          //     'some thing went wrong '
          // );
          showSnackBar(context: context, text: state.error.message!);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
