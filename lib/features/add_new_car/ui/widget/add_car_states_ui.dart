import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/features/add_new_car/logic/add_new_car_cubit.dart';
import 'package:evhub/features/forget_password/logic/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/snak_bar.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/show_dialog_error.dart';
import '../../../../generated/l10n.dart';
import '../../../navbar/logic/nav_bar_cubit.dart';

class AddCarStatesUi extends StatelessWidget {
  const AddCarStatesUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddNewCarCubit, AddNewCarState>(
      listener: (context, state) async {
        if (state is PostCarLoading) {
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
        else if (state is PostCarSuccess) {
          if (Navigator.canPop(context)) {
            context.pop();
          }
          context.pop();
          context.pop();
          context.pushNamed(Routes.myCarsScreen);
          ShowDialogError.showErrorDialog(
              context,
              "", // Pass the "attention" title here
              S.of(context).yourCarAddedInReviewSuccessfully,
             S.of(context).Done
          );
          //context.pushReplacementNamed(Routes.navigationBar);
          //context.pushNamed(Routes.forgetPasswordOTP,arguments: state.email);
         // showSnackBar(context: context, text: 'your car added  inReview successfully');

        }

        // Handle LoginError and show the dialog here
        if (state is PostCarFailare) {
         context.pop();
          ShowDialogError.showErrorDialog(
              context,
              "attention", // Pass the "attention" title here
              S.of(context).somethingWentWrong,
            S.of(context).tryagain
          );
          showSnackBar(context: context, text: S.of(context).somethingWentWrong);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
