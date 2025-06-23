import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactInfoCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String role;
  final VoidCallback onContactTap; // Callback for the "Contact Info" button
  final VoidCallback? onCardTap; // Optional callback for tapping the whole card

  const ContactInfoCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.role,
    required this.onContactTap,
    this.onCardTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap, // Use the card tap callback here
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Make the column wrap its content
          children: [
            // Avatar with black background circle
            CircleAvatar(
              radius: 60, // Radius for the outer black circle
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 55, // Radius for the inner image
                backgroundImage: NetworkImage(imageUrl), // Use NetworkImage for URLs
              ),
            ),
            const SizedBox(height: 20),

            // Name Text
            Text(
              name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),

            // Role Text
            Text(
              role,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // Contact Info Button
            ElevatedButton(
              onPressed: onContactTap, // Use the button tap callback here
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E3A48), // Dark blue/grey color
                foregroundColor: Colors.white, // Text color
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Pill shape
                ),
              ),
              child: const Text(
                "Contact Info",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}