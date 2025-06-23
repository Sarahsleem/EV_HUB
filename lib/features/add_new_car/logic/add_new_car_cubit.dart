import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:evhub/features/add_new_car/data/repo/add_car_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../data/model/car_request_model.dart';
import '../data/model/field_model.dart';

part 'add_new_car_state.dart';

class AddNewCarCubit extends Cubit<AddNewCarState> {
  AddNewCarCubit(this.addCarRepo) : super(AddNewCarInitial());
  AddCarRepo addCarRepo;
  static AddNewCarCubit get(context) => BlocProvider.of(context);
  int selectedBrandIndex = 42;
  int brandId = 31;
  int usedSinceId = 0;
  int styleId = 39;
  String chargeType = "CCS2";
  int conditionId = 13;
  int modelId = 8;
  // Renamed for clarity? Or Range? Check CarFields model
  // Renamed for clarity? Or Range? Check CarFields model
  List<File> selectedImages = [];
  List<String> base64Images = [];
  List<int> imagesIds = [];
  File? image; // For featured image
  int? base64Image;
  List<fieldsModel> carStyles = [
    fieldsModel(id: 39, name: "Coupe"),
    fieldsModel(id: 40, name: "Crossover"),
    fieldsModel(id: 38, name: "Hatchback"),
    fieldsModel(id: 41, name: "Luxury"),
    fieldsModel(id: 37, name: "Sedan"),
    fieldsModel(id: 12, name: "SUV"),
  ];
  // Assuming fieldsModel is defined as in your original code
  List<fieldsModel> yearsSince = [
    fieldsModel(id: 42, name: "2008"),
    fieldsModel(id: 43, name: "2009"),
    fieldsModel(id: 44, name: "2010"),
    fieldsModel(id: 45, name: "2011"),
    fieldsModel(id: 46, name: "2012"),
    fieldsModel(id: 47, name: "2013"),
    fieldsModel(id: 48, name: "2014"),
    fieldsModel(id: 49, name: "2015"),
    fieldsModel(id: 50, name: "2016"),
    fieldsModel(id: 51, name: "2017"),
    // Add more years as needed
    fieldsModel(id: 52, name: "2018"),
    fieldsModel(id: 53, name: "2019"),
    fieldsModel(id: 54, name: "2020"),
    fieldsModel(id: 55, name: "2021"),
    fieldsModel(id: 56, name: "2022"),
    fieldsModel(id: 57, name: "2023"),
    fieldsModel(id: 58, name: "2024"),
    fieldsModel(id: 59, name: "2025"),
    fieldsModel(id: 60, name: "2026"),
  ];
  List<Map<String, dynamic>> conditions = [
    {"id": 13, "name": "New"},
    {"id": 14, "name": "Used"},
  ];  List<fieldsModel> carModel = [
    fieldsModel(id: 8, name: 'X1')


  ];
  // Assuming charge types are sent as strings
  List<String> chargeTypes = [
    "CCS2",
    "Type2",
    "CCS1",
    "GPT",
    "TESLA (NACS)",
    "CHAdeMO",
  ];
  int selectedBrandId = 0;
  int selectedConditionId = 13;
  int selectedModelId = 8;

  void chooseCondition(int index) {
    conditionId=conditions[index]['id'];
    selectedConditionId = conditions[index]['id'];
    emit(ChooseCondtionState());
  }
  void chooseCarModel(int index) {
    modelId=carModel[index].id;
    print(modelId);
    selectedModelId = carModel[index].id;
    emit(ChooseModelState());
  }

  int selectedUsedSinceId = 0;
  int selectedUsedSinceIndex = 0;

  void chooseUsedSince(int index) {
    selectedUsedSinceIndex = index;
    usedSinceId=yearsSince[index].id;
    emit(ChooseUsedSinceState());
  }

  int selectedBodyStyleId = 0;
  int selectedBodyStyleIndex = 0;
  void chooseBodyStyle(int index) {
    selectedBodyStyleIndex = index;
    styleId=carStyles[index].id;
    emit(ChooseBodyStyleState());
  }

  void chooseChargeType(int index) {
    chargeType = chargeTypes[index];
    emit(ChooseChargeTypeState());
  }

  void chooseBrand(int index, int id) {
    brandId=id;
    print(brandId);
    selectedBrandIndex = index;
    emit(ChooseBrandState());
  }

  Future<void> pickMultipleImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isEmpty) return;

    final existingPaths = selectedImages.map((f) => f.path).toSet();

    for (final file in pickedFiles) {
      if (existingPaths.contains(file.path)) {
        print("Skipping duplicate image: ${file.path}");
        continue;
      }

      final newImage = File(file.path);
      selectedImages.add(newImage);
      emit(LoadingImages());

      try {
        final response = await addCarRepo.postCarImage(newImage);
        imagesIds.add(response);
        print("Image ID: $imagesIds");
        emit(PickedImagesSuccess());
      } catch (e) {
        print("Error uploading image: $e");
        emit(ErrorUploadImages());
      }
    }
  }

  Future<void> pickFeaturedImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    emit(LoadingImage());
    if (pickedFile != null) {
      try {
        image = File(pickedFile.path);
        final response = await addCarRepo.postCarImage(image!);
        final bytes = await pickedFile.readAsBytes();
        base64Image = response;
        emit(PickedImageSuccess());
      } catch (e) {
        emit(ErrorUploadImage());
      }
    }
  }

  Future<void> postCar(String title, String describe,String price,String enpower,String battery,String km) async {
    CarRequestModel carModel = CarRequestModel(
      title: title,
      status: 'pending',
      carBrand: [brandId],
      carImages: imagesIds,
      featuredImage: base64Image,
      content: describe,
      usedSince: [usedSinceId],
      condition: [conditionId],
      bodyStyle:[styleId],
      model: [modelId],
      fields: Fields(price: price,motorPowerElectricHorsepowerHp: enpower,batteryCapacity: battery,compatibleChargerType: chargeType,km: km)
    );
    emit(PostCarLoading());
    var response = await addCarRepo.postCars(carModel);
    response.fold(
      (l) {
        emit(PostCarFailare());
      },
      (r) {
        emit(PostCarSuccess());
      },
    );
  }
}
