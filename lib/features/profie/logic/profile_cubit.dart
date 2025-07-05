import 'package:bloc/bloc.dart';
import 'package:evhub/core/db/cash_helper.dart';

import 'package:evhub/features/profie/data/models/profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/db/cached_app.dart';
import '../data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  final ProfileRepo profileRepo;
  ProfileModel? profileUser;
  Future<void> getProfile() async {
    try{
profileUser=CachedApp.getCachedData(CachedDataType.profile.name);
    }catch (e){
      emit(ProfileLoading());
      final result = await profileRepo.fetchProfile();
      {
        result.fold(
              (failure) {
            profileUser = null;
            emit(ProfileFailure(failure.message.toString()));
          },
              (profileApi) {
            profileUser = profileApi;
            CachedApp.saveData(profileUser,CachedDataType.profile.name);
            CashHelper.putInt(key: Keys.userId, value: profileApi.id!,);
            CashHelper.putString(key: Keys.name, value: profileApi.name!);
            CashHelper.putString(key: Keys.email, value: profileApi.email!);
            emit(ProfileSuccess());
          },
        );
      }
    }
  }
}
