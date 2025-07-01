import 'package:evhub/features/home/data/model/company_model.dart';
import 'package:evhub/features/home/data/repo/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'car_market_cubit_state.dart';

class CarMarketCubitCubit extends Cubit<CarMarketCubitState> {
  CarMarketCubitCubit(this.homeRepo) : super(CarMarketCubitInitial());
  HomeRepo homeRepo;
  static CarMarketCubitCubit get(context) => BlocProvider.of(context);

  List<CompanyModel> companyUsers = [];
  List<CompanyModel> caragency = [];
  int visibleUsersCount = 0;

  Future<void> getUsersByRole(String role) async {
    emit(CarMarketLoadingUsersState());

    final response = await homeRepo.fetchUsersByRole(role);

    response.fold(
      (errorMessage) => emit(CarMarketErrorUsersState(errorMessage)),
      (users) {
        companyUsers = users;
        visibleUsersCount = users.length < 7 ? users.length : 7;
        emit(CarMarketSuccessUsersState());
      },
    );
  }
    Future<void> getCarAgency(String role) async {
    emit(CarMarketLoadingCarAgencyState());

    final response = await homeRepo.fetchUsersByRole(role);

    response.fold(
      (errorMessage) => emit(CarMarketErrorCarAgencyState(errorMessage)),
      (users) {
        caragency = users;
        visibleUsersCount = users.length < 7 ? users.length : 7;
        emit(CarMarketSuccessCarAgencyState());
      },
    );
  }
}
