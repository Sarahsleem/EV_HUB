import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/assets/images.dart';
import '../../../core/di/Dependency_inj.dart';
import '../../car_market_place/ui/car_market_place_screen.dart';
import '../../home/logic/home_cubit.dart';
import '../../home/ui/screen/home_screen.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial());
  static NavBarCubit get(context) => BlocProvider.of(context);

  PageController pageController = PageController(initialPage: 0);
  final screens = [
    BlocProvider.value(
      value: getIt<HomeCubit>(),
      child: HomeScreen(),
    ),
    Container(color: Colors.red,),
    CarMarketPlaceScreen(),

  ];
  List<String> navIcon =[
    ImagesManager.homeWhite
    ,ImagesManager.addGray
    ,ImagesManager.carGray

  ];
  List<String> navTitle =[
    'Home'
    ,'Add'
    ,'Car'

  ];
  List<String> navIconYellow =[
    ImagesManager.homeWhite
    ,ImagesManager.addGray
    ,ImagesManager.carGray

  ];
  int selectedIndex=0;
  void changeIndex(int index){
    selectedIndex=index;
    emit(ChangeIndexState());
  }
}
