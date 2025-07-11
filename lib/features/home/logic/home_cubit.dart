import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:evhub/core/assets/images.dart';
import 'package:evhub/core/db/cash_helper.dart';
import 'package:evhub/ev_hub.dart';
import 'package:evhub/features/car_details/data/user_model.dart';
import 'package:evhub/features/home/data/model/Ads_model.dart';
import 'package:evhub/features/home/data/model/car_brand.dart';
import 'package:evhub/features/home/data/model/car_model.dart';
import 'package:evhub/features/home/data/model/feature_model.dart';
import 'package:evhub/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/db/cached_app.dart';
import '../../../generated/l10n.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  HomeRepo homeRepo;
  static HomeCubit get(context) => BlocProvider.of(context);
List<AdsModel> ads2=[];
List<AdsModel> ads1=[];
List<Brand> carBrands=[];
List<Car> cars=[];
List<Car> authorCars=[];
  int visibleBrandsCount = 7;
  void loadMoreCars() {
    if (visibleBrandsCount < cars.length) {
      visibleBrandsCount += 4;
      emit(LoadMoreCarsState()); // Create a dummy state
    }
  }

   Future<void> getCarsByAuthor(int authorId) async {
    emit(HomeLoadingCarsByAuthorState());
    try {
      final carsList = await homeRepo.fetchCarsByAuthor(authorId);
      emit(HomeSuccessCarsByAuthorState(carsList));
    } catch (e) {
      emit(HomeErrorCarsByAuthorState(e.toString()));
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

  Future<UserModel?> fetchUserById(int userId) async {
    try {
      Dio dio = Dio();
      final response = await dio.get("https://evhubtl.com/wp-json/wp/v2/users/$userId");

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch user: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching user: $error");
      return null;
    }
  }
void loadHomeData (){
    emit(LoadingHomeDataState());
   try {
      getAds2();
      getCars().then((_) => getBrands());
      //getBrands();
      getAds();
      emit(SuccessHomeDataState());
    }catch(e){
     emit(FailHomeDataState());
   }
}
  Future<void> getBrands() async {
    try{
      carBrands=CachedApp.getCachedData(CachedDataType.brands.name);
      print('bbb $carBrands');
    }catch(e) {
      emit(HomeLoadingBrandsState(isBrandLoading: true));
      final response = await homeRepo.fetchBrands(
          25); // Fetch a reasonable initial amount
      response.fold(
            (l)  {print(l); emit(HomeErrorBrandsState());},
            (r) {
          carBrands = r;
          CachedApp.saveData(carBrands,CachedDataType.brands.name);

          emit(HomeLoadingBrandsState(isBrandLoading: false));
          emit(HomeSuccessBrandsState());
        },
      );
    }
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
    emit(HomeLoadingCarsState(isCarLoading: true));
    var response = await homeRepo.fetchCars();
    response.fold((l) {
      emit(HomeErrorCarsState());
    }, (r) {
      cars = r;
      CachedApp.saveData(cars,CachedDataType.cars.name);
      emit(HomeLoadingCarsState(isCarLoading: false));
      emit(HomeSuccessCarsState());
    });
  }

}
  final List<String> sortOptions = [S.of(NavigationService.navigatorKey.currentContext!).MaxPrice,S.of(NavigationService.navigatorKey.currentContext!).MinPrice, S.of(NavigationService.navigatorKey.currentContext!).LastArrived];
  String selectedSort = S.of(NavigationService.navigatorKey.currentContext!).MaxPrice;
  void sortBy(String sort) {
    if (carsByBrand.isEmpty) return;

    switch (sort) {
      case 'Max Price'||'أعلى سعر':
        carsByBrand
            .sort((a, b) => (b.acf?['price'] ?? 0).compareTo(a.acf?['price'] ?? 0));
        emit(SortByMaxPrice());
        break;

      case 'Min Price'||'أقل سعر':
        carsByBrand.sort((a, b) => (a.acf?['price'] ?? 0).compareTo(b.acf?['price'] ?? 0));
        emit(SortByMinPrice());
        break;

      case 'Last Arrived'||'آخر الإضافات':
        carsByBrand.sort((a, b) => (b.date ?? '').compareTo(a.date ?? ''));
        emit(SortByLastArrived());
        break;
    }
  }
List<Feature> features=[
  Feature(image:ImagesManager.insurance, title: S.of(NavigationService.navigatorKey.currentContext!).insurance, route: 'Insurance',),
  Feature(image: ImagesManager.protection, title:  S.of(NavigationService.navigatorKey.currentContext!).protection, route:'Car Protection Film', ),
  Feature(image: ImagesManager.stations, title:  S.of(NavigationService.navigatorKey.currentContext!).Chargingstations, route:'', ),

];
  List<Car>carsByBrand=[];

  int selectedBrandId=0;

  chooseBrand(int id){
    selectedBrandId=id;

    emit(ChooseBrandState());
  }
  Future<void> getCarsByBrands(String selectedBrand) async {
    emit(CarByBrandLoading());

    final cars = await homeRepo.searchCars(
      brandName: selectedBrand.isNotEmpty ? selectedBrand : null,

    );
    cars.fold((l){ emit(CarByBrandFailure());}, (cars) {
      carsByBrand=cars;
      emit(CarByBrandSuccess());
    });


  }
  // void loadMoreBrands() {
  //   if (visibleBrandsCount < carBrands.length) {
  //     visibleBrandsCount = (visibleBrandsCount + 7).clamp(0, carBrands.length);
  //     getBrands(visibleBrandsCount);
  //     emit(LoadMoreBrandsState()); // trigger UI rebuild
  //   }
  // }

}
