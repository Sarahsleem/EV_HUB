part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Car> cars;
  SearchSuccess(this.cars);
}

class SearchFailure extends SearchState {
  final String error;
  SearchFailure(this.error);
}
class ResetSearch extends SearchState {}
class SortByMaxPrice extends SearchState {}
class SortByMinPrice extends SearchState {}
class SortByLastArrived extends SearchState {}
class SelectCondition extends SearchState {}