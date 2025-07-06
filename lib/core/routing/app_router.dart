import 'package:evhub/features/add_services/ui/screen/chose_service.dart';
import 'package:evhub/features/car_details/data/user_model.dart';
import 'package:evhub/features/edit_car/logic/edit_car_cubit.dart';
import 'package:evhub/features/add_services/ui/screen/add_services_screen.dart';
import 'package:evhub/features/car_details/ui/sceen/car_details.dart';
import 'package:evhub/features/car_marketplace/logic/cubit/car_market_cubit_cubit.dart';
import 'package:evhub/features/car_marketplace/ui/screen/car_market.dart';
import 'package:evhub/features/forget_password/ui/screen/forget_password_reset.dart';
import 'package:evhub/features/home/data/model/company_model.dart';
import 'package:evhub/features/my_cars/logic/my_cars_cubit.dart';
import 'package:evhub/features/my_cars/ui/my_car_screen.dart';
import 'package:evhub/features/home/data/model/car_model.dart';
import 'package:evhub/features/new_cars/logic/new_cars_cubit.dart';
import 'package:evhub/features/new_cars/ui/screens/new_cars_screen.dart';
import 'package:evhub/features/otp/logic/otp_cubit.dart';
import 'package:evhub/features/posts/logic/posts_cubit.dart';
import 'package:evhub/features/profie/logic/profile_cubit.dart';
import 'package:evhub/features/search/ui/search_result.dart';
import 'package:evhub/features/services/logic/services_cubit.dart';
import 'package:evhub/features/services/ui/screen/service_list_details_screen.dart';
import 'package:evhub/features/setting/logic/setting_cubit.dart';
import 'package:evhub/features/setting/ui/setting_screen.dart';
import 'package:evhub/features/showroom/ui/showroom_screen.dart';
import 'package:evhub/features/wish_list/logic/wish_list_cubit.dart';
import 'package:evhub/features/stations_map/ui/station_finder_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/add_new_car/logic/add_new_car_cubit.dart';
import '../../features/add_new_car/ui/screens/add_car_details_screen.dart';
import '../../features/add_new_car/ui/screens/choose_brand_screen.dart';
import '../../features/car_details/ui/sceen/car_owner_profile.dart';
import '../../features/edit_car/ui/edit_car_page.dart';
import '../../features/forget_password/logic/forget_password_cubit.dart';
import '../../features/forget_password/ui/screen/forget_password_email.dart';
import '../../features/forget_password/ui/screen/forget_password_otp.dart';
import '../../features/home/logic/home_cubit.dart';
import '../../features/home/ui/screen/all_cars_screen.dart';
import '../../features/home/ui/screen/car_brands_screen.dart';
import '../../features/home/ui/screen/home_screen.dart';
import '../../features/home/ui/screen/qfa_screen.dart';
import '../../features/navbar/logic/nav_bar_cubit.dart';
import '../../features/navbar/ui/screens/navbar_screen.dart';
import '../../features/login/logic/sign_in_cubit.dart';
import '../../features/login/ui/sign_in_screen.dart';
import '../../features/onboarding/ui/onboard_screen.dart';

import '../../features/posts/data/model/post_model.dart';
import '../../features/posts/ui/screen/post_details.dart';
import '../../features/posts/ui/screen/posts_ui.dart';
import '../../features/profie/ui/screen/profile_screen.dart';
import '../../features/search/logic/search_cubit.dart';
import '../../features/search/ui/search_screen.dart';
import '../../features/services/ui/screen/all_service.dart';
import '../../features/services/ui/screen/one_service_details.dart';
import '../../features/setting/ui/reset_password.dart';
import '../../features/signup/logic/sign_up_cubit.dart';
import '../../features/signup/ui/screens/sign_up_screen.dart';
import '../../features/otp/ui/screen/otp_screen.dart';

