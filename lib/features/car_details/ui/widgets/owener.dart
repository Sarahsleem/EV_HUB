import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/ui/screen/one_service_details.dart' ;
import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/features/car_details/data/user_model.dart';
import 'package:evhub/features/home/logic/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'as fa;
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
                          // CORRECT CODE
                          onTap: () {
                            print("Contact Card Tapped!");
                            // Just call the function directly to show the bottom sheet.
                            // No need for showDialog.
                            showContactOptionsSheet(context, user );
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


 // For WhatsApp Icon

// A placeholder for your User class


// This function replaces your showDialog(builder: ...) call
void showContactOptionsSheet(BuildContext context, UserModel user) {
  // Helper function to safely launch URLs
  Future<void> _launchUrl(String url, String scheme) async {
    final uri = Uri(scheme: scheme, path: url);

      await launchUrl(uri);

  }

  showModalBottomSheet(
    context: context,
    // This makes the background transparent, so we can have rounded corners
    backgroundColor: Colors.transparent,
    builder: (BuildContext bc) {
      return SafeArea(
        child: Padding(
          // Horizontal padding for the entire sheet
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Use minimum space
            children: <Widget>[
              // Upper container with contact options
              Container(
                decoration: BoxDecoration(
                  // Using a slightly off-white color like iOS
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: fa.FaIcon(
                        fa.FontAwesomeIcons.whatsapp , // The real WhatsApp icon
                        color: Colors.green,
                      ),
                      title: const Text(
                        'Chat on Whatsapp',
                        style: TextStyle(color: Color(0xFF007AFF), fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        whatsapp(user.phoneNumber.replaceAll(RegExp(r'[^\d]'), ''));
                        // Close the sheet
                        // IMPORTANT: The number should be in international format
                        // e.g., for +1 (555) 123-4567, use '15551234567'
                       // _launchUrl(user.phoneNumber.replaceAll(RegExp(r'[^\d]'), ''), 'https');
                      },
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.grey.shade600,
                      ),
                      title: Text(
                        'Call ${user.phoneNumber}',
                        style: const TextStyle(color: Color(0xFF007AFF), fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.pop(context); // Close the sheet
                        _launchUrl(user.phoneNumber, 'tel');
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Cancel button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF767676), // A medium grey
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8), // Padding at the very bottom
            ],
          ),
        ),
      );
    },
  );
}