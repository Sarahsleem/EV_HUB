import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:evhub/features/setting/logic/setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/show_dialog_error.dart';
import '../../../../generated/l10n.dart';
import '../../../navbar/logic/nav_bar_cubit.dart';

class ResetPasswordStatusUi extends StatelessWidget {
  const ResetPasswordStatusUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingCubit, SettingState>(
      listener: (context, state) async {
        if (state is ChangePasswordLoadingState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const PopScope(
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.kPrimaryColor,
                ),
              ),
            ),
          );
        }

        // ✅ Show success dialog with two options
        else if (state is ChangePasswordSuccessState) {
          context.pop(); // Remove loading dialog

          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(S.of(context).Success,style: TextStyles.font14WhiteRegular),
              content: Text(S.of(context).passwordChangedSuccessfully,style: TextStyles.font12WhiteRegular),
              actions: [
                TextButton(
                  onPressed: () {
                    // Navigate to login screen
                    context.pushNamedAndRemoveUntil(
                      Routes.signInScreen,
                          predicate: (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(S.of(context).login,style: TextStyles.font12WhiteRegular),
                ),
                TextButton(
                  onPressed: () {
                   context.pop();  context.pop();
                   // Close the dialog
                  },
                  child: Text(S.of(context).continueText,style: TextStyles.font12WhiteRegular,),
                ),
              ],
            ),
          );
        }

        // ❌ Handle error state
        if (state is ChangePasswordErrorState) {
          context.pop(); // Remove loading dialog if present
          ShowDialogError.showErrorDialog(
            context,
            S.of(context).attention,
            S.of(context).somethingWentWrong,
            S.of(context).tryagain,
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}

