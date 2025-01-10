import 'package:flutter/material.dart';

import 'package:primed_health/common/size_constants.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

late Size size;

class PrimeInputField extends StatelessWidget {

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final FormFieldValidator validator;
  final ValueChanged<String>? onChanged;
  final bool isMini;
  final bool? isDisabled;
  final TextInputType inputType;
  final String? initialValue;

  const PrimeInputField({
    required this.controller,
    this.hintText,
    this.labelText,
    required this.validator,
    this.onChanged,
    this.initialValue,
    this.isDisabled,
    required this.isMini,
    required this.inputType,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SizedBox(
      width: isMini ? size.width * .481.w : size.width,
      height: Sizes.dimen_85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText!,
            style: TextStyle(
              color: AppColors.appBlack,
              fontSize: Sizes.dimen_12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Sizes.dimen_5.h),

          SizedBox(
            height: Sizes.dimen_56,
            child: TextFormField(
              controller: controller,
              // initialValue: initialValue,
              enabled: isDisabled,
              style: TextStyle(
                  color: AppColors.subTitleColor,
                  fontSize: Sizes.dimen_12.sp,
                  fontWeight: FontWeight.w400,
              ),
              validator: validator,
              onChanged: onChanged,
              keyboardType: inputType,
              decoration: InputDecoration(
                fillColor: Colors.white,
                contentPadding: EdgeInsets.fromLTRB(
                    Sizes.dimen_20.w,
                    Sizes.dimen_10.h,
                    Sizes.dimen_20.w,
                    Sizes.dimen_0.h
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: hintText!,
                focusColor: AppColors.primaryColor,
                hintStyle: TextStyle(
                    color: AppColors.subTitleColor,
                    fontSize: Sizes.dimen_12.sp,
                    fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_28)),
                  borderSide: BorderSide(color: AppColors.lightGrey)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_28)),
                    borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: Sizes.dimen_2.w,
                        style: BorderStyle.solid
                    )
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_28)),
                    borderSide: BorderSide(
                        color: AppColors.errorColor,
                        width: Sizes.dimen_2.w,
                        style: BorderStyle.solid
                    )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}