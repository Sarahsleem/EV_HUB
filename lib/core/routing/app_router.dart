import 'package:evhub/features/forget_password/ui/screen/forget_password_reset.dart';
import 'package:evhub/features/new_cars/logic/new_cars_cubit.dart';
import 'package:evhub/features/new_cars/ui/screens/new_cars_screen.dart';
import 'package:evhub/features/otp/logic/otp_cubit.dart';
import 'package:evhub/features/services/logic/services_cubit.dart';
import 'package:evhub/features/services/ui/screen/service_list_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/add_new_car/logic/add_new_car_cubit.dart';
import '../../features/add_new_car/ui/screens/add_car_details_screen.dart';
import '../../features/add_new_car/ui/screens/choose_brand_screen.dart';
import '../../features/forget_password/logic/forget_password_cubit.dart';
import '../../features/forget_password/ui/screen/forget_password_email.dart';
import '../../features/forget_password/ui/screen/forget_password_otp.dart';
import '../../features/home/logic/home_cubit.dart';
import '../../features/home/ui/screen/home_screen.dart';
import '../../features/navbar/logic/nav_bar_cubit.dart';
import '../../features/navbar/ui/screens/navbar_screen.dart';
import '../../features/login/logic/sign_in_cubit.dart';
import '../../features/login/ui/sign_in_screen.dart';
import '../../features/onboarding/ui/onboard_screen.dart';

import '../../features/services/ui/screen/all_service.dart';
import '../../features/signup/logic/sign_up_cubit.dart';
import '../../features/signup/ui/screens/sign_up_screen.dart';
import '../../features/otp/ui/screen/otp_screen.dart';

import '../../features/splash/ui/screen/splash_screen.dart';
import '../../features/used_cars/ui/screen/used_car.dart';
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
      case Routes.forgetPasswordEmail:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (context) => getIt<ForgetPasswordCubit>(),
                child: ForgetPasswordEmail(),
              ),
        );
      case Routes.forgetPasswordOTP:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (context) => getIt<ForgetPasswordCubit>(),
                child: ForgetPasswordOTP(email: settings.arguments as String,),
              ),
        );
        case Routes.allService:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(
                value:  getIt<ServicesCubit>(),
                child: AllService(),
              ),
        );
        case Routes.serviceListDetails:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(
                value:  getIt<ServicesCubit>(),
                child: ServiceListDtailsScreen(type:settings.arguments as String,),
              ),
        );
      case Routes.addNewChooseBrand:
        return MaterialPageRoute(
          builder: (_) =>
              MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value:  getIt<AddNewCarCubit>(),
                  ),
                  BlocProvider.value(
                    value: getIt<HomeCubit>(),
                  ),
                ],
                child: ChooseBrand(),
              ),
        );
        case Routes.addNewCarDtails:
        return MaterialPageRoute(
          builder: (_) =>
              MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value:  getIt<AddNewCarCubit>(),
                  ),
                  BlocProvider.value(
                    value: getIt<HomeCubit>(),
                  ),
                ],
                child: AddCarDetails(),
              ),
        );
      case Routes.forgetPasswordReset:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (context) => getIt<ForgetPasswordCubit>(),
                child: ForgetPasswordReset(
                  email: settings.arguments as String,),
              ),
        );
      case Routes.newCars:
        return MaterialPageRoute(
          builder: (_) =>
              MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: getIt<NewCarsCubit>(),
                  ),
                  BlocProvider.value(
                    value: getIt<HomeCubit>(),),
                ],
                child: NewCarScreen(),
              ),
        );
      case Routes.usedCars:
        return MaterialPageRoute(
          builder: (_) =>
              MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: getIt<NewCarsCubit>(),
                  ),
                  BlocProvider.value(
                    value: getIt<HomeCubit>(),),
                ],
                child: UsedCarScreen(),
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
