import 'package:evhub/core/assets/images.dart';
import 'package:evhub/core/helpers/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/db/cash_helper.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    tohome();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: Image.asset(
                  ImagesManager.splash,
                ))),
      ),
    );
  }

  void tohome() {
    Future.delayed(const Duration(seconds: 2), () async {
      WidgetsFlutterBinding.ensureInitialized();
      String? token = await CashHelper.getStringSecured(key: Keys.token);
      // print(token);
      context.pushReplacementNamed(Routes.onboardingScreen);
      //  DioFactory.setTokenIntoHeaderAfterLogin(response.token!);
      // if(  token == null){
      //   context.pushReplacementNamed(Routes.welcome);
      // }else{
      // if(await SplashCubit.get(context).checkToken(token)){
      //   DioFactory.setTokenIntoHeaderAfterLogin(token);
      //   context.pushReplacementNamed(Routes.navigationBar);
      // }else{
      //   await CashHelper.clear();
      //   context.pushReplacementNamed(Routes.welcome);
      // }
      //   .then((value) {
      // if (value) {
      //   context.pushReplacementNamed(Routes.welcome);
      // }
      // });

      // }


    });
  }
}
