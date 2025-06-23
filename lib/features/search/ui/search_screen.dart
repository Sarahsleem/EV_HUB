import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String selectedType = 'Used';
  String selectedInstallment = 'Installment';
  RangeValues priceRange = RangeValues(0, 10_000_000_000);
  RangeValues squareFeetRange = RangeValues(0, 3200);

  List<String> bodyShapes = ['Hatchback', 'Sedan', 'Suv', 'Coupe'];
  String selectedBodyShape = 'Hatchback';
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
        child: SafeArea(child:  ListView(
          padding: EdgeInsets.symmetric(horizontal: 13.w),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Car Filter", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                Text("Reset all", style: TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 20),

            /// Car Type Dropdown
            DropdownButtonFormField<String>(
              dropdownColor: const Color(0xFF1C3A4A),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1C3A4A),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                hintText: 'Choose car brand',
                hintStyle: const TextStyle(color: Colors.white70),
              ),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              items: ['BMW', 'Audi', 'Toyota']
                  .map((brand) => DropdownMenuItem(value: brand, child: Text(brand, style: const TextStyle(color: Colors.white))))
                  .toList(),
              onChanged: (value) {},
            ),

            const SizedBox(height: 20),

            /// Type Toggle
            _buildToggle('Type', ['Used', 'New'], selectedType, (val) {
              setState(() => selectedType = val);
            }),

            const SizedBox(height: 20),

            /// Installment Toggle
            _buildToggle('Installments', ['Installment', 'no Installment'], selectedInstallment, (val) {
              setState(() => selectedInstallment = val);
            }),

            const SizedBox(height: 20),

            /// Price Range
            const Text("Price range", style: TextStyle(color: Colors.white)),
            Row(
              children: [
                Expanded(child: _buildMinMaxField("Min")),
                const SizedBox(width: 10),
                Expanded(child: _buildMinMaxField("Max")),
              ],
            ),
            RangeSlider(
              values: priceRange,
              min: 0,
              max: 10_000_000_000,
              divisions: 100,
              labels: RangeLabels('\$${priceRange.start.toInt()}', '\$${priceRange.end.toInt()}'),
              onChanged: (val) => setState(() => priceRange = val),
              activeColor: Colors.greenAccent,
              inactiveColor: Colors.green.withOpacity(0.3),
            ),

            const SizedBox(height: 20),

            /// Square feet
            const Text("Square feet", style: TextStyle(color: Colors.white)),
            Row(
              children: [
                Expanded(child: _buildMinMaxField("Min")),
                const SizedBox(width: 10),
                Expanded(child: _buildMinMaxField("Max")),
              ],
            ),
            RangeSlider(
              values: squareFeetRange,
              min: 0,
              max: 3200,
              divisions: 100,
              labels: RangeLabels('${squareFeetRange.start.toInt()}', '${squareFeetRange.end.toInt()}'),
              onChanged: (val) => setState(() => squareFeetRange = val),
              activeColor: Colors.greenAccent,
              inactiveColor: Colors.green.withOpacity(0.3),
            ),

            const SizedBox(height: 20),

            /// Body Shape
            const Text("Body Shape", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: bodyShapes
                  .map((shape) => ChoiceChip(
                label: Text(shape),
                selected: selectedBodyShape == shape,
                selectedColor: Colors.green,
                onSelected: (_) => setState(() => selectedBodyShape = shape),
              ))
                  .toList(),
            ),
          ],
        ),),
      ),
    );
  }

  Widget _buildToggle(String label, List<String> options, String selected, void Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        Row(
          children: options.map((option) {
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
                  child: Text(option, style: const TextStyle(color: Colors.white)),
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _buildMinMaxField(String hint) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white60),
        filled: true,
        fillColor: const Color(0xFF1C3A4A),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
    );
  }
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
