import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:flutter/material.dart';

class CarMarketPlaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(child: Center(child: Text('newCar')), onTap: () {context.pushNamed(Routes.newCars);}),
          ],
        ),
      ),
    );
  }
}
