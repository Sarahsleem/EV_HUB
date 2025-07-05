import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/show_dialog_error.dart';

import '../logic/search_cubit.dart';

class SearchStateUi extends StatelessWidget {
  const SearchStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCubit, SearchState>(
      listener: (context, state) async {
        if (state is SearchLoading) {
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
        else if (state is SearchSuccess) {
          // NavBarCubit.get(context).changeIndex(0);
          if (Navigator.canPop(context)) {
            context.pop();
          }
          //context.pushReplacementNamed(Routes.navigationBar);

          context.pushNamed(Routes.searchResult,arguments: state.cars);
        }

        // Handle LoginError and show the dialog here
        if (state is SearchFailure) {
          print(state.error);
          Navigator.pop(context);
          ShowDialogError.showErrorDialog(
              context,
              "attention", // Pass the "attention" title here
              'some thing went wrong ',
                  'Try again'
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
