
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../theming/styles.dart';
import '../utils/assets.dart';
import 'custom_svg.dart';


class ErrorContainer extends StatelessWidget {
  const ErrorContainer({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.red
        )
      ),
      child: ListTile(
          leading: CustomSvg(imgPath: AssetsData.error,),
        title: Text(
                'S.of(context).sorry',
                style: TextStyles.font16WhiteRegular),
            onTap:() {
              
            },
            
    )
    );
  }
}
