
import 'package:carousel_slider/carousel_slider.dart';
import 'package:evhub/core/widgets/image_network.dart';
import 'package:evhub/features/home/data/model/car_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CarDetailCard extends StatelessWidget {
  final Car car;

  const CarDetailCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    List<String> imagePaths = [];

final images = car.acf?['car_images'];
if (images != null && images is List) {
  for (var image in images) {
    final metadata = image['metadata'];
    if (metadata != null) {
      imagePaths.add(
        metadata['full']?['file_url'] ??
        metadata['medium']?['file_url'] ??
        metadata['large']?['file_url'] ??
        "https://your-default-image-url.com/default.jpg",
      );
    }
  }
}

    final acf = car.acf ?? {};
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1D2C33),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    car.title ?? "Unknown Car",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "${acf["price"]?.toStringAsFixed(0) ?? '0'} LE",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              "Electric 2025", // Placeholder model/year
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[400]),
            ),
            SizedBox(height: 16.h),

            /// Car Image
        Center(
    child: imagePaths.isNotEmpty
        ? CarouselSlider(
            options: CarouselOptions(
              height: 250.h,
              viewportFraction: 1.0,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: imagePaths.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return AppCachedNetworkImage(
                    image: url,
                    height: 250.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    radius: 16,
                  );
                },
              );
            }).toList(),
          )
        : AppCachedNetworkImage(
            image: car.featuredImage ?? '',
            height: 250.h,
            width: double.infinity,
            fit: BoxFit.cover,
            radius: 16,
          ),
  ),


            SizedBox(height: 16.h),

            /// Battery Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Battery Health", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text("⚡ 22kw", style: TextStyle(color: Colors.white)),
              ],
            ),
            SizedBox(height: 4.h),
            LinearProgressIndicator(
              value: 0.99,
              backgroundColor: Colors.grey.shade700,
              color: Colors.greenAccent,
              minHeight: 6.h,
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("99%", style: TextStyle(color: Colors.white)),
                Text("10 Km", style: TextStyle(color: Colors.white)),
              ],
            ),

            SizedBox(height: 16.h),

            /// Specs Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _SpecItem(title: "Range", value: "${acf['range_per_charge_km'] ?? '-'} Km"),
                _SpecItem(title: "Power", value: "${acf['motor_power_hp'] ?? '-'} HP"),
                _SpecItem(title: "Battery", value: "${acf['battery_capacity'] ?? '-'} kWh"),
              ],
            ),

            SizedBox(height: 20.h),

            /// Description
            Text("Description", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp)),
            SizedBox(height: 8.h),
            Text(
              car.content ?? "No description",
              style: TextStyle(color: Colors.grey.shade300, fontSize: 13.sp),
            ),

            SizedBox(height: 20.h),

            /// Owner Info & Map (Placeholder)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('images/png/pirson.png'),
                      radius: 26,
                    ),
                    const SizedBox(height: 4),
                    const Text("Omar Ahmed", style: TextStyle(color: Colors.white)),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Contact Info"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "assets/images/map.png",
                    width: 120.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            /// Rating
            Row(
              children: List.generate(5, (index) {
                return const Icon(Icons.star, color: Colors.amber, size: 20);
              }),
            ),

            SizedBox(height: 16.h),

            /// Comment Field
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Add Comment",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpecItem extends StatelessWidget {
  final String title;
  final String value;

  const _SpecItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
