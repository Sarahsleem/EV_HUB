part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoadingADSState extends HomeState{}
class HomeSuccessADSState extends HomeState{
}
class HomeErrorADSState extends HomeState{}