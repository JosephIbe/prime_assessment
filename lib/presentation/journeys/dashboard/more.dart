import 'package:flutter/material.dart';

import 'package:primed_health/common/route_constants.dart';
import 'package:primed_health/common/asset_constants.dart';
import 'package:primed_health/common/db_constants.dart';
import 'package:primed_health/common/size_constants.dart';

import 'package:primed_health/domain/entities/delete_my_account_params.dart';

import 'package:primed_health/presentation/blocs/profile/profile_bloc.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:primed_health/presentation/widgets/common/cta_button.dart';
import 'package:primed_health/presentation/widgets/more_item.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {

  late Size size;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                 Container(
                   width: size.width,
                   height: size.height * .3,
                   color: AppColors.lightGrey,
                   child:  Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Container(
                         width: Sizes.dimen_70,
                         height: Sizes.dimen_70,
                         decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             border: Border.all(
                                 // color: AppColors.primaryColor,
                                 width: Sizes.dimen_1,
                                 style: BorderStyle.solid
                             ),
                           image: DecorationImage(
                             image: AssetImage(AssetConstants.dummyProfileImage)
                           )
                         ),
                         // child: const Center(
                         //   child: Icon(Icons.person_outline),
                         // ),
                       ),
                       const SizedBox(height: Sizes.dimen_10,),

                       Text(
                         '${Hive.box(DBConstants.appBoxName).get(DBConstants.firstName)}\t ${Hive.box(DBConstants.appBoxName).get(DBConstants.lastName)}',
                         style: TextStyle(
                           fontSize: Sizes.dimen_18,
                           fontWeight: FontWeight.w700,
                           color: AppColors.appBlack,
                         ),
                       ),

                       Text(
                         '${Hive.box(DBConstants.appBoxName).get(DBConstants.email)}',
                         style: TextStyle(
                           fontSize: Sizes.dimen_12,
                           fontWeight: FontWeight.w400,
                           color: AppColors.appBlack,
                         ),
                       ),
                       const SizedBox(height: Sizes.dimen_20,),

                       InkWell(
                         onTap: () {},
                         child: Container(
                           width: Sizes.dimen_85,
                           height: Sizes.dimen_30,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(Sizes.dimen_20),
                             border: Border.all(
                                 color: AppColors.darkYellow,
                               width: Sizes.dimen_2,
                               style: BorderStyle.solid
                             ),
                           ),
                           child: Center(
                             child: Text(
                               "Edit Profile",
                               style: TextStyle(
                                   color: AppColors.darkYellow,
                                 fontWeight: FontWeight.w600,
                                 fontSize: Sizes.dimen_12
                               ),
                             ),
                           ),
                         ),
                       )
                     ],
                   ),
                 ),

                  MoreItem(
                    assetPath: AssetConstants.kyc,
                    title: "Complete KYC",
                    description: "Verify your identity",
                    bgColor: AppColors.primaryColor.withOpacity(.2),
                    onTap: (){},
                  ),

                  MoreItem(
                    assetPath: AssetConstants.feedBack,
                    title: "Feedback",
                    description: "See reviews and ratings from customers",
                    bgColor: AppColors.primaryColor.withOpacity(.2),
                    onTap: () {},
                  ),

                  MoreItem(
                    assetPath: AssetConstants.inviteFriends,
                    title: "Invite Friends",
                    description: "Share your referral code with your friends",
                    bgColor: AppColors.primaryColor.withOpacity(.2),
                    onTap: (){}
                  ),

                  MoreItem(
                    assetPath: AssetConstants.termsOfService,
                    title: "Terms of Service",
                    description: "",
                    bgColor: AppColors.primaryColor.withOpacity(.2),
                    onTap: (){},
                  ),

                  MoreItem(
                    assetPath: AssetConstants.privacyPolicy,
                    title: "Privacy Policy",
                    description: "",
                    bgColor: AppColors.primaryColor.withOpacity(.2),
                    onTap: (){},
                  ),

                  MoreItem(
                    assetPath: AssetConstants.logOut,
                    title: "Logout",
                    description: "",
                    bgColor: Colors.transparent,
                    onTap: (){
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context){
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Sizes.dimen_20),
                              ),
                              content: SizedBox(
                                height: Sizes.dimen_210,
                                width: size.width,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: ()=> Navigator.pop(context),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: Sizes.dimen_32,
                                            height: Sizes.dimen_32,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.primaryColor.withOpacity(.3)
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(AssetConstants.close),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: Sizes.dimen_20,),

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(AssetConstants.logOut, width: Sizes.dimen_48, height: Sizes.dimen_48, color: AppColors.primaryColor),
                                        const SizedBox(height: Sizes.dimen_20,),

                                        Text(
                                          "You're about to log out?",
                                          style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: Sizes.dimen_20,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ),
                                        const SizedBox(height: Sizes.dimen_20,),

                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                Navigator.pop(context);
                                                Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.createAccountRoute, (route) => false);
                                              },
                                              child: Container(
                                                width: Sizes.dimen_120,
                                                height: Sizes.dimen_40,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Sizes.dimen_28),
                                                    color: AppColors.primaryColor,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Logout",
                                                    style: TextStyle(
                                                      fontSize: Sizes.dimen_16,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.lightWhite,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: Sizes.dimen_10,),

                                            InkWell(
                                              onTap: ()=> Navigator.pop(context),
                                              child: Container(
                                                width: Sizes.dimen_120,
                                                height: Sizes.dimen_40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Sizes.dimen_28),
                                                  border: Border.all(color: AppColors.primaryColor, width: Sizes.dimen_2, style: BorderStyle.solid),
                                                  color: AppColors.lightWhite,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      fontSize: Sizes.dimen_16,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    },
                  ),

                  InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context){
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Sizes.dimen_20),
                              ),
                              content: SizedBox(
                                height: Sizes.dimen_210,
                                width: size.width,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: ()=> Navigator.pop(context),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: Sizes.dimen_32,
                                            height: Sizes.dimen_32,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.primaryColor.withOpacity(.3)
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(AssetConstants.close),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: Sizes.dimen_20,),

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(AssetConstants.logOut, width: Sizes.dimen_48, height: Sizes.dimen_48, color: AppColors.primaryColor),
                                        const SizedBox(height: Sizes.dimen_20,),

                                        Text(
                                          "Delete Your Account?",
                                          style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: Sizes.dimen_20,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ),
                                        const SizedBox(height: Sizes.dimen_20,),

                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: (){

                                                final params = DeleteMyAccountParams(
                                                  userId: Hive.box(DBConstants.appBoxName).get(DBConstants.userId)
                                                );
                                                context.read<ProfileBloc>().add(DeleteMyAccountEvent(params: params));

                                                Navigator.pop(context);
                                                Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.createAccountRoute, (route) => false);
                                              },
                                              child: Container(
                                                width: Sizes.dimen_120,
                                                height: Sizes.dimen_40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Sizes.dimen_28),
                                                  color: AppColors.primaryColor,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Proceed",
                                                    style: TextStyle(
                                                      fontSize: Sizes.dimen_16,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.errorColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: Sizes.dimen_10,),

                                            InkWell(
                                              onTap: ()=> Navigator.pop(context),
                                              child: Container(
                                                width: Sizes.dimen_120,
                                                height: Sizes.dimen_40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Sizes.dimen_28),
                                                  border: Border.all(color: AppColors.primaryColor, width: Sizes.dimen_2, style: BorderStyle.solid),
                                                  color: AppColors.lightWhite,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      fontSize: Sizes.dimen_16,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_16, vertical: Sizes.dimen_10),
                      child: Material(
                        color: Colors.white,
                        elevation: Sizes.dimen_2,
                        borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_10)),
                        child: Container(
                          width: size.width,
                          height: Sizes.dimen_62,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: Sizes.dimen_36,
                                  height: Sizes.dimen_36,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent
                                  ),
                                  child: const Center(
                                    child: SizedBox(
                                      width: Sizes.dimen_24,
                                      height: Sizes.dimen_24,
                                      child: Icon(Icons.delete_forever_rounded, color: Colors.red,),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: Sizes.dimen_10,),

                              Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Delete My Account",
                                          style: TextStyle(
                                              fontSize: Sizes.dimen_14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.subTitleColor
                                          )
                                      ),

                                      Text(
                                          "This will remove all your data from our server permanently",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: Sizes.dimen_10,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.subTitleColor.withOpacity(.6)
                                          )
                                      ),
                                    ],
                                  )
                              ),

                              Expanded(
                                flex: 1,
                                child: SvgPicture.asset(AssetConstants.chevronRight),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }

}