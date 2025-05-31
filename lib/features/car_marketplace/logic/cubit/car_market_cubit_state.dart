part of 'car_market_cubit_cubit.dart';

abstract class CarMarketCubitState  {
  const CarMarketCubitState();

 
}

final class CarMarketCubitInitial extends CarMarketCubitState {}


class CarMarketInitial extends CarMarketCubitState {}

class CarMarketLoadingUsersState extends CarMarketCubitState {}

class CarMarketSuccessUsersState extends CarMarketCubitState {}

class CarMarketErrorUsersState extends CarMarketCubitState {
  final String message;
  CarMarketErrorUsersState(this.message);
}