import 'package:flutter/material.dart';

import 'package:primed_health/common/asset_constants.dart';
import 'package:primed_health/common/size_constants.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:flutter_svg/flutter_svg.dart';

class CircleBackButton extends StatelessWidget {

  const CircleBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Navigator.pop(context),
      child: Container(
        width: Sizes.dimen_40,
        height: Sizes.dimen_40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.tealColor
        ),
        child: Center(
          child: SvgPicture.asset(AssetConstants.back),
          // child: Text(
          //   "<",
          //   style: TextStyle(
          //     color: AppColors.lightWhite,
          //     fontSize: Sizes.dimen_20,
          //     fontWeight: FontWeight.w500
          //   ),
          // )
        ),
      ),
    );
  }

}