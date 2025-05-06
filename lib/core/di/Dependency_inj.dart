import 'package:get_it/get_it.dart';

import '../networking/dio_factory.dart';


final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final dio = DioFactory.getDio();

  // Register AuthRepo and AuthCubit

}
