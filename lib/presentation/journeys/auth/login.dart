import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:primed_health/common/route_constants.dart';
import 'package:primed_health/common/size_constants.dart';
import 'package:primed_health/common/text_constants.dart';

import 'package:primed_health/domain/entities/login_params.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:primed_health/presentation/blocs/auth/auth_bloc.dart';

import 'package:primed_health/presentation/widgets/common/auth_wrapper.dart';
import 'package:primed_health/presentation/widgets/common/cta_button.dart';
import 'package:primed_health/presentation/widgets/common/input_field.dart';
import 'package:primed_health/presentation/widgets/common/password_field.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>  {

  late Size size;
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late bool isButtonEnabled = false;
  late bool passwordCharacterLimitVisible = true;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        log("login willpopscope()");
        context.read<AuthBloc>().add(BackStackEvent());
        return true;
      },
      child: AuthWrapper(
        title: TextConstants.login,
        subTitle: TextConstants.dignifyingHealthCare,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              print(state);
              if(state is AuthStateFailure){
                Flushbar(
                  flushbarPosition: FlushbarPosition.TOP,
                  duration: const Duration(milliseconds: 4500),
                  backgroundColor: Colors.red,
                  title: 'Login Failed',
                  icon: const Icon(Icons.error_outline),
                  message: state.failureMessage,
                ).show(context);
              }
              if(state is AuthStateLoginSuccess){
                Navigator.pushNamed(context, RouteLiterals.homeRoute);
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: Sizes.dimen_32.h),
                          padding: const EdgeInsets.all(Sizes.dimen_16),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
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
                                    if (v.length >= 8 && emailController.text.isNotEmpty) {
                                      setState(() {
                                        isButtonEnabled = true;
                                        passwordCharacterLimitVisible = false;
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
                                SizedBox(height: Sizes.dimen_5.h,),

                                InkWell(
                                  onTap: (){},
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      TextConstants.forgotPassword,
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: Sizes.dimen_14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Sizes.dimen_24.h,
                                ),

                                state is AuthStateLoading
                                    ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),))
                                    : CTAButton(
                                  height: Sizes.dimen_50,
                                  title: TextConstants.login,
                                  isEnabled: isButtonEnabled,
                                  isBorderedButton: false,
                                  isMini: false,
                                  color: AppColors.primaryColor,
                                  textColor: AppColors.lightWhite,
                                  onClick: (){

                                    final params = LoginParams(
                                        email: emailController.text.trim(),
                                        password: passwordController.text.trim()
                                    );

                                    context.read<AuthBloc>().add(LoginEvent(loginParams: params));
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
                                        TextConstants.dontHaveAccount,
                                        style: TextStyle(
                                            fontSize: Sizes.dimen_14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.subTitleColor),
                                      ),
                                      SizedBox(
                                        width: Sizes.dimen_8.w,
                                      ),

                                      InkWell(
                                        onTap: () {
                                          context.read<AuthBloc>().add(BackStackEvent());
                                          Navigator.pushNamed(context, RouteLiterals.createAccountRoute);
                                        },
                                        child: Text(
                                          TextConstants.createAccount,
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
    emailController.dispose();
    passwordController.dispose();
  }

}
