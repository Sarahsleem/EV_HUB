import 'package:bloc/bloc.dart';
import 'package:evhub/features/home/data/model/car_model.dart';
import 'package:evhub/features/my_cars/data/repo/my_cars_Repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'my_cars_state.dart';

class MyCarsCubit extends Cubit<MyCarsState> {
  MyCarsCubit(this.myCars) : super(MyCarsInitial());
  static MyCarsCubit get(context) =>BlocProvider.of(context);
  MyCars myCars;
  List<Car> myCarsList=[];
  Future<void> getCars()async{
    emit(MyCarsLoadingState());
    var result=await myCars.getCars();
    result.fold((l) => emit(MyCarsErrorState()), (r) {
      myCarsList=r;
      emit(MyCarsLoadedState());
    });
  }
  Future<void> deleteCar(int id)async{
    emit(MyCarsLoadingState());
    var result=await myCars.deleteCar(id);
    result.fold((l) => emit(MyCarsErrorState()), (r) {
      getCars();
      emit(MyCarsLoadedState());
    });
  }
}
