part of 'edit_car_cubit.dart';

@immutable
abstract class EditCarState {}

class EditCarInitial extends EditCarState {}
class ChooseBrandState extends EditCarState{}
class ChooseCondtionState extends EditCarState{}
class ChooseImageState extends EditCarState{}
class ChooseModelState extends EditCarState{}
class ChooseUsedSinceState extends EditCarState{}
class ChooseBodyStyleState extends EditCarState{}
class ChooseChargeTypeState extends EditCarState{}
class PickedImagesSuccess extends EditCarState{}
class LoadingCarImages extends EditCarState{}
class ErrorUploadImages extends EditCarState{}
class PickedImageSuccess extends EditCarState{}
class LoadingCarImage extends EditCarState{}
class ErrorUploadImage extends EditCarState{}
class EditCarLoading extends EditCarState{}
class EditCarFailare extends EditCarState{}
class EditCarSuccess extends EditCarState{}