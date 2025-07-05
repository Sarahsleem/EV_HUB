part of 'services_cubit.dart';

@immutable
abstract class ServicesState {}

class ServicesInitial extends ServicesState {}
class ServicesLoading extends ServicesState{}
class ServicesError extends ServicesState{}
class ServicesSuccess extends ServicesState{}
class ServicesListLoading extends ServicesState{}
class ServicesListError extends ServicesState{}
class ServicesListSuccess extends ServicesState{}
class AddCommentSuccess extends ServicesState{}
class AddCommentError extends ServicesState{}
class AddCommentLoading extends ServicesState{}
class ChangeRatingState extends ServicesState{}
class CreateInsuranceLoading extends ServicesState {}

 class CreateInsuranceSuccess extends ServicesState {
  final Insurance createdInsurance; // Pass the created insurance object to the UI
  CreateInsuranceSuccess(this.createdInsurance);
}

class CreateInsuranceError extends ServicesState {
  final String message; // Pass the error message to the UI
  CreateInsuranceError(this.message);
}