import 'package:bloc/bloc.dart';
import 'package:evhub/features/forget_password/data/repo/forget_password_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.forgetPasswordRepo) : super(ForgetPasswordInitial());
  ForgetPasswordRepo forgetPasswordRepo;
  static ForgetPasswordCubit get(context) => BlocProvider.of(context);
}
