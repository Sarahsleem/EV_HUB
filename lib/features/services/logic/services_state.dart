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