import 'package:bloc/bloc.dart';
import 'package:evhub/core/networking/api_error_model.dart';
import 'package:evhub/ev_hub.dart';
import 'package:evhub/features/home/data/model/car_model.dart';
import 'package:evhub/features/wish_list/data/repo/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/functions/snak_bar.dart';
import '../../../generated/l10n.dart';

part 'wish_list_state.dart';

class WishListCubit extends Cubit<WishListState> {
  WishListCubit(this.wishListRepo) : super(WishListInitial());
  WishListRepo wishListRepo;
  static WishListCubit get(context) => BlocProvider.of(context);
List<Car> favCars=[];
  int? updatingCarId;
  Future<void> addToFavorites(int carId) async {
    updatingCarId = carId;
    emit(AddToFavoritesLoadingState());
    await wishListRepo.addToFavorites(carId);
    emit(AddToFavoritesSuccessState());
    showSnackBar(context: NavigationService.navigatorKey.currentContext!, text: S.of(NavigationService.navigatorKey.currentContext!).AddedToFavorites);
    updatingCarId = null;
  }

  Future<void> removeFromFavorites(int carId) async {
    updatingCarId = carId;
    emit(RemoveFromFavoritesLoadingState());
    await wishListRepo.removeFromFavorites(carId);
    emit(RemoveFromFavoritesSuccessState());
    updatingCarId = null;
  }

  Future<void> getFavorites() async {
    emit(GetFavoritesLoadingState());
    final result = await wishListRepo.getFavorites();
    result.fold(
          (error) => emit(GetFavoritesErrorState(error)),
          (favorites) {
        favCars = favorites;
        emit(GetFavoritesSuccessState(favorites));
      },
    );
  }
}
