import 'package:flutter/material.dart';

import 'package:primed_health/common/route_constants.dart';
import 'package:primed_health/common/size_constants.dart';
import 'package:primed_health/common/text_constants.dart';
import 'package:primed_health/common/asset_constants.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:primed_health/presentation/widgets/common/cta_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

late Size size;

class Landing extends StatelessWidget {

  const Landing({super.key});

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetConstants.landingBg, ),
              fit: BoxFit.cover
            )
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                left: Sizes.dimen_16.w,
                right: Sizes.dimen_16.w,
                bottom: Sizes.dimen_50.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextConstants.healthCareDelivery,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: Sizes.dimen_24.sp,
                          color: AppColors.grey700
                      ),
                    ),
                    SizedBox(height: Sizes.dimen_15.h,),

                    Text(
                      TextConstants.landingDescription,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: Sizes.dimen_14.sp,
                          color: AppColors.lightWhite
                      ),
                    ),
                    SizedBox(height: Sizes.dimen_45.h,),

                    CTAButton(
                      title: TextConstants.continueText,
                      color: AppColors.lightWhite,
                      height: Sizes.dimen_50,
                      isEnabled: true,
                      isMini: false,
                      isBorderedButton: false,
                      textColor: AppColors.primaryColor,
                      onClick: ()=> Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.createAccountRoute, (route) => false),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}