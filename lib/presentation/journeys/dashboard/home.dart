import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:primed_health/common/asset_constants.dart';
import 'package:primed_health/common/size_constants.dart';

import 'package:primed_health/presentation/journeys/dashboard/dashboard.dart';
import 'package:primed_health/presentation/journeys/dashboard/more.dart';
import 'package:primed_health/presentation/journeys/dashboard/wishlist.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Size size;

  int currentIndex = 0;

  final items = const [
    Dashboard(),
    Wishlist(),
    More()
  ];

  List<dynamic> icons = [
    AssetConstants.home,
    AssetConstants.wishlist,
    AssetConstants.more
  ];

  List<String> titles = [
    'Home',
    'Saved',
    'More',
  ];

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: items[currentIndex],
        bottomNavigationBar: Material(
          elevation: Sizes.dimen_3,
          color: Colors.white,
          type: MaterialType.card,
          child: SizedBox(
            width: size.width,
            height: Sizes.dimen_60,
            child: ListView.builder(
              itemCount: titles.length,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                    HapticFeedback.lightImpact();
                  });
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Stack(
                  children: [
                    Center(
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == currentIndex
                            ? size.width * .27
                            : size.width * .12,
                        height: Sizes.dimen_40,
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height: index == currentIndex ? size.width * .12 : 0,
                          // height: Sizes.dimen_40,
                          width: index == currentIndex ? size.width * .27 : 0,
                          decoration: BoxDecoration(
                            color: index == currentIndex
                                ? AppColors.primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(Sizes.dimen_20),
                          ),
                        ),
                      ),
                    ),

                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: index == currentIndex
                          ? size.width * .26
                          : size.width * .18,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width:
                                index == currentIndex ? size.width * .13 : 0,
                              ),
                              AnimatedOpacity(
                                opacity: index == currentIndex ? 1 : 0,
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: Text(
                                  index == currentIndex
                                      ? titles[index]
                                      : '',
                                  style: TextStyle(
                                    color: index == currentIndex
                                        ? AppColors.lightWhite
                                        : AppColors.darkGrey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Sizes.dimen_15.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex ? size.width * .03 : 20,
                              ),
                              SvgPicture.asset(
                                icons[index],
                                color: index == currentIndex
                                    ? AppColors.lightWhite
                                    : AppColors.darkGrey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      );
    // );

  }

}