import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:primed_health/common/db_constants.dart';
import 'package:primed_health/common/route_constants.dart';
import 'package:primed_health/common/size_constants.dart';
import 'package:primed_health/common/text_constants.dart';

import 'package:primed_health/domain/entities/verify_email_params.dart';

import 'package:primed_health/presentation/blocs/auth/auth_bloc.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:primed_health/presentation/widgets/common/auth_wrapper.dart';
import 'package:primed_health/presentation/widgets/common/cta_button.dart';

import 'package:primed_health/di/injector.dart' as di;

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class VerifyEmail extends StatefulWidget {

  final dynamic email;
  const VerifyEmail({required this.email, super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {

  final pinOneController = TextEditingController();
  final pinTwoController = TextEditingController();
  final pinThreeController = TextEditingController();
  final pinFourController = TextEditingController();
  final pinFiveController = TextEditingController();
  final pinSixController = TextEditingController();

  final focusOne = FocusNode();
  final focusTwo = FocusNode();
  final focusThree = FocusNode();
  final focusFour = FocusNode();
  final focusFive = FocusNode();
  final focusSix = FocusNode();

  late bool isEnabled = false;

  @override
  Widget build(BuildContext context) {

    return AuthWrapper(
      title: TextConstants.verify,
      subTitle: TextConstants.verifyEmailDescription,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthStateFailure){
            Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              duration: const Duration(milliseconds: 4500),
              backgroundColor: Colors.red,
              title: 'Verification Failed',
              icon: const Icon(Icons.error_outline),
              message: state.failureMessage,
            ).show(context);
          }
          if(state is AuthStateVerifyEmailSuccess){
            Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.homeRoute, (route) => false);
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_10),
              child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  TextConstants.secureCode,
                  style: TextStyle(
                    color: AppColors.appBlack,
                    fontSize: Sizes.dimen_12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: Sizes.dimen_5,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Material(
                          child: SizedBox(
                            width: Sizes.dimen_48,
                            height: Sizes.dimen_60,
                            child: TextFormField(
                                controller: pinOneController,
                                focusNode: focusOne,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.subTitleColor,
                                  fontSize: Sizes.dimen_20,
                                  fontWeight: FontWeight.w300,
                                ),
                                validator: (v) {
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                maxLines: 1,
                                obscureText: true,
                                autofocus: true,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                onChanged: (v) {
                                  FocusScope.of(context).requestFocus(focusTwo);
                                },
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  focusColor: AppColors.primaryColor,
                                  fillColor: const Color(0xFFFFFFFF),
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(Sizes.dimen_8)),
                                      borderSide:
                                      BorderSide(color: AppColors.lightGrey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: Sizes.dimen_2,
                                          style: BorderStyle.solid)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.errorColor,
                                          width: Sizes.dimen_2,
                                          style: BorderStyle.solid)),
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: Sizes.dimen_6,
                        ),

                        Material(
                          child: SizedBox(
                            width: Sizes.dimen_48,
                            height: Sizes.dimen_60,
                            child: TextFormField(
                                controller: pinTwoController,
                                focusNode: focusTwo,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.subTitleColor,
                                  fontSize: Sizes.dimen_20,
                                  fontWeight: FontWeight.w300,
                                ),
                                validator: (v) {
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                maxLines: 1,
                                obscureText: true,
                                autofocus: true,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                onChanged: (v) {
                                  FocusScope.of(context).requestFocus(
                                      focusThree);
                                },
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  focusColor: AppColors.primaryColor,
                                  fillColor: const Color(0xFFFFFFFF),
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(Sizes.dimen_8)),
                                      borderSide:
                                      BorderSide(color: AppColors.lightGrey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: Sizes.dimen_2,
                                          style: BorderStyle.solid)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.errorColor,
                                          width: Sizes.dimen_2,
                                          style: BorderStyle.solid)),
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: Sizes.dimen_6,
                        ),

                        Material(
                          child: SizedBox(
                            width: Sizes.dimen_48,
                            height: Sizes.dimen_60,
                            child: TextFormField(
                                controller: pinThreeController,
                                focusNode: focusThree,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.subTitleColor,
                                  fontSize: Sizes.dimen_20,
                                  fontWeight: FontWeight.w300,
                                ),
                                validator: (v) {
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                maxLines: 1,
                                obscureText: true,
                                autofocus: true,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                onChanged: (v) {
                                  FocusScope.of(context).requestFocus(
                                      focusFour);
                                },
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  focusColor: AppColors.primaryColor,
                                  fillColor: const Color(0xFFFFFFFF),
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(Sizes.dimen_8)),
                                      borderSide:
                                      BorderSide(color: AppColors.lightGrey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: Sizes.dimen_2,
                                          style: BorderStyle.solid)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.errorColor,
                                          width: Sizes.dimen_2,
                                          style: BorderStyle.solid)),
                                )),
                          ),
                        ),
                        // const SizedBox(width: Sizes.dimen_8,),
                      ],
                    ),
                    SizedBox(
                      height: Sizes.dimen_60,
                      child: Center(
                        child: Container(
                          width: Sizes.dimen_19,
                          height: Sizes.dimen_5,
                          color: AppColors.lightGrey,
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        Material(
                          child: SizedBox(
                            width: Sizes.dimen_48,
                            height: Sizes.dimen_60,
                            child: TextFormField(
                                controller: pinFourController,
                                focusNode: focusFour,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.subTitleColor,
                                  fontSize: Sizes.dimen_20,
                                  fontWeight: FontWeight.w300,
                                ),
                                validator: (v) {
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                maxLines: 1,
                                obscureText: true,
                                autofocus: true,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                onChanged: (v) {
                                  FocusScope.of(context).requestFocus(
                                      focusFive);
                                },
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  focusColor: AppColors.primaryColor,
                                  fillColor: const Color(0xFFFFFFFF),
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(Sizes.dimen_8)),
                                      borderSide:
                                      BorderSide(color: AppColors.lightGrey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: Sizes.dimen_2,
                                          style: BorderStyle.solid)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.errorColor,
                                          width: Sizes.dimen_2,
                                          style: BorderStyle.solid)),
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: Sizes.dimen_6,
                        ),

                        Material(
                          child: SizedBox(
                            width: Sizes.dimen_48,
                            height: Sizes.dimen_60,
                            child: TextFormField(
                                controller: pinFiveController,
                                focusNode: focusFive,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.subTitleColor,
                                  fontSize: Sizes.dimen_20,
                                  fontWeight: FontWeight.w300,
                                ),
                                validator: (v) {
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                maxLines: 1,
                                obscureText: true,
                                autofocus: true,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                onChanged: (v) {
                                  FocusScope.of(context).requestFocus(focusSix);
                                },
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  focusColor: AppColors.primaryColor,
                                  fillColor: const Color(0xFFFFFFFF),
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(Sizes.dimen_8)),
                                      borderSide:
                                      BorderSide(color: AppColors.lightGrey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: Sizes.dimen_2,
                                          style: BorderStyle.solid)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.errorColor,
                                          width: Sizes.dimen_2,
                                          style: BorderStyle.solid)),
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: Sizes.dimen_6,
                        ),

                        Material(
                          child: SizedBox(
                            width: Sizes.dimen_48,
                            height: Sizes.dimen_60,
                            child: TextFormField(
                                controller: pinSixController,
                                focusNode: focusSix,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.subTitleColor,
                                  fontSize: Sizes.dimen_20,
                                  fontWeight: FontWeight.w300,
                                ),
                                validator: (v) {
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                maxLines: 1,
                                obscureText: true,
                                autofocus: true,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                onChanged: (v) {
                                  if(pinOneController.text.isNotEmpty && pinTwoController.text.isNotEmpty && pinThreeController.text.isNotEmpty
                                    && pinFourController.text.isNotEmpty && pinFiveController.text.isNotEmpty && pinSixController.text.isNotEmpty){
                                    setState(() {
                                      isEnabled = true;
                                    });
                                  }
                                  FocusScope.of(context).unfocus();
                                },
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  focusColor: AppColors.primaryColor,
                                  fillColor: const Color(0xFFFFFFFF),
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(Sizes.dimen_8)),
                                      borderSide:
                                      BorderSide(color: AppColors.lightGrey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: Sizes.dimen_2,
                                          style: BorderStyle.solid)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.errorColor,
                                          width: Sizes.dimen_2,
                                          style: BorderStyle.solid)),
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: Sizes.dimen_6,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: Sizes.dimen_40),

                state is AuthStateLoading
                  ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),))
                  : CTAButton(
                    title: TextConstants.verify,
                    isEnabled: isEnabled,
                    isBorderedButton: false,
                    isMini: false,
                    color: AppColors.primaryColor,
                    textColor: AppColors.lightWhite,
                    height: Sizes.dimen_50,
                    onClick: () {

                      final otp = pinOneController.text + pinTwoController.text + pinThreeController.text
                        + pinFourController.text + pinFiveController.text + pinSixController.text;

                      final verifyEmailParams = VerifyEmailParams(
                        userId: Hive.box(DBConstants.appBoxName).get(DBConstants.userId),
                        email: widget.email,
                        otp: otp
                      );
                      context.read<AuthBloc>().add(VerifyEmailEvent(verifyEmailParams: verifyEmailParams));
                      // bloc.add(VerifyEmailEvent(verifyEmailParams: verifyEmailParams));
                    },
                )
              ]
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    pinOneController.dispose();
    pinTwoController.dispose();
    pinThreeController.dispose();
    pinFourController.dispose();
    pinFiveController.dispose();
    pinSixController.dispose();

    focusOne.dispose();
    focusTwo.dispose();
    focusThree.dispose();
    focusFour.dispose();
    focusFive.dispose();
    focusSix.dispose();
  }

}