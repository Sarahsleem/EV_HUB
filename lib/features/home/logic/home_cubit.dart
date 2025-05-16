import 'package:bloc/bloc.dart';
import 'package:evhub/core/assets/images.dart';
import 'package:evhub/features/home/data/model/Ads_model.dart';
import 'package:evhub/features/home/data/model/car_brand.dart';
import 'package:evhub/features/home/data/model/car_model.dart';
import 'package:evhub/features/home/data/model/feature_model.dart';
import 'package:evhub/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  HomeRepo homeRepo;
  static HomeCubit get(context) => BlocProvider.of(context);
List<AdsModel> ads2=[];
List<AdsModel> ads1=[];
List<Brand> carBrands=[];
List<Car> cars=[];
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
Future<void> getBrands()async{
  emit(HomeLoadingBrandsState());
  var response =await homeRepo.fetchBrands();
  response.fold((l){
    emit(HomeErrorBrandsState());
  }, (r){
    carBrands=r;
    emit(HomeSuccessBrandsState());
  });

}
Future<void> getCars()async{
  emit(HomeLoadingCarsState());
  var response =await homeRepo.fetchCars();
  response.fold((l){
    emit(HomeErrorCarsState());
  }, (r){
    cars=r;
    emit(HomeSuccessCarsState());
  });

}
List<Feature> features=[
  Feature(image:ImagesManager.insurance, title: 'insurance',),
  Feature(image: ImagesManager.protection, title: 'protection', ),
  Feature(image: ImagesManager.stations, title: 'Charging stations', ),

];
}
