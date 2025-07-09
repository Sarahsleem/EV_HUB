import 'package:evhub/core/db/cash_helper.dart';
import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/features/profie/logic/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/db/cached_app.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/show_dialog_error.dart';
import '../../../../generated/l10n.dart';
import '../../../navbar/logic/nav_bar_cubit.dart';

class UpdateProfileStatus extends StatelessWidget {
  const UpdateProfileStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) async {
        if (state is UpdateProfileLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder:
                (context) => PopScope(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.kPrimaryColor,
                    ),
                  ),
                ),
          );
        }
        // Handle LoginSuccess state
        else if (state is UpdateProfileSuccess) {
          CachedApp.removeFromCache(CachedDataType.profile.name);
          ProfileCubit.get(context).getProfile();
          context.pop();
          context.pop();

          ShowDialogError.showErrorDialog(
            context,
            "", // Pass the "attention" title here
            S.of(context).profileUpdatedSuccessfully,
            S.of(context).Done,
          );
          // NavBarCubit.get(context).changeIndex(0);
          // if (Navigator.canPop(context)) {
          //   Navigator.pop(context);
          // }
          //context.pushReplacementNamed(Routes.navigationBar);
          // context.pushNamed(Routes.verifyCode);
        }

        // Handle LoginError and show the dialog here
        if (state is UpdateProfileError) {
          Navigator.pop(context);
          ShowDialogError.showErrorDialog(
            context,
            S.of(context).attention, // Pass the "attention" title here
            S.of(context).somethingWentWrong,
            S.of(context).tryagain,
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
