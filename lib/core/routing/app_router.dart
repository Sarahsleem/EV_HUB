import 'package:evhub/features/otp/logic/otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/onboarding/ui/onboard_screen.dart';
import '../../features/otp/ui/screen/otp_screen.dart';
import '../../features/splash/ui/screen/splash_screen.dart';
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
    }
    return null;
  }
}
