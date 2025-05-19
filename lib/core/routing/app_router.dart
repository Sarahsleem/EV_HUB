import 'package:evhub/features/new_cars/logic/new_cars_cubit.dart';
import 'package:evhub/features/new_cars/ui/screens/new_cars_screen.dart';
import 'package:evhub/features/otp/logic/otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/logic/home_cubit.dart';
import '../../features/home/ui/screen/home_screen.dart';
import '../../features/navbar/logic/nav_bar_cubit.dart';
import '../../features/navbar/ui/screens/navbar_screen.dart';
import '../../features/login/logic/sign_in_cubit.dart';
import '../../features/login/ui/sign_in_screen.dart';
import '../../features/onboarding/ui/onboard_screen.dart';

import '../../features/signup/logic/sign_up_cubit.dart';
import '../../features/signup/ui/screens/sign_up_screen.dart';
import '../../features/otp/ui/screen/otp_screen.dart';

import '../../features/splash/ui/screen/splash_screen.dart';
import '../di/Dependency_inj.dart';
import '../widgets/web_page_view.dart';
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
                create: (context) => getIt<OtpCubit>(),
                child: OTPScreen(),
              ),
        );
      case Routes.navigationBar:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(
                value: getIt<NavBarCubit>(),
                child: NavBarScreen(),
              ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(
                value: getIt<HomeCubit>(),
                child: HomeScreen(),
              ),
        );
      case Routes.webPage:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(
                value: getIt<HomeCubit>(),
                child: WebViewPage(url: settings.arguments as String),
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
      case Routes.newCars:
        return MaterialPageRoute(
          builder: (_) =>
              MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: getIt< NewCarsCubit>(),
                  ),
                  BlocProvider.value(
                    value: getIt<HomeCubit>(),                  ),
                ],
                child: NewCarScreen(),
              ),
        );
      case Routes.signInScreen:
        return MaterialPageRoute(
          builder: (_) =>
              MultiBlocProvider(
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
