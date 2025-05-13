import 'package:evhub/features/otp/logic/otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/login/logic/sign_in_cubit.dart';
import '../../features/login/ui/sign_in_screen.dart';
import '../../features/onboarding/ui/onboard_screen.dart';

import '../../features/signup/logic/sign_up_cubit.dart';
import '../../features/signup/ui/screens/sign_up_screen.dart';
import '../../features/otp/ui/screen/otp_screen.dart';

import '../../features/splash/ui/screen/splash_screen.dart';
import '../di/Dependency_inj.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.onboardingScreen:
        return MaterialPageRoute(
          builder: (_) => OnBoardScreen(),
        );
      case Routes.verifyCode:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (context) => OtpCubit(),
                child: OTPScreen(),
              ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (context) => getIt<SignUpCubit>(),
                child: SignUpScreen(),
              ),
        );

      case Routes.signInScreen:
        return MaterialPageRoute(
         builder: (_) =>MultiBlocProvider(
        providers: [
         
          BlocProvider<SignUpCubit>.value(
            value: getIt<SignUpCubit>(),
          ),
          BlocProvider<SignInCubit>.value(
            value: getIt<SignInCubit>(),
          ),
        ], child: const SignInScreen()),
        );
    }

    return null;
  }
}
