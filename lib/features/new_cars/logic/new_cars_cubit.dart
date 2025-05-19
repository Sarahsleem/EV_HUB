import 'package:bloc/bloc.dart';
import 'package:evhub/features/new_cars/data/repo/car_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'new_cars_state.dart';

class NewCarsCubit extends Cubit<NewCarsState> {
  NewCarsCubit(this.carsRepo) : super(NewCarsInitial());
  CarsRepo carsRepo;
  static NewCarsCubit get(context) => BlocProvider.of(context);
  int selectedBrandId=0;
  Future<void> getNewCarsByBrand()async {
 emit(NewCarsLoadingState());
      var response= await carsRepo.fetchCarsByBrandIdFromApi(36);
  response.fold((l){
    emit(NewCarsErrorState());
  },(r){
    emit(NewCarsSuccessState());
  });
  }
}