import '../../features/splash/ui/screen/choose_country.dart';
import '../../features/splash/ui/screen/splash_screen.dart';
import '../../features/used_cars/ui/screen/used_car.dart';
import '../../features/wish_list/ui/screan/wishlist_screen.dart';
import '../di/Dependency_inj.dart';
import '../widgets/web_page_view.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => OnBoardScreen());
      case Routes.chooseCountryScreen:
        return MaterialPageRoute(builder: (_) => ChooseCountry());

      case Routes.verifyCode:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<OtpCubit>(),
                child: OTPScreen(),
              ),
        );
      case Routes.navigationBar:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<NavBarCubit>(),
                child: NavBarScreen(),
              ),
        );
      case Routes.qfaScreen:
        return MaterialPageRoute(builder: (_) => const HelpFaqScreen());
      case Routes.settingsScreen:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case Routes.stationsScreen:
        return MaterialPageRoute(builder: (_) => EVStationFinder());
      case Routes.carDetails:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<HomeCubit>(),
                child: CarScreen(data: settings.arguments as Car),
              ),
        );
      case Routes.carOwnerProfile:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
  providers: [
    BlocProvider.value(
                value: getIt<HomeCubit>(),
),
    BlocProvider.value(
      value: getIt<WishListCubit>(),
    ),
  ],
  child: CarOwnerProfile(
                  userModel: settings.arguments as UserModel,
                ),
),
        );
      case Routes.showroom:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: getIt<HomeCubit>()),
                  BlocProvider.value(value: getIt<WishListCubit>()),
                ],
                child: ShowroomScreen(
                  company: settings.arguments as CompanyModel,
                ),
              ),
        );
      case Routes.resetPassword:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<SettingCubit>(),
                child: ResetPasswordScreen(),
              ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: getIt<HomeCubit>()),
                  BlocProvider.value(value: getIt<ProfileCubit>()),
                  BlocProvider.value(value: getIt<ServicesCubit>()),
                  BlocProvider.value(value: getIt<WishListCubit>()),
                ],
                child: HomeScreen(),
              ),
        );
      case Routes.carsScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: getIt<HomeCubit>()),
                  BlocProvider.value(value: getIt<WishListCubit>()),
                ],
                child: AllCarsScreen(cars: settings.arguments as List<Car>),
              ),
        );
      case Routes.webPage:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<HomeCubit>(),
                child: WebViewPage(url: settings.arguments as String),
              ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<SignUpCubit>(),
                child: SignUpScreen(),
              ),
        );
      case Routes.forgetPasswordEmail:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<ForgetPasswordCubit>(),
                child: ForgetPasswordEmail(),
              ),
        );
      case Routes.forgetPasswordOTP:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<ForgetPasswordCubit>(),
                child: ForgetPasswordOTP(email: settings.arguments as String),
              ),
        );
      case Routes.allService:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<ServicesCubit>(),
                child: AllService(),
              ),
        );
      case Routes.chooseservice:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<ServicesCubit>(),
                child: ChooseService(),
              ),
        );
      case Routes.serviceListDetails:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<ServicesCubit>(),
                child: ServiceListDtailsScreen(
                  type: settings.arguments as String,
                ),
              ),
        );
      case Routes.oneServiceDetails:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<ServicesCubit>(),
                child: ServiceDetailScreen(data: settings.arguments as dynamic),
              ),
        );
      case Routes.searchFilter:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: getIt<SearchCubit>()),
                  BlocProvider.value(value: getIt<HomeCubit>()),
                ],
                child: SearchScreen(),
              ),
        );
      case Routes.searchResult:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: getIt<SearchCubit>()),
                  BlocProvider.value(value: getIt<WishListCubit>()),
                ],
                child: SearchResultScreen(
                  carsResult: settings.arguments as List<Car>,
                ),
              ),
        );
      case Routes.carBrandScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: getIt<HomeCubit>()),
                  BlocProvider.value(value: getIt<WishListCubit>()),
                ],
                child: CarBrandScreen(carsResult: settings.arguments as String),
              ),
        );
      case Routes.favouriteResult:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<WishListCubit>(),
                child: WishListScreen(),
              ),
        );
      case Routes.postsScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<PostsCubit>(),
                child: PostsUi(),
              ),
        );
      case Routes.postsDetailsScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: getIt<PostsCubit>()),
                  BlocProvider.value(value: getIt<ServicesCubit>()),
                ],
                child: PostDetails(postModel: settings.arguments as PostModel),
              ),
        );
      case Routes.addNewChooseBrand:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: getIt<AddNewCarCubit>()),
                  BlocProvider.value(value: getIt<HomeCubit>()),
                ],
                child: ChooseBrand(),
              ),
        );
      case Routes.addNewCarDtails:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: getIt<AddNewCarCubit>()),
                  BlocProvider.value(value: getIt<HomeCubit>()),
                ],
                child: AddCarDetails(),
              ),
        );
      case Routes.editNewCarDtails:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: getIt<EditCarCubit>()),
                  BlocProvider.value(value: getIt<HomeCubit>()),
                ],
                child: EditCarPage(car: settings.arguments as Car),
              ),
        );
      case Routes.forgetPasswordReset:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<ForgetPasswordCubit>(),
                child: ForgetPasswordReset(email: settings.arguments as String),
              ),
        );
      case Routes.newCars:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: getIt<NewCarsCubit>()),
                  BlocProvider.value(value: getIt<HomeCubit>()),
                  BlocProvider.value(value: getIt<WishListCubit>()),
                ],
                child: NewCarScreen(brandId: settings.arguments as int),
              ),
        );
      case Routes.usedCars:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: getIt<NewCarsCubit>()),
                  BlocProvider.value(value: getIt<HomeCubit>()),
                  BlocProvider.value(value: getIt<WishListCubit>()),
                ],
                child: UsedCarScreen(brandId: settings.arguments as int),
              ),
        );
      case Routes.myCarsScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<MyCarsCubit>(),
                child: MyCars(),
              ),
        );
      case Routes.addServices:
        final args = settings.arguments as AddServiceArguments;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<ServicesCubit>(),
                child: AddNewServiceScreen(icon: args.icon, title: args.title),
              ),
        );

      case Routes.profile:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<ProfileCubit>(),
                child: ProfileScreen(),
              ),
        );
      case Routes.signInScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<SignUpCubit>.value(value: getIt<SignUpCubit>()),
                  BlocProvider<SignInCubit>.value(value: getIt<SignInCubit>()),
                ],
                child: const SignInScreen(),
              ),
        );
    }

    return null;
  }
}
