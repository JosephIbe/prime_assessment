import 'package:flutter/material.dart';

import 'package:primed_health/common/size_constants.dart';
import 'package:primed_health/presentation/theme/colors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimePasswordField extends StatefulWidget {

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final FormFieldValidator validator;
  final ValueChanged<String>? onChanged;

  const PrimePasswordField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
    this.onChanged,
    Key? key
  }) : super(key: key);

  @override
  State<PrimePasswordField> createState() => _PrimePasswordFieldState();
}

class _PrimePasswordFieldState extends State<PrimePasswordField> {

  late Size size;
  late bool isVisible;

  @override
  void initState() {
    super.initState();
    isVisible = false;
  }

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: Sizes.dimen_85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: TextStyle(
                color: AppColors.appBlack,
                fontSize: Sizes.dimen_12.sp,
                fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Sizes.dimen_5.h,),

          SizedBox(
            height: Sizes.dimen_56,
            child: TextFormField(
              controller: widget.controller,
              obscureText: isVisible,
              style: TextStyle(
                  color: AppColors.subTitleColor,
                  fontSize: Sizes.dimen_12.sp,
                  fontWeight: FontWeight.w400,
              ),
              onChanged: widget.onChanged,
              validator: widget.validator,
              keyboardType: isVisible ? TextInputType.text : TextInputType.visiblePassword,
              decoration: InputDecoration(
                fillColor: Colors.white,
                contentPadding: EdgeInsets.fromLTRB(
                    Sizes.dimen_20.w,
                    Sizes.dimen_10.h,
                    Sizes.dimen_20.w,
                    Sizes.dimen_0.h
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: widget.hintText,
                focusColor: AppColors.primaryColor,
                hintStyle: TextStyle(
                    color: AppColors.subTitleColor,
                    fontSize: Sizes.dimen_16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Manrope'
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
                suffixIcon: IconButton(
                  onPressed: ()=> setState(()=> isVisible = !isVisible),
                  icon: Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

}