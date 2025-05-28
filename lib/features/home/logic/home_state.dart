part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoadingADSState extends HomeState{}
class HomeSuccessADSState extends HomeState{
}
class HomeErrorADSState extends HomeState{}
class HomeLoadingADS1State extends HomeState{}
class HomeSuccessADS1State extends HomeState{
}
class HomeErrorAD1State extends HomeState{}
class HomeLoadingBrandsState extends HomeState{}
class HomeSuccessBrandsState extends HomeState{
}
class HomeErrorBrandsState extends HomeState{}
class HomeLoadingCarsState extends HomeState{}
class HomeSuccessCarsState extends HomeState{
}
class HomeErrorCarsState extends HomeState{}
class LoadMoreCarsState extends HomeState{}
class LoadMoreBrandsState extends HomeState{}