import 'package:flutter/material.dart';

import 'package:primed_health/common/size_constants.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

late Size size;

class CTAButton extends StatelessWidget {

  final String title;
  final bool isEnabled;
  final bool? isMini;
  final bool? isBorderedButton;
  final VoidCallback onClick;
  final double? height;
  final Color? color;
  final Color? textColor;

  const CTAButton({
    Key? key,
    required this.title,
    required this.isEnabled,
    required this.isMini,
    required this.onClick,
    this.height,
    this.color,
    this.textColor,
    this.isBorderedButton
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onClick : null,
        child: Container(
          width: isMini! ? size.width / 2 : size.width,
          height: height ?? Sizes.dimen_56.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.dimen_28),
            color: isEnabled ? color ?? AppColors.primaryColor : const Color(0XFF218838).withOpacity(.5),
            // border: Border.all(color: Colors.transparent, width: Sizes.dimen_2, style: BorderStyle.solid)
              border: isBorderedButton!
                  ? Border.all(color: AppColors.primaryColor, width: Sizes.dimen_2.w, style: BorderStyle.solid)
                  : Border.all(color: Colors.transparent, width: Sizes.dimen_2.w, style: BorderStyle.solid)
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: Sizes.dimen_16.sp,
                fontWeight: FontWeight.w500,
                color: textColor ?? AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
