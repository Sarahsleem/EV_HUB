import 'dart:ui';

import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/features/car_details/data/user_model.dart';
import 'package:evhub/features/home/logic/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class ContactInfoCard extends StatelessWidget {
//   final String imageUrl;
//   final String name;
//   final String role;
//   final VoidCallback onContactTap; // Callback for the "Contact Info" button
//   final VoidCallback? onCardTap; // Optional callback for tapping the whole card

//   const ContactInfoCard({
//     Key? key,
//     required this.imageUrl,
//     required this.name,
//     required this.role,
//     required this.onContactTap,
//     this.onCardTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onCardTap, // Use the card tap callback here
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(28),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 5,
//               blurRadius: 15,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min, // Make the column wrap its content
//           children: [
//             // Avatar with black background circle
//             CircleAvatar(
//               radius: 60, // Radius for the outer black circle
//               backgroundColor: Colors.black,
//               child: CircleAvatar(
//                 radius: 55, // Radius for the inner image
//                 backgroundImage: NetworkImage(imageUrl), // Use NetworkImage for URLs
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Name Text
//             Text(
//               name,
//               style: const TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 6),

//             // Role Text
//             Text(
//               role,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//             const SizedBox(height: 24),

//             // Contact Info Button
//             ElevatedButton(
//               onPressed: onContactTap, // Use the button tap callback here
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF2E3A48), // Dark blue/grey color
//                 foregroundColor: Colors.white, // Text color
//                 padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30), // Pill shape
//                 ),
//               ),
//               child: const Text(
//                 "Contact Info",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//

class ContactInfoCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String role;

  final VoidCallback onTap;

  const ContactInfoCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.role,
    required this.onTap,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 35, // Adjusted radius for smaller card
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 32, // Adjusted radius
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(role, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E3A48),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: const Text("Contact Info"),
          ),
        ],
      ),
    );
  }
}

class OwnerAndLocationSection extends StatelessWidget {
  // Assuming 'data.author!' comes from somewhere, e.g., your car model
  // نفترض أن 'data.author!' يأتي من مكان ما، مثل موديل السيارة
  final int authorId;
  final MockApiService apiService =
      MockApiService(); // Use your real ApiService

  OwnerAndLocationSection({Key? key, required this.authorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<UserModel?>(
            future: HomeCubit.get(
              context,
            ).fetchUserById(authorId), // استدعاء API
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading state that matches the card dimensions
                return const Row(
                  children: [
                    Expanded(child: PlaceholderCard()),
                    SizedBox(width: 16),
                    Expanded(child: PlaceholderCard()),
                  ],
                );
              } else if (snapshot.hasError || snapshot.data == null) {
                return const Center(child: Text("Failed to load owner data"));
              } else {
                final user = snapshot.data!;
                // The main row for both cards
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Owner Info Card
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          context.pushNamed(Routes.carOwnerProfile,arguments: user);
                        },
                        child: ContactInfoCard(
                          name: user.name,
                          role: "Car Owner",
                          imageUrl:
                              user.profileImage ??
                              "https://via.placeholder.com/150",
                          onTap: () {
                            print("Contact Card Tapped!");
                            // Example action: Show a dialog with phone number
                            showDialog(
                              context: context,
                              builder:
                                  (_) => AlertDialog(
                                    title: Text(user.name),
                                    content: Text("Phone: ${user.phoneNumber}"),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Space between cards

                    // Location Card
                  ],
                );
              }
            },
          ),
        );
      },
    );
  }
}

class MockUserModel {
  final String id;
  final String name;
  final String? profileImage;
  final String phoneNumber;

  MockUserModel({
    required this.id,
    required this.name,
    this.profileImage,
    required this.phoneNumber,
  });
}

class MockApiService {
  Future<MockUserModel> fetchUserById(String userId) {
    return Future.delayed(const Duration(seconds: 2), () {
      return MockUserModel(
        id: userId,
        name: "Omar Ahmed",
        profileImage:
            "https://i.pinimg.com/originals/a6/58/32/a65832154622ac17233687dd8fc40869.png",
        phoneNumber: "+1234567890",
      );
    });
  }
}

class PlaceholderCard extends StatelessWidget {
  const PlaceholderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 195, // Match the approximate height of the final cards
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
