import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:evhub/features/add_new_car/data/repo/add_car_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../data/model/field_model.dart';

part 'add_new_car_state.dart';

class AddNewCarCubit extends Cubit<AddNewCarState> {
  AddNewCarCubit(this.addCarRepo) : super(AddNewCarInitial());
  AddCarRepo addCarRepo;
  static AddNewCarCubit get(context) => BlocProvider.of(context);
  int selectedBrandIndex=0;
  List<int> brandId = [];
  List<int> usedSinceId = [];
  List<int> styleId = [];
  String chargeType = '';
  List<int> conditionId = [];
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
    fieldsModel(id: 12, name: "SUV")
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
    {"id": 14, "name": "Used"}
  ];
  // Assuming charge types are sent as strings
  List<String> chargeTypes = [
    "CCS2",
    "Type2",
    "CCS1",
    "GPT",
    "TESLA (NACS)",
    "CHAdeMO"
  ];
  int selectedBrandId=0;
 void chooseBrand(int index, int id){
   brandId.add(id);
   selectedBrandIndex=index;
   emit(ChooseBrandState());
 }
  Future<void> pickMultipleImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
     // isAllowedImages = false;


      final existingPaths = selectedImages.map((f) => f.path).toSet();

      for (var file in pickedFiles) {
        if (!existingPaths.contains(file.path)) {
          final newImage = File(file.path);
          selectedImages.add(newImage);

          try {
            final response = await addCarRepo.postCarImage(newImage);
            imagesIds.add(response);
            print("Image ID: $imagesIds");

          } catch (e) {
            print(" Error uploading image: $e");
          }
        } else {
          print("Skipping duplicate image: ${file.path}");
        }
      }

      //isAllowedImages = true;
      // Update UI with new images
    }
  }

  Future<void> pickFeaturedImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      final response = await addCarRepo.postCarImage(image!);
      final bytes = await pickedFile.readAsBytes();
      base64Image = response;
    }
  }
}
