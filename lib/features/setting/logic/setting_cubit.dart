import 'package:bloc/bloc.dart';
import 'package:evhub/features/setting/data/repo/setting_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit(this.settingRepo) : super(SettingInitial());
SettingRepo settingRepo;
   static SettingCubit get(context) => BlocProvider.of(context);

}
