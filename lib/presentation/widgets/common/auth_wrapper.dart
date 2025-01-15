import 'package:flutter/material.dart';

import 'package:primed_health/common/asset_constants.dart';
import 'package:primed_health/common/size_constants.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

late Size size;

class AuthWrapper extends StatelessWidget {

  final String title;
  final String subTitle;
  final Widget child;
  const AuthWrapper({super.key, required this.title, required this.subTitle, required this.child});

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Sizes.dimen_64,
                  width: size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AssetConstants.authPattern)
                      )
                  ),
                ),
                const SizedBox(height: Sizes.dimen_32,),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_16.w
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: AppColors.appBlack,
                            fontSize: Sizes.dimen_24.sp,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox(height: Sizes.dimen_8.h,),

                      Text(
                        subTitle,
                        style: TextStyle(
                            color: AppColors.subTitleColor,
                            fontSize: Sizes.dimen_14.sp,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Sizes.dimen_40,),

                child
              ],
            ),
          ),
        ),
      )
    );
  }

}
