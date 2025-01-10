import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:primed_health/common/route_constants.dart';
import 'package:primed_health/common/text_constants.dart';
import 'package:primed_health/common/size_constants.dart';

import 'package:primed_health/domain/entities/register_params.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:primed_health/presentation/blocs/auth/auth_bloc.dart';

import 'package:primed_health/presentation/widgets/common/auth_wrapper.dart';
import 'package:primed_health/presentation/widgets/common/cta_button.dart';
import 'package:primed_health/presentation/widgets/common/input_field.dart';
import 'package:primed_health/presentation/widgets/common/password_field.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  late Size size;
  final formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late bool isButtonEnabled = false;
  late bool passwordCharacterLimitVisible = true;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        context.read<AuthBloc>().add(BackStackEvent());
        return true;
      },
      child: AuthWrapper(
        title: TextConstants.createAccount,
        subTitle: TextConstants.dignifyingHealthCare,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if(state is AuthStateFailure){
                Flushbar(
                  flushbarPosition: FlushbarPosition.TOP,
                  duration: const Duration(milliseconds: 4500),
                  backgroundColor: Colors.red,
                  title: 'Registration Failed',
                  icon: const Icon(Icons.error_outline),
                  message: state.failureMessage,
                ).show(context);
              }
              if(state is AuthStateRegisterSuccess){
                Navigator.pushNamed(context, RouteLiterals.verifyEmailRoute, arguments: emailController.text.trim());
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          // margin: const EdgeInsets.only(top: Sizes.dimen_20),
                          padding: EdgeInsets.all(Sizes.dimen_16.r),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    PrimeInputField(
                                      controller: firstNameController,
                                      hintText: TextConstants.firstNameHint,
                                      labelText: TextConstants.firstNameLabel,
                                      validator: (v) {
                                        return null;
                                      },
                                      isMini: true,
                                      inputType: TextInputType.text,
                                    ),
                                    SizedBox(
                                      width: Sizes.dimen_8.w,
                                    ),

                                    PrimeInputField(
                                      controller: lastNameController,
                                      hintText: TextConstants.lastNameHint,
                                      labelText: TextConstants.lastNameLabel,
                                      validator: (v) {
                                        return null;
                                      },
                                      isMini: true,
                                      inputType: TextInputType.text,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Sizes.dimen_8.h,
                                ),

                                PrimeInputField(
                                  controller: emailController,
                                  hintText: TextConstants.emailHint,
                                  labelText: TextConstants.emailLabel,
                                  validator: (v) {
                                    return null;
                                  },
                                  isMini: false,
                                  inputType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: Sizes.dimen_8.h,
                                ),

                                PrimePasswordField(
                                  controller: passwordController,
                                  labelText: TextConstants.passwordLabel,
                                  hintText: TextConstants.passwordHint,
                                  onChanged: (String v) {
                                    if (v.length >= 8 &&
                                        firstNameController.text.isNotEmpty &&
                                        lastNameController.text.isNotEmpty &&
                                        emailController.text.isNotEmpty) {
                                      setState(() {
                                        isButtonEnabled = true;
                                        passwordCharacterLimitVisible = false;
                                      });
                                    } else if (v.length < 8) {
                                      setState(() {
                                        passwordCharacterLimitVisible = true;
                                      });
                                    } else {
                                      setState(() {
                                        isButtonEnabled = false;
                                      });
                                    }
                                  },
                                  validator: (v) {
                                    return null;
                                  },
                                ),

                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Visibility(
                                    visible: passwordCharacterLimitVisible,
                                    child: Text(
                                      TextConstants.passwordCharacterLimit,
                                      style: TextStyle(
                                        fontSize: Sizes.dimen_12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.appBlack,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: Sizes.dimen_20,
                                ),

                                state is AuthStateLoading
                                  ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),))
                                  : CTAButton(
                                    height: Sizes.dimen_50,
                                    title: TextConstants.getStarted,
                                    isEnabled: isButtonEnabled,
                                    isBorderedButton: false,
                                  isMini: false,
                                    // isEnabled: true,
                                    color: AppColors.primaryColor,
                                    textColor: AppColors.lightWhite,
                                    onClick: (){

                                      final registerParams = RegisterParams(
                                        email: emailController.text.trim(),
                                        firstName: firstNameController.text.trim(),
                                        lastName: lastNameController.text.trim(),
                                        password: passwordController.text.trim()
                                      );

                                      context.read<AuthBloc>().add(RegisterUserEvent(registerParams: registerParams));
                                      // bloc.add(RegisterUserEvent(registerParams: registerParams));
                                    },
                                ),
                                SizedBox(
                                  height: Sizes.dimen_12.h,
                                ),

                                Material(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        TextConstants.alreadyHaveAccount,
                                        style: TextStyle(
                                            fontSize: Sizes.dimen_14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.subTitleColor),
                                      ),
                                      SizedBox(
                                        width: Sizes.dimen_8.w,
                                      ),

                                      InkWell(
                                        onTap: (){
                                          context.read<AuthBloc>().add(BackStackEvent());
                                          Navigator.pushNamed(context, RouteLiterals.loginRoute);
                                        },
                                        child: Text(
                                          TextConstants.login,
                                          style: TextStyle(
                                              fontSize: Sizes.dimen_14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryColor),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    log('dispose()');

    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

}