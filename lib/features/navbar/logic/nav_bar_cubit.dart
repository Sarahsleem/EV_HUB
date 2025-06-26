import 'package:bloc/bloc.dart';
import 'package:evhub/features/car_marketplace/logic/cubit/car_market_cubit_cubit.dart';
import 'package:evhub/features/car_marketplace/ui/screen/car_market.dart';
import 'package:evhub/features/profie/logic/profile_cubit.dart';
import 'package:evhub/features/services/logic/services_cubit.dart';
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
    MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt<HomeCubit>()
            ..loadHomeData(),
        ),
        BlocProvider.value(
          value: getIt<ServicesCubit>()..getServices(),
        ), BlocProvider.value(
          value: getIt<ProfileCubit>()..getProfile(),
        ),
      ],
      child: HomeScreen(),
    ),
    MultiBlocProvider(
      providers: [
        
          BlocProvider<HomeCubit>.value(
              value: getIt<HomeCubit>(),
            ),
         BlocProvider<CarMarketCubitCubit>.value(
              value: getIt<CarMarketCubitCubit>(),
            ),
       
      ],
      child: CarMarketScreen(),
    ),
  

  ];
  List<String> navIcon = [
    ImagesManager.homeWhite
    , ImagesManager.addGray
    , ImagesManager.carGray

  ];
  List<String> navTitle = [
    'Home'
    , 'Add'
    , 'Car'

  ];
  List<String> navIconYellow = [
    ImagesManager.homeWhite
    , ImagesManager.addGray
    , ImagesManager.carGray

  ];
  int selectedIndex = 0;
bool isOneSelected=true;
bool isTwoSelected=false;
bool isThreeSelected=false;

  void changeIndex(int index) {
    selectedIndex = index;
    if(index==0){
       isOneSelected=true;
       isTwoSelected=false;
       isThreeSelected=false;
    }
    else if(index==1){
      isOneSelected=false;
      isTwoSelected=false;
      isThreeSelected=true;
    }
    else{
      isOneSelected=false;
      isTwoSelected=false;
      isThreeSelected=true;
    }
    emit(ChangeIndexState());
  }
}
