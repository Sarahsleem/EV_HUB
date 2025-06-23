part of 'wish_list_cubit.dart';

@immutable
abstract class WishListState {}

class WishListInitial extends WishListState {}
class GetFavoritesLoadingState extends WishListState {}
class GetFavoritesSuccessState extends WishListState {
  final List<Car> favorites;
  GetFavoritesSuccessState(this.favorites);
}
class GetFavoritesErrorState extends WishListState {
  final ApiErrorModel message;
  GetFavoritesErrorState(this.message);
}
class AddToFavoritesLoadingState extends WishListState {}
class AddToFavoritesSuccessState extends WishListState {}
class RemoveFromFavoritesLoadingState extends WishListState {}
class RemoveFromFavoritesSuccessState extends WishListState {}