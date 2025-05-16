import 'package:bloc/bloc.dart';
import 'package:evhub/core/assets/images.dart';
import 'package:evhub/features/home/data/model/Ads_model.dart';
import 'package:evhub/features/home/data/model/feature_model.dart';
import 'package:evhub/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  HomeRepo homeRepo;
  static HomeCubit get(context) => BlocProvider.of(context);
List<AdsModel> ads=[];
Future<void> getAds()async{
  emit(HomeLoadingADSState());
  var response =await homeRepo.getADS();
  response.fold((l){
    emit(HomeErrorADSState());
  }, (r){
    ads=r;
    emit(HomeSuccessADSState());
  });

}
List<Feature> features=[
  Feature(image:ImagesManager.insurance, title: 'insurance',),
  Feature(image: ImagesManager.protection, title: 'protection', ),
  Feature(image: ImagesManager.stations, title: 'Charging stations', ),

];
}
