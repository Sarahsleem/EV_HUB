import 'package:bloc/bloc.dart';
import 'package:evhub/ev_hub.dart';
import 'package:evhub/features/search/data/repo/search_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../generated/l10n.dart';
import '../../add_new_car/data/model/field_model.dart';
import '../../home/data/model/car_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());
  SearchRepo searchRepo;
  static SearchCubit get(context) => BlocProvider.of(context);
  List<fieldsModel> carStyles = [
    fieldsModel(id: 39, name: "Coupe"),
    fieldsModel(id: 40, name: "Crossover"),
    fieldsModel(id: 38, name: "Hatchback"),
    fieldsModel(id: 41, name: "Luxury"),
    fieldsModel(id: 37, name: "Sedan"),
    fieldsModel(id: 12, name: "SUV"),
  ];
  // Assuming fieldsModel is defined as in your original code
  List<fieldsModel> yearsSince = [
    fieldsModel(id: 42, name: "2008"),
    fieldsModel(id: 43, name: "2009"),
    fieldsModel(id: 44, name: "2010"),
    fieldsModel(id: 45, name: "2011"),
    fieldsModel(id: 46, name: "2012"),
    fieldsModel(id: 47, name: "2013"),
    fieldsModel(id: 48, name: "2014"),
    fieldsModel(id: 49, name: "2015"),
    fieldsModel(id: 50, name: "2016"),
    fieldsModel(id: 51, name: "2017"),
    // Add more years as needed
    fieldsModel(id: 52, name: "2018"),
    fieldsModel(id: 53, name: "2019"),
    fieldsModel(id: 54, name: "2020"),
    fieldsModel(id: 55, name: "2021"),
    fieldsModel(id: 56, name: "2022"),
    fieldsModel(id: 57, name: "2023"),
    fieldsModel(id: 58, name: "2024"),
    fieldsModel(id: 59, name: "2025"),
    fieldsModel(id: 60, name: "2026"),
  ];
  List<Map<String, dynamic>> conditions = [
    {"id": 13, "name": "New"},
    {"id": 14, "name": "Used"},
  ];
  List<fieldsModel> carModel = [fieldsModel(id: 8, name: 'X1')];
  List<Car> result=[];
  void reset() {
    selectedBrand = '';
    selectedCondition = '';
    selectedstyle = '';
    selectedModel = '';
     selectedSince = '';
     emit(ResetSearch());
  }
  String selectedBrand = '';
  String selectedCondition = '';String selectedConditionSend = '';
  void selectCondition(String condition) {
    if(condition=='new'||condition=='جديدة'){
      selectedConditionSend='new';
      selectedCondition=condition;
    }
    else{
      selectedConditionSend='used';
      selectedCondition=condition;

    }

    emit(SelectCondition());
  }
  String selectedstyle = '';
  String selectedModel = '';String selectedSince = '';
  int maxPrice = 0;int minPrice = 0;
  Future<void> search(int?minPrice,int?maxPrice) async {
    emit(SearchLoading());

      final cars = await searchRepo.searchCars(
        brandName: selectedBrand.isNotEmpty ? selectedBrand : null,
        modelName: selectedModel.isNotEmpty ? selectedModel : null,
        conditionName: selectedConditionSend.isNotEmpty ? selectedConditionSend : null,
        bodyStyleName: selectedstyle.isNotEmpty ? selectedstyle : null,
        usedSinceName: null, // add if needed
        priceMin: minPrice! > 0 ? minPrice : null,
        priceMax: maxPrice! > 0 ? maxPrice : null,
      );
      cars.fold((l){ emit(SearchFailure(l.toString()));}, (cars) {
        result=cars;
        emit(SearchSuccess(cars));
      });


  }
  final List<String> sortOptions = [S.of(NavigationService.navigatorKey.currentContext!).MaxPrice,S.of(NavigationService.navigatorKey.currentContext!).MinPrice, S.of(NavigationService.navigatorKey.currentContext!).LastArrived];
  String selectedSort = S.of(NavigationService.navigatorKey.currentContext!).MaxPrice;
  void sortBy(String sort) {
    if (result.isEmpty) return;

    switch (sort) {
      case 'Max Price'||'أعلى سعر':
        result.sort((a, b) => (b.acf?['price'] ?? 0).compareTo(a.acf?['price'] ?? 0));
        emit(SortByMaxPrice());
        break;

      case 'Min Price'||'أقل سعر':
        result.sort((a, b) => (a.acf?['price'] ?? 0).compareTo(b.acf?['price'] ?? 0));
        emit(SortByMinPrice());
        break;

      case 'Last Arrived'||'آخر الإضافات':
        result.sort((a, b) => (b.date ?? '').compareTo(a.date ?? ''));
        emit(SortByLastArrived());
        break;
    }
  }

}
