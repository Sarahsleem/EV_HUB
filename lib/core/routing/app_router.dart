import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    switch (settings.name) {
      // case Routes.splashScreen1:
      //   return MaterialPageRoute(
      //     builder: (_) => const SplashScreen1(),
      //   );
    }
    return null;
  }
}
