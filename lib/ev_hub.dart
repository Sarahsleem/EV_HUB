import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/localization/cubit/localization_cubit.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/theming_change/cubit/theme_cubit.dart';
import 'generated/l10n.dart';

class EvHubApp extends StatelessWidget {
  final AppRouter appRouter;

  const EvHubApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocalizationCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        child: BlocBuilder<LocalizationCubit, LocalizationState>(
          builder: (context, localizationState) {
            // Determine the current locale
            // Locale currentLocale;
            // if (localizationState is LocalizationChanged) {
            //   currentLocale = localizationState.locale;
            // } else {
            //   // Provide a default locale if no selection has been made
            //   currentLocale = ui.window.locale; // Default to English
            // }

            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                return MaterialApp(
                  locale: LocalizationCubit.get(context).locale,
                  //themeMode: themeState.themeMode,
                  navigatorKey: NavigationService.navigatorKey,// Use the themeMode from the ThemeCubit
                  //theme: ThemeData.light(),
                  theme: ThemeCubit.get(context).getTheme(),
                  initialRoute: Routes.homeScreen,
                  onGenerateRoute: appRouter.generateRoute,
                  supportedLocales: const [
                    Locale('en'),
                    Locale('ar'),
                  ],
                  localizationsDelegates:  [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  debugShowCheckedModeBanner: false,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}