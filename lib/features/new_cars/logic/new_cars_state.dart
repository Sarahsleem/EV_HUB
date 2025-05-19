part of 'new_cars_cubit.dart';

@immutable
abstract class NewCarsState {}

class NewCarsInitial extends NewCarsState {}
class NewCarsLoadingState extends NewCarsState{}
class NewCarsErrorState extends NewCarsState{}
class NewCarsSuccessState extends NewCarsState{}
