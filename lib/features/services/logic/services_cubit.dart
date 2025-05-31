import 'package:bloc/bloc.dart';
import 'package:evhub/features/services/data/model/car_acc_model.dart';
import 'package:evhub/features/services/data/model/car_services_model.dart';
import 'package:evhub/features/services/data/model/service_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/repo/services_repo.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit(this.servicesRepo) : super(ServicesInitial());
  static ServicesCubit get(context) => BlocProvider.of(context);
  List<ServiceCenter> carServices = [];
  Services servicesRepo;
  List<ServiceCenter> serviceCenters = [];
  Future<void> getServices() async {
    emit(ServicesLoading());

    var respo = await servicesRepo.fetchServiceCenters();
    respo.fold(
      (l) {
        emit(ServicesError());
      },
      (r) {
        serviceCenters = r;
        emit(ServicesSuccess());
      },
    );
  }
  List<CarAccessories> carAccessories=[];
  Future<void> getCarAccessories() async {
    emit(ServicesListLoading());

    var respo = await servicesRepo.fetchCarAccessories();
    respo.fold(
      (l) {
        emit(ServicesListError());
      },
      (r) {
        carAccessories = r;
        emit(ServicesListSuccess());
      },
    );
  }


  List<CarServicesModel> listServices = [
    CarServicesModel(
      image: 'images/png/insurance.png',
      title: 'Insurance',
      description:
          'Car insurance covers your vehicle and damages in case of accidents or theft.',
    ),
    CarServicesModel(
      image: 'images/png/carservice.png',
      title: 'Car Service',
      description:
          'Car service keeps your vehicle running smoothly with regular maintenance and checks.',
    ),
    CarServicesModel(
      image: 'images/png/carprotection.png',
      title: 'Car Protection Film',
      description:
          'Car protection film shields your car’s paint from scratches, chips, and UV damage.',
    ),
    CarServicesModel(
      image: 'images/png/establishcharge.png',
      title: 'Establishing Charging',
      description:
          'Establishing charging ensures safe and convenient power access for electric vehicles.',
    ),
    CarServicesModel(
      image: 'images/png/carParts.png',
      title: 'Car Parts',
      description:
          'Car parts are essential components that keep your vehicle functioning properly.',
    ),
    CarServicesModel(
      image: 'images/png/solarEnergy.png',
      title: 'Solar Energy',
      description:
          'Solar energy powers devices and systems using clean, renewable sunlight.',
    ),
    CarServicesModel(
      image: 'images/png/carAcces.png',
      title: 'Car Accessories',
      description:
          'Car accessories enhance your vehicle’s comfort, style, and functionality',
    ),
    CarServicesModel(
      image: 'images/png/carapp.png',
      title: 'Car Insurance Application',
      description:
          'Car insurance application lets you easily apply for coverage and manage your policy.',
    ),
    CarServicesModel(
      image: 'images/png/carinstall.png',
      title: 'Car Installment Request',
      description:
          'Car installment request allows you to buy a vehicle through monthly payments.',
    ),
    CarServicesModel(
      image: 'images/png/carwash.png',
      title: 'Car Wash',
      description:
          'Car wash cleans and refreshes your vehicle’s exterior and interior.',
    ),
  ];
}
