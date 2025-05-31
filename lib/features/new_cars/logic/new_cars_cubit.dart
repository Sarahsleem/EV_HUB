import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:evhub/features/new_cars/data/repo/car_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../home/data/model/car_model.dart';

part 'new_cars_state.dart';

class NewCarsCubit extends Cubit<NewCarsState> {
  NewCarsCubit(this.carsRepo) : super(NewCarsInitial());
  CarsRepo carsRepo;
  static NewCarsCubit get(context) => BlocProvider.of(context);
  int selectedBrandId=9;
   chooseBrand(int id){
     selectedBrandId=id;
     emit(ChooseBrandState());
   }
  List<Car> newCars=[];
  Future<void> getNewCarsByBrand()async {
 emit(NewCarsLoadingState());
      var response= await carsRepo.fetchCarsByBrandIdFromApi(selectedBrandId,13);
  response.fold((l){
    emit(NewCarsErrorState());
  },(r){
    newCars=r;
    emit(NewCarsSuccessState());
  });

  }Future<void> getUsedCarsByBrand()async {
 emit(NewCarsLoadingState());
      var response= await carsRepo.fetchCarsByBrandIdFromApi(selectedBrandId,14);
  response.fold((l){
    emit(NewCarsErrorState());
  },(r){
    newCars=r;
    emit(NewCarsSuccessState());
  });
  }
}
