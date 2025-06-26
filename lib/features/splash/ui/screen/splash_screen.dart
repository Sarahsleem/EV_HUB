import 'package:evhub/core/assets/images.dart';
import 'package:evhub/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/db/cash_helper.dart';
import '../../../../core/networking/dio_factory.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _circleController;
  late Animation<double> _circleScaleAnimation;
  late Animation<double> _opacityAnimation;

  bool showLogo = false;

  @override
  void initState() {
    super.initState();

    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _circleScaleAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeOut),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeOut),
    );

    _circleController.forward();

    // Show logo after circle animation ends
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => showLogo = true);
    });

    // Navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () => tohome());
  }

  @override
  void dispose() {
    _circleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _circleController,
                builder: (context, child) => Transform.scale(
                  scale: _circleScaleAnimation.value,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorsManager.darkBlue,
                      ),
                    ),
                  ),
                ),
              ),
              if (showLogo)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: 1,
                  child: Image.asset(
                    ImagesManager.splash,
                    width: 300.w,
                    height: 300.h,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void tohome() async {
    String? token = await CashHelper.getStringSecured(key: Keys.token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
    if (token == '') {
      context.pushReplacementNamed(Routes.chooseCountryScreen);
    } else {
      context.pushNamed(Routes.navigationBar);
    }
  }
}

