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
final class HomeLoadingBrandsState extends HomeState{
  final bool isBrandLoading;
  HomeLoadingBrandsState({required this.isBrandLoading});
}
class HomeSuccessBrandsState extends HomeState{
}
class HomeErrorBrandsState extends HomeState{

}
final class HomeLoadingCarsState extends HomeState{
  final bool isCarLoading;
  HomeLoadingCarsState({required this.isCarLoading});
}
class HomeSuccessCarsState extends HomeState{
}
class HomeErrorCarsState extends HomeState{}
class LoadMoreCarsState extends HomeState{}
class LoadMoreBrandsState extends HomeState{}
class LoadingHomeDataState extends HomeState{}
class FailHomeDataState extends HomeState{}
class SuccessHomeDataState extends HomeState{}
class HomeLoadingCarsByAuthorState extends HomeState {}
class HomeSuccessCarsByAuthorState extends HomeState {
  final List<Car> authorCars;
  HomeSuccessCarsByAuthorState(this.authorCars);
}
class HomeErrorCarsByAuthorState extends HomeState {
  final String message;
  HomeErrorCarsByAuthorState(this.message);
}