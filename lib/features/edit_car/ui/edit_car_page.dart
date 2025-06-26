import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/features/home/data/model/car_model.dart';
import 'package:evhub/features/home/logic/home_cubit.dart' show HomeCubit;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../../../core/widgets/image_network.dart';
import '../../add_new_car/logic/add_new_car_cubit.dart';
import '../../add_new_car/ui/screens/add_car_details_screen.dart';
import '../logic/edit_car_cubit.dart';
import 'edit_car_states_ui.dart';

class EditCarPage extends StatefulWidget {
  const EditCarPage({super.key, required this.car});
  final Car car;
  @override
  State<EditCarPage> createState() => _EditCarPageState();
}

class _EditCarPageState extends State<EditCarPage> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController enginePower = TextEditingController();
  TextEditingController batteryCapacity = TextEditingController();
  TextEditingController km = TextEditingController();
  @override
  @override
  void initState() {
    super.initState();

    final car = widget.car;

    title.text = car.title ?? '';
    description.text = car.content ?? '';

    final rawPrice = car.acf?['price'];
    price.text = rawPrice != null
        ? NumberFormat("#,###").format(rawPrice)
        : '0';

    enginePower.text = car.acf?['motor_power_electric_horsepower_hp']?.toString() ?? '';
    batteryCapacity.text = car.acf?['battery_capacity']?.toString() ?? '';
    km.text = car.acf?['km']?.toString() ?? '';

    final editCubit = EditCarCubit.get(context);
    editCubit.setCondition(car.condition?.isEmpty ?? true ? 13 : car.condition?.first['id']);
    editCubit.setChargeType(car.acf?['compatible_charger_type'] ?? 'GPT');
    editCubit.setUsedSince(car.usedSince?.isEmpty ?? true ? 43 : car.usedSince?.first['id']);
    editCubit.setBodyStyle(car.bodyStyle?.isEmpty ?? true ? 39 : car.bodyStyle?.first['id']);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EditCarCubit, EditCarState>(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.zero,
                              onPressed: () => context.pop(),
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 18.sp,
                              ),
                            ),
                            SizedBox(width: 24.w),
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Edit ',
                                style: TextStyles.inter18WhiteMedium.copyWith(
                                  fontSize: 43.4.sp,
                                  color: Colors.white.withOpacity(0.42),
                                ),
                              ),
                              TextSpan(
                                text: 'Car Details',
                                style: TextStyles.inter18WhiteMedium.copyWith(
                                  fontSize: 43.4.sp,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand Logo Selector
                        GestureDetector(
                          onTap: () {
                            // Show brand selector
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                              ),
                              builder: (_) {
                                final brands = HomeCubit.get(context).carBrands;
                                return ListView.separated(
                                  padding: EdgeInsets.all(16.w),
                                  itemCount: brands.length,
                                  separatorBuilder: (_, __) => Divider(),
                                  itemBuilder: (context, index) {
                                    final brand = brands[index];
                                    return ListTile(
                                      onTap: () {
                                        // Update in Cubit
                                        EditCarCubit.get(context).chooseBrand(index, brand.id);
                                        Navigator.pop(context); // Close sheet
                                      },
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(brand.acf.brandLogo.url),
                                        radius: 25.r,
                                      ),
                                      title: Text(
                                        brand.name,
                                        style: TextStyles.inter16greyMedium,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: AppCachedNetworkImage(
                            fit: BoxFit.scaleDown,
                            radius: 39.5.r,
                            image: widget.car.carBrand!.isNotEmpty
                                ? HomeCubit.get(context)
                                .carBrands
                                .firstWhere(
                                  (brand) => brand.id == widget.car.carBrand?.first['id'],
                              orElse: () => HomeCubit.get(context).carBrands.first,
                            )
                                .acf
                                .brandLogo
                                .url
                                : '',
                            height: 75.h,
                            width: 75.w,
                          ),
                        ),

                        horizontalSpace(15.9.sp),

                        // Car Model & Brand Dropdown
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarModelSelector(
                              selectedModel: widget.car.model!.isNotEmpty
                                  ? widget.car.model?.first['name']
                                  : 'X1',
                              selectedBrand: widget.car.carBrand!.isNotEmpty
                                  ? HomeCubit.get(context)
                                  .carBrands
                                  .firstWhere(
                                    (brand) => brand.id == widget.car.carBrand?.first['id'],
                                orElse: () => HomeCubit.get(context).carBrands.first,
                              )
                                  .name
                                  : HomeCubit.get(context).carBrands.first.name,
                              brands: HomeCubit.get(context).carBrands.map((e) => e.name).toList(),
                              models: EditCarCubit.get(context)
                                  .carModel
                                  .map((e) => e.name)
                                  .toList(),
                              onModelChanged: (value) {
                                final cubit = EditCarCubit.get(context);
                                final selectedIndex = cubit.carModel.indexWhere((e) => e.name == value);
                                if (selectedIndex != -1) {
                                  cubit.chooseCarModel(selectedIndex);
                                }
                              },
                              onBrandChanged: (value) {
                                final selected = HomeCubit.get(context)
                                    .carBrands
                                    .firstWhere((brand) => brand.name == value);

                                EditCarCubit.get(context).chooseBrand(
                                  HomeCubit.get(context).carBrands.indexOf(selected),
                                  selected.id,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
,
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
                              EditCarCubit.get(context).chooseCondition(0);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    EditCarCubit.get(
                                              context,
                                            ).selectedConditionId ==
                                            14
                                        ? Colors.transparent
                                        : Colors.black,
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
                              EditCarCubit.get(context).chooseCondition(1);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    EditCarCubit.get(
                                              context,
                                            ).selectedConditionId ==
                                            14
                                        ? Colors.black
                                        : Colors.transparent,
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
                              hintText:
                                  widget.car.title!.isEmpty
                                      ? 'Car Title'
                                      : widget.car.title!,
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
                              hintText:
                                  widget.car.content!.isEmpty
                                      ? 'Car Description'
                                      : widget.car.content!,
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
                        BlocBuilder<EditCarCubit, EditCarState>(
                          builder: (context, state) {
                            final cubit = EditCarCubit.get(context);
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
                                    child:
                                        isLoading
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
                                                  style:
                                                      TextStyles
                                                          .inter10GreySemiBold,
                                                ),
                                              ],
                                            ),
                                  ),
                                ),
                                if (widget.car.featuredImage != null )
                                  AppCachedNetworkImage(
                                    radius: 10,
                                    image: widget.car.featuredImage!,
                                      width: 100.w,
                                      height: 100.h,
                                      fit: BoxFit.cover,

                                  ),
                                SizedBox(height: 12.h),

                                /// Show picked featured image
                                if (cubit.image != null &&
                                    cubit.image!.existsSync())
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
                        BlocBuilder<EditCarCubit, EditCarState>(
                          builder: (context, state) {
                            final cubit = EditCarCubit.get(context);
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
                                    child:
                                        isLoading
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
                                                  style:
                                                      TextStyles
                                                          .inter10GreySemiBold,
                                                ),
                                                Text(
                                                  'max. 8 Photos',
                                                  style:
                                                      TextStyles
                                                          .inter10GreySemiBold,
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
                                    children:
                                        cubit.selectedImages
                                            .map(
                                              (file) => ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                child: Image.file(
                                                  file,
                                                  width: 80.w,
                                                  height: 80.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
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
                              hintText:
                                  '${widget.car.acf!["price"] == null ? 0 : NumberFormat("#,###").format(double.tryParse(widget.car.acf!["price"].toString()) ?? 'N/A')} LE',
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
                              hintText:
                                  widget.car.acf?['motor_power_hp']
                                      .toString() ??
                                  'HP',
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
                              hintText:
                                  widget.car.acf?['battery_capacity']
                                      .toString() ??
                                  'Kwh',
                              backgroundColor: Colors.transparent,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        EditCarCubit.get(context).selectedConditionId == 14
                            ? Column(
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
                                      hintText:
                                          widget.car.acf!["km"] == null
                                              ? 'Kw'
                                              : widget.car.acf!["km"]
                                                  .toString(),
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
                            )
                            : SizedBox.shrink(),
                        verticalSpace(30),
                        CustomInput(
                          title: 'Used Since',
                          image: 'images/png/us.png',
                          endWidget: SizedBox(
                            width: 247.w,
                            height: 52.5.h,
                            child: CustomDropdown(
                              value:
                                  EditCarCubit.get(context)
                                      .yearsSince[EditCarCubit.get(
                                        context,
                                      ).selectedUsedSinceIndex]
                                      .name,
                              backGround: Colors.transparent,
                              items:
                                  EditCarCubit.get(
                                    context,
                                  ).yearsSince.map((e) => e.name).toList(),
                              onChanged: (v) {
                                final cubit = EditCarCubit.get(context);
                                final selectedIndex = cubit.yearsSince
                                    .indexWhere((e) => e.name == v);
                                if (selectedIndex != -1) {
                                  cubit.chooseUsedSince(
                                    selectedIndex,
                                  ); // Send the index of selected value
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
                                  EditCarCubit.get(context)
                                      .carStyles[EditCarCubit.get(
                                        context,
                                      ).selectedBodyStyleIndex]
                                      .name,
                              backGround: Colors.transparent,
                              items:
                                  EditCarCubit.get(
                                    context,
                                  ).carStyles.map((e) => e.name).toList(),
                              onChanged: (v) {
                                final cubit = EditCarCubit.get(context);
                                final selectedIndex = cubit.carStyles
                                    .indexWhere((e) => e.name == v);
                                if (selectedIndex != -1) {
                                  cubit.chooseBodyStyle(selectedIndex);
                                }
                              },
                            ),
                          ),
                        ),
                        verticalSpace(30),
                        BlocBuilder<EditCarCubit, EditCarState>(
                          builder: (context, state) {
                            final cubit = EditCarCubit.get(context);
                            final chargeTypes = cubit.chargeTypes;
                            final selectedValue =
                                chargeTypes.contains(cubit.chargeType)
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
                                    final selectedIndex = chargeTypes.indexOf(
                                      v!,
                                    );
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
                        EditCarCubit.get(context).updateCar(
                          title.text,
                          description.text,
                          price.text,
                          enginePower.text,
                          batteryCapacity.text,
                          km.text,
                          widget.car.id!,
                        );
                        // context.pushNamed(Routes.addNewCarDtails);
                      },
                    ),
                  ),
                  verticalSpace(16),
                  EditCarStatesUi(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
class CarModelSelector extends StatelessWidget {
  final String selectedModel;
  final String selectedBrand;
  final List<String> models;
  final List<String> brands;
  final Function(String?) onModelChanged;
  final Function(String?) onBrandChanged;

  const CarModelSelector({
    super.key,
    required this.selectedModel,
    required this.selectedBrand,
    required this.models,
    required this.brands,
    required this.onModelChanged,
    required this.onBrandChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Car Brand',
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
                  width: 155.w,
                  height: 40.h,
                  child: CustomDropdown(
                    value: selectedBrand,
                    items: brands,
                    onChanged: onBrandChanged,
                  ),
                ),

              ],
            ),
          ],
        ), Column(
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
                  width: 100.w,
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
        ),
      ],
    );
  }
}