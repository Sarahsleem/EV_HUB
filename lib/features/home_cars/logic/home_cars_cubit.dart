import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_cars_state.dart';

class HomeCarsCubit extends Cubit<HomeCarsState> {
  HomeCarsCubit() : super(HomeCarsInitial());
}
