import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:evhub/core/widgets/app_text_form_field.dart';
import 'package:evhub/features/add_new_car/data/model/car_request_model.dart';
import 'package:evhub/features/add_new_car/logic/add_new_car_cubit.dart';
import 'package:evhub/features/add_new_car/ui/widget/add_car_states_ui.dart';
import 'package:evhub/features/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/image_network.dart';

class AddCarDetails extends StatefulWidget {
  const AddCarDetails({super.key});

  @override
  State<AddCarDetails> createState() => _AddCarDetailsState();
}

class _AddCarDetailsState extends State<AddCarDetails> {
  @override
  void didChangeDependencies() {
  }
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController enginePower = TextEditingController();
  TextEditingController batteryCapacity = TextEditingController();
  TextEditingController km = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddNewCarCubit, AddNewCarState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('images/png/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 31.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => context.pop(),
                              icon: Icon(Icons.arrow_back_ios_new_rounded),
                            ),
                            SizedBox(width: 24.w),
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Add Your ',
                                style: TextStyles.inter18WhiteMedium.copyWith(
                                  fontSize: 28.4.sp,
                                  color: Colors.white.withOpacity(0.42),
                                ),
                              ),
                              TextSpan(
                                text: 'New Car Details',
                                style: TextStyles.inter18WhiteMedium.copyWith(
                                  fontSize: 28.4.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(33),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 27.w),
                    child: Row(
                      children: [
                        AppCachedNetworkImage(
                          fit: BoxFit.scaleDown,
                          radius: 39.5.r,
                          image:
                              HomeCubit.get(context)
                                  .carBrands[AddNewCarCubit.get(
                                    context,
                                  ).selectedBrandIndex]
                                  .acf
                                  .brandLogo
                                  .url,
                          height: 75.h,
                          width: 75.w,
                        ),
                        horizontalSpace(15.9.sp),
                        Column(
                          children: [
                            // Text(
                            //   'car Model',
                            //   style: TextStyles.inter16greyMedium,
                            // ),
                            CarModelSelector(
                              selectedModel: 'X1',
                              selectedYear: '2023',
                              models: AddNewCarCubit.get(context).carModel.map((e) => e.name).toList(),
                              years: ['2023', '2024', '2025'],
                              onModelChanged: (value) {
                                final cubit = AddNewCarCubit.get(context);
                                final selectedIndex = cubit.carModel.indexWhere((e) => e.name == value);
                                if (selectedIndex != -1) {
                                  cubit.chooseCarModel(selectedIndex); // Send the index of selected value
                                }
                              },
                              onYearChanged: (value) {
                                // setState(() {
                                //   selectedYear = value!;
                                // });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(20),
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.w,
                        vertical: 5.h,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      width: 197.w,
                      //height: 39.h,
                      decoration: BoxDecoration(
                        color: Color(0x5743585e),
                        borderRadius: BorderRadius.circular(21.47.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              AddNewCarCubit.get(context).chooseCondition(0);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: AddNewCarCubit.get(context).selectedConditionId==14?Colors.transparent:Colors.black,
                                borderRadius: BorderRadius.circular(21.47.r),
                              ),
                              child: Text(
                                'new',
                                style: TextStyles.inter12WhiteRegular.copyWith(
                                  fontSize: 13.48.sp,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              AddNewCarCubit.get(context).chooseCondition(1);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: AddNewCarCubit.get(context).selectedConditionId==14?Colors.black:Colors.transparent,
                                borderRadius: BorderRadius.circular(21.47.r),
                              ),
                              child: Text(
                                'Used',
                                style: TextStyles.inter12WhiteRegular.copyWith(
                                  fontSize: 13.48.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 26.w,
                      vertical: 26.h,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0x630f0f0f),
                      borderRadius: BorderRadius.circular(44.r),
                    ),
                    child: Column(
                      children: [
                        CustomInput(
                          title: 'Title',
                          image: 'images/png/title.png',
                          endWidget: SizedBox(
                            width: 247.w,
                            height: 52.5.h,
                            child: AppTextFormField(
                              controller: title,
                              hintText: 'your details car title',
                              backgroundColor: Colors.transparent,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(26),
                        CustomInput(
                          title: 'Description',
                          image: 'images/png/desc.png',
                          endWidget: SizedBox(
                            width: 247.w,
                            //height: 52.5.h,
                            child: AppTextFormField(
                              controller: description,
                              hintText: 'your car Description',
                              backgroundColor: Colors.transparent,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(16),
                      BlocBuilder<AddNewCarCubit, AddNewCarState>(
                        builder: (context, state) {
                          final cubit = AddNewCarCubit.get(context);
                          final isLoading = state is LoadingImage;

                          return Column(
                            children: [
                              GestureDetector(
                                onTap: cubit.pickFeaturedImage,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 20.h,
                                    horizontal: 70.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0x17d9d9d9),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: isLoading
                                      ? Center(
                                    child: CircularProgressIndicator(
                                      color: ColorsManager.darkBlue,
                                    ),
                                  )
                                      : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "images/png/carimages.png",
                                        height: 36.h,
                                        width: 36.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'Add Your Main Car Image',
                                        style: TextStyles.inter10GreySemiBold,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),

                              /// Show picked featured image
                              if (cubit.image != null && cubit.image!.existsSync())
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.file(
                                    cubit.image!,
                                    width: 100.w,
                                    height: 100.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),

                        verticalSpace(11),
                        BlocBuilder<AddNewCarCubit, AddNewCarState>(
                          builder: (context, state) {
                            final cubit = AddNewCarCubit.get(context);
                            final isLoading = state is LoadingImages;

                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: cubit.pickMultipleImages,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20.h,
                                      horizontal: 70.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0x17d9d9d9),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: isLoading
                                        ? Center(
                                      child: CircularProgressIndicator(
                                        color: ColorsManager.darkBlue,
                                      ),
                                    )
                                        : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "images/png/carimages.png",
                                          height: 36.h,
                                          width: 36.w,
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          'Add Your Car Images',
                                          style: TextStyles.inter10GreySemiBold,
                                        ),
                                        Text(
                                          'max. 8 Photos',
                                          style: TextStyles.inter10GreySemiBold,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),

                                /// Show picked images
                                if (cubit.selectedImages.isNotEmpty)
                                  Wrap(
                                    spacing: 8.w,
                                    runSpacing: 8.h,
                                    children: cubit.selectedImages
                                        .map((file) => ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.file(
                                        file,
                                        width: 80.w,
                                        height: 80.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ))
                                        .toList(),
                                  ),
                              ],
                            );
                          },
                        ),

                        verticalSpace(16),
                        CustomInput(
                          title: 'Price',
                          image: 'images/png/price.png',
                          endWidget: SizedBox(
                            width: 247.w,
                            height: 52.5.h,
                            child: AppTextFormField(
                              controller: price,
                              keyboardType: TextInputType.phone,
                              hintText: 'LE',
                              backgroundColor: Colors.transparent,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(30),
                        CustomInput(
                          title: 'Engine Power',
                          image: 'images/png/ep.png',
                          endWidget: SizedBox(
                            width: 247.w,
                            height: 52.5.h,
                            child: AppTextFormField(
                              controller: enginePower,
                              keyboardType: TextInputType.phone,
                              hintText: 'HP',
                              backgroundColor: Colors.transparent,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(30),
                        CustomInput(
                          title: 'Battery Capacity',
                          image: 'images/png/bc.png',
                          endWidget: SizedBox(
                            width: 247.w,
                            height: 52.5.h,
                            child: AppTextFormField(
                              controller: batteryCapacity,
                              keyboardType: TextInputType.phone,
                              hintText: 'Kwh',
                              backgroundColor: Colors.transparent,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        AddNewCarCubit.get(context).selectedConditionId==14?Column(
                          children: [
                            verticalSpace(30),
                            CustomInput(
                              title: 'Km',
                              image: 'images/png/carused.png',
                              endWidget: SizedBox(
                                width: 247.w,
                                height: 52.5.h,
                                child: AppTextFormField(
                                  controller: km,
                                  keyboardType: TextInputType.phone,
                                  hintText: 'Kw',
                                  backgroundColor: Colors.transparent,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ):SizedBox.shrink(),
                        verticalSpace(30),
                        CustomInput(
                          title: 'Used Since',
                          image: 'images/png/us.png',
                          endWidget: SizedBox(
                            width: 247.w,
                            height: 52.5.h,
                            child: CustomDropdown(
                              value: AddNewCarCubit.get(
                                context,
                              ).yearsSince[AddNewCarCubit.get(
                                context,
                              ).selectedUsedSinceIndex].name,
                              backGround: Colors.transparent,
                              items:
                                  AddNewCarCubit.get(
                                    context,
                                  ).yearsSince.map((e) => e.name).toList(),
                              onChanged: (v)  {
                            final cubit = AddNewCarCubit.get(context);
                            final selectedIndex = cubit.yearsSince.indexWhere((e) => e.name == v);
                            if (selectedIndex != -1) {
                            cubit.chooseUsedSince(selectedIndex); // Send the index of selected value
                            }
                            },
                            ),
                          ),
                        ),
                        verticalSpace(30),
                        CustomInput(
                          title: 'Body Style',
                          image: 'images/png/bs.png',
                          endWidget: SizedBox(
                            width: 247.w,
                            height: 52.5.h,
                            child: CustomDropdown(
                              value:
                                  AddNewCarCubit.get(context).carStyles[ AddNewCarCubit.get(context).selectedBodyStyleIndex].name,
                              backGround: Colors.transparent,
                              items:
                                  AddNewCarCubit.get(
                                    context,
                                  ).carStyles.map((e) => e.name).toList(),
                              onChanged: (v) {
    final cubit = AddNewCarCubit.get(context);
    final selectedIndex = cubit.carStyles.indexWhere((e) => e.name == v);
    if (selectedIndex != -1) {
    cubit.chooseBodyStyle(selectedIndex); }
                              },
                            ),
                          ),
                        ),
                        verticalSpace(30),
                        BlocBuilder<AddNewCarCubit, AddNewCarState>(
                          builder: (context, state) {
                            final cubit = AddNewCarCubit.get(context);
                            final chargeTypes = cubit.chargeTypes;
                            final selectedValue = chargeTypes.contains(cubit.chargeType)
                                ? cubit.chargeType
                                : chargeTypes.first;

                            return CustomInput(
                              title: 'Charge Type',
                              image: 'images/png/ct.png',
                              endWidget: SizedBox(
                                width: 247.w,
                                height: 52.5.h,
                                child: CustomDropdown(
                                  value: selectedValue,
                                  backGround: Colors.transparent,
                                  items: chargeTypes,
                                  onChanged: (v) {
                                    final selectedIndex = chargeTypes.indexOf(v!);
                                    if (selectedIndex != -1) {
                                      cubit.chooseChargeType(selectedIndex);
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                  verticalSpace(16),
                  Center(
                    child: AppTextButton(
                      buttonText: 'Submit',
                      backgroundColor: ColorsManager.darkBlue.withOpacity(0.27),
                      buttonWidth: 310,
                      buttonHeight: 55.h,
                      borderRadius: 30.r,
                      textStyle: TextStyles.inter19BlackBold.copyWith(
                        color: Colors.white,
                      ),
                      onPressed: () {
                        AddNewCarCubit.get(context).postCar(title.text,description.text,price.text,enginePower.text,batteryCapacity.text,km.text);
                       // context.pushNamed(Routes.addNewCarDtails);
                      },
                    ),
                  )  ,
                  verticalSpace(16),
                  AddCarStatesUi()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.title,
    required this.image,
    required this.endWidget,
  });
  final String title;
  final String image;
  final Widget endWidget;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(image, height: 56.h, width: 56.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.inter12WhiteRegular.copyWith(
                fontSize: 15.11.sp,
              ),
            ),
            verticalSpace(11),
            endWidget,
          ],
        ),
      ],
    );
  }
}

class CarModelSelector extends StatelessWidget {
  final String selectedModel;
  final String selectedYear;
  final List<String> models;
  final List<String> years;
  final Function(String?) onModelChanged;
  final Function(String?) onYearChanged;

  const CarModelSelector({
    super.key,
    required this.selectedModel,
    required this.selectedYear,
    required this.models,
    required this.years,
    required this.onModelChanged,
    required this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Car Model',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            SizedBox(
              width: 140.w,
              height: 40.h,
              child: CustomDropdown(
                value: selectedModel,
                items: models,
                onChanged: onModelChanged,
              ),
            ),

          ],
        ),
      ],
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final Function(String?) onChanged;
  final Color? backGround;
  const CustomDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    this.backGround,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: backGround ?? Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: Colors.black,
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
          items:
              items.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
