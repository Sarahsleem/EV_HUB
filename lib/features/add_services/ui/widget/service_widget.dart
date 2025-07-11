import 'package:flutter/material.dart';

import '../../../../core/theming/styles.dart';

class InsuranceHeaderCard extends StatelessWidget {
  final String iconPath;
  final String title;

  const InsuranceHeaderCard({super.key, required this.iconPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF1C434A), Color(0xFF365A5F)],
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              iconPath,
              height: 40,
              width: 40,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyles.latoWhite21SemiBold),

                Text(
                  "Fill Car Insurance Service Request",
                  style: TextStyles.latoWhite9SemiBold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
