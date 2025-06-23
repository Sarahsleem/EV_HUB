import 'package:carousel_slider/carousel_slider.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:evhub/core/widgets/image_network.dart';
import 'package:evhub/features/car_details/data/user_model.dart';
import 'package:evhub/features/car_details/ui/widgets/owener.dart';
import 'package:evhub/features/home/data/model/car_model.dart';
import 'package:evhub/features/home/logic/home_cubit.dart';
import 'package:evhub/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarDetailCard extends StatelessWidget {
  final Car car;

  const CarDetailCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final acf = car.acf ?? {};
    List<String> imagePaths = [];

    final images = acf['car_images'];
    if (images != null && images is List) {
      for (var image in images) {
        final metadata = image['metadata'];
        if (metadata != null) {
          imagePaths.add(
            metadata['full']?['file_url'] ??
                metadata['medium']?['file_url'] ??
                metadata['large']?['file_url'] ??
                '',
          );
        }
      }
    }

    return Container(
      margin: EdgeInsets.all(12.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.carBrand?.first.toString() ?? 'Brand',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          car.title ?? "Model",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[700],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '2025',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "${acf["price"]?.toStringAsFixed(0) ?? '0'},000 LE",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          /// Car Images
          if (imagePaths.isNotEmpty)
            CarouselSlider(
              options: CarouselOptions(
                height: 180.h,
                viewportFraction: 1.0,
                autoPlay: true,
              ),
              items:
                  imagePaths.map((url) {
                    return AppCachedNetworkImage(
                      image: url,
                      height: 180.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      radius: 12.r,
                    );
                  }).toList(),
            )
          else
            AppCachedNetworkImage(
              image: car.featuredImage ?? '',
              height: 180.h,
              width: double.infinity,
              fit: BoxFit.cover,
              radius: 12.r,
            ),
          SizedBox(height: 16.h),

          /// Battery Info
          Text('Battery Health', style: TextStyle(color: Colors.black)),
          Text(
            "${S.of(context).status}${car.status}",
            style: TextStyles.inter12WhiteRegular.copyWith(
              color: ColorsManager.lightGrey,
            ),
          ),

          SizedBox(height: 4.h),
          LinearProgressIndicator(
            value: 0.99,
            color: Colors.green,
            backgroundColor: Colors.grey[300],
            minHeight: 6.h,
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("99%", style: TextStyle(color: Colors.black)),
              Text("10 Km Mileage", style: TextStyle(color: Colors.black)),
              Text("⚡ 22kw", style: TextStyle(color: Colors.black)),
            ],
          ),

          SizedBox(height: 16.h),

          /// Car Specs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _SpecItem(
                title: S.of(context).Battery,
                value: "300",
                unit: "kwh",
                assetIcon:
                    "images/png/image 16 (3).png", // ضع مسار الأيقونة الصحيحة هنا
              ),

              _SpecItem(
                title: S.of(context).ChargeInfo,
                value: "${acf['range_per_charge_km'] ?? '--'} ",
                unit: 'km',
                assetIcon: 'images/png/image 16.png',
              ),
              _SpecItem(
                title: S.of(context).MotorPower,
                value: "${acf['motor_power_hp'] ?? '--'} ",
                unit: 'HP',
                assetIcon: 'images/png/image 16 (1).png',
              ),
              _SpecItem(
                title: "Battery",
                value: "${acf['battery_capacity'] ?? '--'} ",
                unit: 'kWh',
                assetIcon: 'images/png/image 16 (2).png',
              ),
              // _SpecItem(title: "Speed", value: "109 kWh", unit: '', assetIcon: '',), // ثابت من التصميم
              // _SpecItem(title: "Seats", value: "4"),
            ],
          ),

          SizedBox(height: 16.h),

          Text("Description", style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 8.h),
          Text(car.content ?? '', style: TextStyle(color: Colors.grey[700])),

          SizedBox(height: 20.h),

          /// Owner + Map
          FutureBuilder<UserModel?>(
            future: HomeCubit.get(context).fetchUserById(
              car.author ?? 1,
            ), // استدعاء API لجلب بيانات المستخدم1
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                return const Center(
                  child: Text("Failed to load owner data"),
                ); // "تعذر تحميل بيانات المالك"
              } else {
                final user = snapshot.data!;
                return ContactInfoCard(
                  name: user.name,
                  role: "Car Owner", // "مالك السيارة"
                  imageUrl:
                      user.profileImage ?? "https://via.placeholder.com/150",
                  // Action for the entire card tap
                  onCardTap: () {
                    print("Card Tapped! Navigating to profile...");
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ProfilePage1(user: user), // تمرير بيانات المستخدم
                    //   ),
                    // );
                  },
                  // Action for the "Contact Info" button
                  onContactTap: () {
                    print("Contact Info button tapped!");
                    print("User Phone: ${user.phoneNumber}");
                    // You can show a dialog, a bottom sheet, or launch the dialer
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: Text(user.name),
                            content: Text("Phone: ${user.phoneNumber}"),
                            actions: [
                              TextButton(
                                child: const Text("Close"),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                    );
                  },
                );
              }
            },
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
              fillColor: Colors.grey[100],
              hintText: "Add Comment",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 10.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecItem extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String assetIcon;

  const _SpecItem({
    required this.title,
    required this.value,
    required this.unit,
    required this.assetIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            assetIcon,
            width: 24.w,
            height: 24.h,
            color: Colors.grey[600],
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 8.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: ' $unit',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
