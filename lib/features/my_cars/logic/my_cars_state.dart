part of 'my_cars_cubit.dart';

@immutable
abstract class MyCarsState {}

class MyCarsInitial extends MyCarsState {}
class MyCarsLoadingState extends MyCarsState{}class MyCarsLoadedState extends MyCarsState{}class MyCarsErrorState extends MyCarsState{}