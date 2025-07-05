import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UiLoadingProfile extends StatelessWidget {
  const UiLoadingProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Skeleton avatar
        Skeletonizer(

          enabled: true,
          child: Container(
            width: 56, // CircleAvatar with radius 28
            height: 56,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Skeleton text placeholders
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: 150,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        )
      ],
    );
  }
}
