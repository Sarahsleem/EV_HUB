import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'add_new_car_state.dart';

class AddNewCarCubit extends Cubit<AddNewCarState> {
  AddNewCarCubit() : super(AddNewCarInitial());
  static AddNewCarCubit get(context) => BlocProvider.of(context);
}
