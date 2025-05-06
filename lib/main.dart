import 'package:flutter/material.dart';

import 'core/db/cash_helper.dart';
import 'core/di/Dependency_inj.dart';
import 'core/routing/app_router.dart';
import 'ev_hub.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  await CashHelper.init();

  runApp( EvHubApp(appRouter: AppRouter(),));
}
