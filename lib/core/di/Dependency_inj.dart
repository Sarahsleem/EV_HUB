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
  // Register AuthRepo and AuthCubit

}
