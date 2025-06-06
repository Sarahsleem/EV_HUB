import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:evhub/core/assets/images.dart';
import 'package:evhub/core/db/cash_helper.dart';
import 'package:evhub/features/home/data/model/Ads_model.dart';
import 'package:evhub/features/home/data/model/car_brand.dart';
import 'package:evhub/features/home/data/model/car_model.dart';
import 'package:evhub/features/home/data/model/feature_model.dart';
import 'package:evhub/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/db/cached_app.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  HomeRepo homeRepo;
  static HomeCubit get(context) => BlocProvider.of(context);
List<AdsModel> ads2=[];
List<AdsModel> ads1=[];
List<Brand> carBrands=[];
List<Car> cars=[];
  int visibleBrandsCount = 7;
  void loadMoreCars() {
    if (visibleBrandsCount < cars.length) {
      visibleBrandsCount += 4;
      emit(LoadMoreCarsState()); // Create a dummy state
    }
  }
Future<void> getAds2()async{
  emit(HomeLoadingADSState());
  var response =await homeRepo.getADS2();
  response.fold((l){
    emit(HomeErrorADSState());
  }, (r){
    ads2=r;
    emit(HomeSuccessADSState());
  });

}Future<void> getAds()async{
  emit(HomeLoadingADS1State());
  var response =await homeRepo.getADS1();
  response.fold((l){
    emit(HomeErrorAD1State());
  }, (r){
    ads1=r;
    emit(HomeSuccessADS1State());
  });

}
void loadHomeData (){
  getAds2();
  getCars().then((_) => getBrands());
  //getBrands();
  getAds();
}
  Future<void> getBrands() async {
    emit(HomeLoadingBrandsState());
    final response = await homeRepo.fetchBrands(50); // Fetch a reasonable initial amount
    response.fold(
          (l) => emit(HomeErrorBrandsState()),
          (r) {
        carBrands = r;
        visibleBrandsCount = r.length < 7 ? r.length : 7;
        emit(HomeSuccessBrandsState());
      },
    );
  }

  void loadMoreBrands() {
    print('here');
    if (visibleBrandsCount < carBrands.length) {
      emit(LoadMoreBrandsState());
      print('here2');
      // Add more items (you could also fetch more from server here)
      visibleBrandsCount = (visibleBrandsCount + 7).clamp(0, carBrands.length);
      emit(HomeSuccessBrandsState()); // Or create a specific state for loaded more
    }
  }

Future<void> getCars()async{
 try{
   cars=CachedApp.getCachedData(CachedDataType.cars.name);
 }catch(e) {
    emit(HomeLoadingCarsState());
    var response = await homeRepo.fetchCars();
    response.fold((l) {
      emit(HomeErrorCarsState());
    }, (r) {
      cars = r;
      CachedApp.saveData(cars,CachedDataType.cars.name);
      emit(HomeSuccessCarsState());
    });
  }

}
List<Feature> features=[
  Feature(image:ImagesManager.insurance, title: 'insurance',),
  Feature(image: ImagesManager.protection, title: 'protection', ),
  Feature(image: ImagesManager.stations, title: 'Charging stations', ),

];

  // void loadMoreBrands() {
  //   if (visibleBrandsCount < carBrands.length) {
  //     visibleBrandsCount = (visibleBrandsCount + 7).clamp(0, carBrands.length);
  //     getBrands(visibleBrandsCount);
  //     emit(LoadMoreBrandsState()); // trigger UI rebuild
  //   }
  // }

}
