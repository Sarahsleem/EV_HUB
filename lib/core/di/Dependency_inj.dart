import 'package:evhub/features/add_new_car/data/repo/add_car_repo.dart';
import 'package:evhub/features/add_new_car/logic/add_new_car_cubit.dart';
import 'package:evhub/features/edit_car/data/repo/edit_car_repo.dart';
import 'package:evhub/features/edit_car/logic/edit_car_cubit.dart';
import 'package:evhub/features/car_marketplace/logic/cubit/car_market_cubit_cubit.dart';
import 'package:evhub/features/home/data/repo/home_repo.dart';
import 'package:evhub/features/home/logic/home_cubit.dart';
import 'package:evhub/features/my_cars/data/repo/my_cars_Repo.dart';
import 'package:evhub/features/my_cars/logic/my_cars_cubit.dart';
import 'package:evhub/features/navbar/logic/nav_bar_cubit.dart';
import 'package:evhub/features/new_cars/data/repo/car_repo.dart';
import 'package:evhub/features/new_cars/logic/new_cars_cubit.dart';
import 'package:evhub/features/otp/data/repo/otp_repo.dart';
import 'package:evhub/features/otp/logic/otp_cubit.dart';
import 'package:evhub/features/profie/data/repo/profile_repo.dart';
import 'package:evhub/features/profie/logic/profile_cubit.dart';
import 'package:evhub/features/search/data/repo/search_repo.dart';
import 'package:evhub/features/search/logic/search_cubit.dart';
import 'package:evhub/features/services/data/repo/services_repo.dart';
import 'package:evhub/features/wish_list/data/repo/wishlist_repo.dart';
import 'package:evhub/features/wish_list/logic/wish_list_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/forget_password/data/repo/forget_password_repo.dart';
import '../../features/forget_password/logic/forget_password_cubit.dart';
import '../../features/login/data/repo/sign_in_repo.dart';
import '../../features/login/logic/sign_in_cubit.dart';
import '../../features/services/logic/services_cubit.dart';
import '../../features/signup/data/repo/sign_up_repo.dart';
import '../../features/signup/logic/sign_up_cubit.dart';
import '../networking/dio_factory.dart';


final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final dio = DioFactory.getDio();
  getIt.registerFactory<SignUpRepo>(() => (SignUpRepo(dio)));
  getIt.registerFactory<SignUpCubit>(() => (SignUpCubit(getIt())));

  getIt.registerFactory<SignInRepo>(() => (SignInRepo(dio)));
  getIt.registerFactory<SignInCubit>(() => (SignInCubit(getIt())));
  // Register AuthRepo and AuthC
  getIt.registerLazySingleton<OtpCubit>(() => OtpCubit(getIt()));
  getIt.registerFactory<OTPRepo>(()=>OTPRepo(dio: dio));
  getIt.registerLazySingleton<NavBarCubit>(() => NavBarCubit());
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit(getIt()));
  getIt.registerFactory<HomeRepo>(()=>HomeRepo( dio));
  getIt.registerLazySingleton<NewCarsCubit>(() => NewCarsCubit(getIt()));
  getIt.registerFactory<CarsRepo>(()=>CarsRepo( dio));
  getIt.registerLazySingleton<AddNewCarCubit>(() => AddNewCarCubit(getIt()));
  getIt.registerFactory<AddCarRepo>(()=>AddCarRepo( dio));
  getIt.registerFactory<ForgetPasswordCubit>(() => ForgetPasswordCubit(getIt()));
  getIt.registerFactory<ForgetPasswordRepo>(()=>ForgetPasswordRepo( dio));
  getIt.registerLazySingleton<ServicesCubit>(() => ServicesCubit(getIt()));
  getIt.registerFactory<Services>(()=>Services( dio));
  getIt.registerLazySingleton<WishListCubit>(() => WishListCubit(getIt()));
  getIt.registerFactory<WishListRepo>(()=>WishListRepo( dio));
  getIt.registerLazySingleton<MyCarsCubit>(() => MyCarsCubit(getIt()));
  getIt.registerFactory<MyCars>(()=>MyCars( dio));
  getIt.registerLazySingleton<EditCarCubit>(() => EditCarCubit(getIt()));
  getIt.registerFactory<EditCarRepo>(()=>EditCarRepo( dio));
  getIt.registerLazySingleton<SearchCubit>(() => SearchCubit(getIt()));
  getIt.registerFactory<SearchRepo>(()=>SearchRepo(  dio: dio));
  getIt.registerLazySingleton<ProfileCubit>(() => ProfileCubit(getIt()));
  getIt.registerFactory<ProfileRepo>(()=>ProfileRepo( dio));

getIt.registerLazySingleton<CarMarketCubitCubit>(() => CarMarketCubitCubit(getIt()));
}
