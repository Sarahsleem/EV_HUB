part of 'add_new_car_cubit.dart';

@immutable
abstract class AddNewCarState {}

class AddNewCarInitial extends AddNewCarState {}
class ChooseBrandState extends AddNewCarState{}
class ChooseCondtionState extends AddNewCarState{}
class ChooseModelState extends AddNewCarState{}
class ChooseUsedSinceState extends AddNewCarState{}
class ChooseBodyStyleState extends AddNewCarState{}
class ChooseChargeTypeState extends AddNewCarState{}
class PickedImagesSuccess extends AddNewCarState{}
class LoadingImages extends AddNewCarState{}
class ErrorUploadImages extends AddNewCarState{}
class PickedImageSuccess extends AddNewCarState{}
class LoadingImage extends AddNewCarState{}
class ErrorUploadImage extends AddNewCarState{}
class PostCarLoading extends AddNewCarState{}
class PostCarFailare extends AddNewCarState{}
class PostCarSuccess extends AddNewCarState{}