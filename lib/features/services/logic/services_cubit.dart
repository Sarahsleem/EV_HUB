import 'package:bloc/bloc.dart';
import 'package:evhub/features/services/data/model/service_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/repo/services_repo.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit(this.servicesRepo) : super(ServicesInitial());
  static ServicesCubit get(context) => BlocProvider.of(context);
  List<ServiceCenter> carServices = [];
  Services servicesRepo ;
  List<ServiceCenter> serviceCenters = [];
  Future<void> getServices() async {
    emit(ServicesLoading());

    var respo = await servicesRepo.fetchServiceCenters();
    respo.fold((l){
      emit(ServicesError());
    }, (r){
      serviceCenters=r;
      emit(ServicesSuccess());
    });

  }
}
