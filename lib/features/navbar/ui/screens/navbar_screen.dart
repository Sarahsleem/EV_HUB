import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/nav_bar_cubit.dart';
import '../widght/navbar_container.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key? key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        return Scaffold(

          backgroundColor: Colors.white,
          body: Stack(children: [
            PageView(
              controller: NavBarCubit.get(context).pageController,

              children: NavBarCubit.get(context).screens,
              onPageChanged: (index){
                NavBarCubit.get(context).changeIndex(index);
              },
            ),
            NavBarContainer(pageController: NavBarCubit.get(context).pageController,)
          ]),
        );
      },
    );
  }
}