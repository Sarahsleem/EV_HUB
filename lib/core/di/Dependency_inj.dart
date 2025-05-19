import 'package:evhub/features/home/data/repo/home_repo.dart';
import 'package:evhub/features/home/logic/home_cubit.dart';
import 'package:evhub/features/navbar/logic/nav_bar_cubit.dart';
import 'package:evhub/features/new_cars/data/repo/car_repo.dart';
import 'package:evhub/features/new_cars/logic/new_cars_cubit.dart';
import 'package:evhub/features/otp/data/repo/otp_repo.dart';
import 'package:evhub/features/otp/logic/otp_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/login/data/repo/sign_in_repo.dart';
import '../../features/login/logic/sign_in_cubit.dart';
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
}
