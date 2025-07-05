import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:evhub/features/home/logic/home_cubit.dart';
import 'package:evhub/features/search/ui/search_states_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/l10n.dart';
import '../../add_new_car/data/model/field_model.dart';
import '../logic/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController minPrice = TextEditingController();
  TextEditingController maxPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/png/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<SearchCubit, SearchState>(
  builder: (context, state) {
    return ListView(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).CarFilter,
                    style: TextStyles.inter14WhiteSemiBold.copyWith(
                      fontSize: 19.4.sp,
                    ),
                  ),
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          SearchCubit.get(context).reset();
                          maxPrice.clear();
                          minPrice.clear();
                        },
                        child: Text(
                          S.of(context).Resetall,
                          style: TextStyles.inter18WhiteMedium.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// Car Type Dropdown
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final brands = HomeCubit.get(context).carBrands;

                  return DropdownButtonFormField<String>(
                    dropdownColor: const Color(0xFF1C3A4A),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF1C3A4A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: S.of(context).ChoosecarBrand,

                      hintStyle: const TextStyle(color: Colors.white70),
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    items:
                        brands
                            .map(
                              (brand) => DropdownMenuItem<String>(
                                value: brand.name,
                                child: Text(
                                  brand.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        SearchCubit.get(context).selectedBrand = value!;
                      });
                      // Handle brand selection
                    },
                  );
                },
              ),

              const SizedBox(height: 20),

              /// Type Toggle
              _buildToggle(
                S.of(context).Type,
                [S.of(context).Used, S.of(context).New],
                SearchCubit.get(context).selectedCondition,
                (val) {
                  SearchCubit.get(context).selectCondition(val);
                },
              ),

              const SizedBox(height: 20),

              /// Installment Toggle
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      CustomDropdown(
                        hint: S.of(context).Choosecarmodel,
                        items: buildDropdownItems(
                          SearchCubit.get(context).carStyles,
                        ),
                        onChanged: (value) {
                          setState(() {
                            SearchCubit.get(context).selectedstyle = value!;
                          });
                          // handle selection
                        },
                      ),
                      verticalSpace(20),
                      CustomDropdown(
                        hint: S.of(context).Chooseyear,
                        items: buildDropdownItems(
                          SearchCubit.get(context).yearsSince,
                        ),
                        onChanged: (value) {
                          setState(() {
                            SearchCubit.get(context).selectedSince = value!;
                          });
                          // handle selection
                        },
                      ),

                      // CustomDropdown(
                      //   hint: 'Choose condition',
                      //   items: buildConditionItems(SearchCubit.get(context).conditions),
                      //   onChanged: (value) {
                      //     // handle selection
                      //   },
                      // ),
                      verticalSpace(20),
                      CustomDropdown(
                        hint: S.of(context).Choosecarmodel,
                        items: buildDropdownItems(
                          SearchCubit.get(context).carModel,
                        ),
                        onChanged: (value) {
                          setState(() {
                            SearchCubit.get(context).selectedModel = value!;
                          });
                          // handle selection
                        },
                      ),
                      SearchStateUi(),
                    ],
                  );
                },
              ),

              const SizedBox(height: 20),

              /// Price Range
              Text(S.of(context).Pricerange, style: TextStyles.inter14WhiteSemiBold),
              verticalSpace(20),
              Row(
                children: [
                  Expanded(child: _buildMinMaxField(S.of(context).Min, minPrice)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildMinMaxField(S.of(context).Max, maxPrice)),
                ],
              ),
              verticalSpace(40),
              AppTextButton(
                buttonText: S.of(context).Search,
                textStyle: TextStyles.inter18WhiteMedium,
                onPressed: () {
                  try {
                    final min =
                        minPrice.text.trim().isEmpty
                            ? 0
                            : int.parse(minPrice.text.trim());
                    final max =
                        maxPrice.text.trim().isEmpty
                            ? 999999999
                            : int.parse(maxPrice.text.trim());

                    if (min > max) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            S.of(context).Minpricecane,
                          ),
                        ),
                      );
                      return;
                    }

                    SearchCubit.get(context).search(min, max);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter valid numbers")),
                    );
                  }
                },

                buttonWidth: 200,
                backgroundColor: Color(0xff72A850),
              ),
              // RangeSlider(
              //   values: priceRange,
              //   min: 0,
              //   max: 10_000_000_000,
              //   divisions: 100,
              //   labels: RangeLabels('\$${priceRange.start.toInt()}', '\$${priceRange.end.toInt()}'),
              //   onChanged: (val) => setState(() => priceRange = val),
              //   activeColor: Colors.greenAccent,
              //   inactiveColor: Colors.green.withOpacity(0.3),
              // ),
              //
              // const SizedBox(height: 20),

              /// Square feet

              /// Body Shape
              // const Text("Body Shape", style: TextStyle(color: Colors.white)),
              // const SizedBox(height: 10),
              // Wrap(
              //   spacing: 10,
              //   children: bodyShapes
              //       .map((shape) => ChoiceChip(
              //     label: Text(shape),
              //     selected: selectedBodyShape == shape,
              //     selectedColor: Colors.green,
              //     onSelected: (_) => setState(() => selectedBodyShape = shape),
              //   ))
              //       .toList(),
              // ),
            ],
          );
  },
),
        ),
      ),
    );
  }

  Widget _buildToggle(
    String label,
    List<String> options,
    String selected,
    void Function(String) onSelect,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.inter14WhiteSemiBold),
        const SizedBox(height: 8),
        Row(
          children:
              options.map((option) {
                final isSelected = selected == option;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onSelect(option),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green : Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        option,
                        style: TextStyles.inter18WhiteMedium.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildMinMaxField(String hint, TextEditingController con) {
    return TextField(
      controller: con,
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white60),
        filled: true,
        fillColor: const Color(0xFF1C3A4A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String hint;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChanged;
  final String? value;

  const CustomDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor: const Color(0xFF1C3A4A),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1C3A4A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
      ),
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
      items: items,
      onChanged: onChanged,
    );
  }
}

List<DropdownMenuItem<String>> buildDropdownItems(List<fieldsModel> list) {
  return list
      .map(
        (item) => DropdownMenuItem(
          value: item.name,
          child: Text(item.name, style: const TextStyle(color: Colors.white)),
        ),
      )
      .toList();
}

//
// class CarFilterScreen extends StatefulWidget {
//   @override
//   State<CarFilterScreen> createState() => _CarFilterScreenState();
// }
//
// class _CarFilterScreenState extends State<CarFilterScreen> {
//   String selectedType = 'Used';
//   String selectedInstallment = 'Installment';
//   RangeValues priceRange = RangeValues(0, 10_000_000_000);
//   RangeValues squareFeetRange = RangeValues(0, 3200);
//
//   List<String> bodyShapes = ['Hatchback', 'Sedan', 'Suv', 'Coupe'];
//   String selectedBodyShape = 'Hatchback';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0F2D3C),
//       appBar: AppBar(
//         title: const Text("Search a Car"),
//         backgroundColor: const Color(0xFF0F2D3C),
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.tune),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text("Car Filter", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
//                 Text("Reset all", style: TextStyle(color: Colors.white)),
//               ],
//             ),
//             const SizedBox(height: 20),
//
//             /// Car Type Dropdown
//             DropdownButtonFormField<String>(
//               dropdownColor: const Color(0xFF1C3A4A),
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: const Color(0xFF1C3A4A),
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
//                 hintText: 'Choose car brand',
//                 hintStyle: const TextStyle(color: Colors.white70),
//               ),
//               icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
//               items: ['BMW', 'Audi', 'Toyota']
//                   .map((brand) => DropdownMenuItem(value: brand, child: Text(brand, style: const TextStyle(color: Colors.white))))
//                   .toList(),
//               onChanged: (value) {},
//             ),
//
//             const SizedBox(height: 20),
//
//             /// Type Toggle
//             _buildToggle('Type', ['Used', 'New'], selectedType, (val) {
//               setState(() => selectedType = val);
//             }),
//
//             const SizedBox(height: 20),
//
//             /// Installment Toggle
//             _buildToggle('Installments', ['Installment', 'no Installment'], selectedInstallment, (val) {
//               setState(() => selectedInstallment = val);
//             }),
//
//             const SizedBox(height: 20),
//
//             /// Price Range
//             const Text("Price range", style: TextStyle(color: Colors.white)),
//             Row(
//               children: [
//                 Expanded(child: _buildMinMaxField("Min")),
//                 const SizedBox(width: 10),
//                 Expanded(child: _buildMinMaxField("Max")),
//               ],
//             ),
//             RangeSlider(
//               values: priceRange,
//               min: 0,
//               max: 10_000_000_000,
//               divisions: 100,
//               labels: RangeLabels('\$${priceRange.start.toInt()}', '\$${priceRange.end.toInt()}'),
//               onChanged: (val) => setState(() => priceRange = val),
//               activeColor: Colors.greenAccent,
//               inactiveColor: Colors.green.withOpacity(0.3),
//             ),
//
//             const SizedBox(height: 20),
//
//             /// Square feet
//             const Text("Square feet", style: TextStyle(color: Colors.white)),
//             Row(
//               children: [
//                 Expanded(child: _buildMinMaxField("Min")),
//                 const SizedBox(width: 10),
//                 Expanded(child: _buildMinMaxField("Max")),
//               ],
//             ),
//             RangeSlider(
//               values: squareFeetRange,
//               min: 0,
//               max: 3200,
//               divisions: 100,
//               labels: RangeLabels('${squareFeetRange.start.toInt()}', '${squareFeetRange.end.toInt()}'),
//               onChanged: (val) => setState(() => squareFeetRange = val),
//               activeColor: Colors.greenAccent,
//               inactiveColor: Colors.green.withOpacity(0.3),
//             ),
//
//             const SizedBox(height: 20),
//
//             /// Body Shape
//             const Text("Body Shape", style: TextStyle(color: Colors.white)),
//             const SizedBox(height: 10),
//             Wrap(
//               spacing: 10,
//               children: bodyShapes
//                   .map((shape) => ChoiceChip(
//                 label: Text(shape),
//                 selected: selectedBodyShape == shape,
//                 selectedColor: Colors.green,
//                 onSelected: (_) => setState(() => selectedBodyShape = shape),
//               ))
//                   .toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildToggle(String label, List<String> options, String selected, void Function(String) onSelect) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: const TextStyle(color: Colors.white)),
//         const SizedBox(height: 8),
//         Row(
//           children: options.map((option) {
//             final isSelected = selected == option;
//             return Expanded(
//               child: GestureDetector(
//                 onTap: () => onSelect(option),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   decoration: BoxDecoration(
//                     color: isSelected ? Colors.green : Colors.grey.shade800,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(option, style: const TextStyle(color: Colors.white)),
//                 ),
//               ),
//             );
//           }).toList(),
//         )
//       ],
//     );
//   }
//
//   Widget _buildMinMaxField(String hint) {
//     return TextField(
//       style: const TextStyle(color: Colors.white),
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(color: Colors.white60),
//         filled: true,
//         fillColor: const Color(0xFF1C3A4A),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
//       ),
//     );
//   }
// }
