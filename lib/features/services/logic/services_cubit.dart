import 'package:bloc/bloc.dart';
import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/ev_hub.dart';
import 'package:evhub/features/services/data/model/car_acc_model.dart';
import 'package:evhub/features/services/data/model/car_services_model.dart';
import 'package:evhub/features/services/data/model/service_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/model/car_part_model.dart';
import '../data/model/car_protetion_file.dart';
import '../data/model/establishingCharging.dart';
import '../data/model/insurance_model.dart';
import '../data/model/solar_model.dart';
import '../data/repo/services_repo.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit(this.servicesRepo) : super(ServicesInitial());
  static ServicesCubit get(context) => BlocProvider.of(context);
  List<ServiceCenter> carServices = [];
  Services servicesRepo;
  List<ServiceCenter> serviceCenters = [];
  List<Insurance> serviceInsurance = [];
  List<SolarEnergy> serviceSolarEnergy = [];
  List<EstablishingCharging> serviceEstablishingCharging = [];
  List<CarProtectionFilm> serviceCarProtectionFilm = [];
  List<CarParts> serviceCarParts= [];
  List<CarAccessories> carAccessories=[];
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
  } Future<void> getCarParts() async {
    emit(ServicesListLoading());

    var respo = await servicesRepo.fetchCarParts();
    respo.fold(
      (l) {
        emit(ServicesListError());
      },
      (r) {
        serviceCarParts = r;
        emit(ServicesListSuccess());
      },
    );
  } Future<void> getEstablishingCharging() async {
    emit(ServicesListLoading());

    var respo = await servicesRepo.fetchEstablishingCharging();
    respo.fold(
      (l) {
        emit(ServicesListError());
      },
      (r) {
        serviceEstablishingCharging = r;
        emit(ServicesListSuccess());
      },
    );
  } Future<void> getSolarEnergy() async {
    emit(ServicesListLoading());

    var respo = await servicesRepo.fetchSolarEnergy();
    respo.fold(
      (l) {
        emit(ServicesListError());
      },
      (r) {
        serviceSolarEnergy = r;
        emit(ServicesListSuccess());
      },
    );
  } Future<void> getCarProtectionFilm() async {
    emit(ServicesListLoading());

    var respo = await servicesRepo.fetchCarProtectionFilms();
    respo.fold(
      (l) {
        emit(ServicesListError());
      },
      (r) {
        serviceCarProtectionFilm = r;
        emit(ServicesListSuccess());
      },
    );
  } Future<void> getCarInsurance() async {
    emit(ServicesListLoading());

    var respo = await servicesRepo.fetchInsurance();
    respo.fold(
      (l) {
        emit(ServicesListError());
      },
      (r) {
        serviceInsurance = r;
        emit(ServicesListSuccess());
      },
    );
  }

  List<dynamic> currentItems = [];


  Future<void> loadData(String type) async {
    emit(ServicesListLoading());

    switch (type) {
      case 'Car Accessories':
        final res = await servicesRepo.fetchCarAccessories();
        res.fold((l) => emit(ServicesListError()), (r) {
          currentItems = r;
          emit(ServicesListSuccess());
        });
        break;

      case 'Car Parts':
        final res = await servicesRepo.fetchCarParts();
        res.fold((l) => emit(ServicesListError()), (r) {
          currentItems = r;
          emit(ServicesListSuccess());
        });
        break;

      case 'Car Protection Film':
        final res = await servicesRepo.fetchCarProtectionFilms();
        res.fold((l) => emit(ServicesListError()), (r) {
          currentItems = r;
          emit(ServicesListSuccess());
        });
        break;

      case 'Insurance':
        final res = await servicesRepo.fetchInsurance();
        res.fold((l) {
          emit(ServicesListError());
          print(l);
        }, (r) {
          currentItems = r;
          emit(ServicesListSuccess());
        });
        break;

      case 'Solar Energy':
        final res = await servicesRepo.fetchSolarEnergy();
        res.fold((l) => emit(ServicesListError()), (r) {
          currentItems = r;
          emit(ServicesListSuccess());
        });
        break;

      case 'Establishing Charging':
        final res = await servicesRepo.fetchEstablishingCharging();
        res.fold((l) => emit(ServicesListError()), (r) {
          currentItems = r;
          emit(ServicesListSuccess());
        });
        break;
        case 'Car Service':
        final res = await servicesRepo.fetchServiceCenters();
        res.fold((l) => emit(ServicesListError()), (r) {
          currentItems = r;
          emit(ServicesListSuccess());
        });
        break;
    }
  }

  List<CarServicesModel> listServices = [
    CarServicesModel(
      image: 'images/png/insurance.png',
      title: 'Insurance',
      description:
          'Car insurance covers your vehicle and damages in case of accidents or theft.',
      onTap: (){
        NavigationService.navigatorKey.currentContext?.pushNamed(Routes.serviceListDetails,arguments:'Insurance' );
      }
    ),
    CarServicesModel(
      image: 'images/png/carservice.png',
      title: 'Car Service',
      description:
          'Car service keeps your vehicle running smoothly with regular maintenance and checks.',
        onTap: (){
          NavigationService.navigatorKey.currentContext?.pushNamed(Routes.serviceListDetails,arguments:'Car Service' );
        }
    ),
    CarServicesModel(
      image: 'images/png/carprotection.png',
      title: 'Car Protection Film',
      description:
          'Car protection film shields your car’s paint from scratches, chips, and UV damage.',
        onTap: (){
          NavigationService.navigatorKey.currentContext?.pushNamed(Routes.serviceListDetails,arguments:'Car Protection Film' );
        }
    ),
    CarServicesModel(
      image: 'images/png/establishcharge.png',
      title: 'Establishing Charging',
      description:
          'Establishing charging ensures safe and convenient power access for electric vehicles.',
        onTap: (){
          NavigationService.navigatorKey.currentContext?.pushNamed(Routes.serviceListDetails,arguments:'Establishing Charging' );
        }
    ),
    CarServicesModel(
      image: 'images/png/carParts.png',
      title: 'Car Parts',
      description:
          'Car parts are essential components that keep your vehicle functioning properly.',
        onTap: (){
          NavigationService.navigatorKey.currentContext?.pushNamed(Routes.serviceListDetails,arguments:'Car Parts' );
        }
    ),
    CarServicesModel(
      image: 'images/png/solarEnergy.png',
      title: 'Solar Energy',
      description:
          'Solar energy powers devices and systems using clean, renewable sunlight.',
        onTap: (){
          NavigationService.navigatorKey.currentContext?.pushNamed(Routes.serviceListDetails,arguments:'Solar Energy' );
        }
    ),
    CarServicesModel(
      image: 'images/png/carAcces.png',
      title: 'Car Accessories',
      description:
          'Car accessories enhance your vehicle’s comfort, style, and functionality',
        onTap: (){
          NavigationService.navigatorKey.currentContext?.pushNamed(Routes.serviceListDetails,arguments:'Car Accessories' );
        }
    ),
    CarServicesModel(
      image: 'images/png/carapp.png',
      title: 'Car Insurance Application',
      description:
          'Car insurance application lets you easily apply for coverage and manage your policy.',
      onTap: (){
       // "https://evhubtl.com/تقديم-طلب-تامين-علي-سياراة/"
        NavigationService.navigatorKey.currentContext?.pushNamed(Routes.webPage,arguments: "https://evhubtl.com/تقديم-طلب-تامين-علي-سياراة/");

      }
    ),
    CarServicesModel(
      image: 'images/png/carinstall.png',
      title: 'Car Installment Request',
      description:
          'Car installment request allows you to buy a vehicle through monthly payments.',
      onTap: (){
        NavigationService.navigatorKey.currentContext?.pushNamed(Routes.webPage,arguments: 'https://evhubtl.com/تقديم-طلب-تقسيط-سياراه/');

      }
    ),
    CarServicesModel(
      image: 'images/png/carwash.png',
      title: 'Car Wash',
      description:
          'Car wash cleans and refreshes your vehicle’s exterior and interior.',
      onTap: (){
        NavigationService.navigatorKey.currentContext?.pushNamed(Routes.webPage,arguments: 'https://evhubtl.com/تقديم-طلب-تقسيط-سياراه/');
      }
    ),
  ];
}
