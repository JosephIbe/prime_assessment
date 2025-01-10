import 'package:flutter/material.dart';

import 'package:primed_health/common/asset_constants.dart';
import 'package:primed_health/common/size_constants.dart';
import 'package:primed_health/common/text_constants.dart';

import 'package:primed_health/presentation/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerCarousel extends StatefulWidget {

  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {

  late Size size;

  late int initialPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: initialPage, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width,
          height: Sizes.dimen_120,
          margin: const EdgeInsets.only(top: Sizes.dimen_16),
          child: PageView(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            onPageChanged: (v){
              setState(() {
                initialPage = v;
              });
            },
            pageSnapping: true,
            children: [
              Stack(
                  clipBehavior: Clip.none,
                children: [
                  Container(
                    width: Sizes.dimen_300,
                    height: Sizes.dimen_100,
                    margin: const EdgeInsets.only(right: Sizes.dimen_16),
                    decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_20)),
                        border: Border.all(color: const Color(0xFFE0EBC1), width: Sizes.dimen_2, style: BorderStyle.solid)
                    ),
                    child: SizedBox(
                      width: Sizes.dimen_240,
                      height: Sizes.dimen_90,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
                                child: RichText(
                                  text: TextSpan(
                                      text: "TextConstants.earnMoreMoneyBy",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: Sizes.dimen_12.sp,
                                          color: AppColors.subTitleColor
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "TextConstants.sellingGoods",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: Sizes.dimen_12.sp,
                                              color: AppColors.subTitleColor
                                          ),
                                        )
                                      ]
                                  ),
                                ),
                              )
                          ),

                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: -50,
                    left: 160,
                    right: 20.0,
                    child: Image.asset(AssetConstants.cashBoy, height: Sizes.dimen_160, width: Sizes.dimen_140,),
                  )
                ]
              ),

              Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: Sizes.dimen_300,
                      height: Sizes.dimen_100,
                      decoration: BoxDecoration(
                          color: AppColors.brightOrange,
                          borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_20)),
                          border: Border.all(color: const Color(0xFFE0EBC1), width: Sizes.dimen_2, style: BorderStyle.solid)
                      ),
                      child: SizedBox(
                        width: Sizes.dimen_240,
                        height: Sizes.dimen_90,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
                                  child: RichText(
                                    text: TextSpan(
                                        text: "TextConstants.buyItemsYouNeed",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: Sizes.dimen_12.sp,
                                            color: AppColors.subTitleColor
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "TextConstants.fromVerifiedSellers",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: Sizes.dimen_12.sp,
                                                color: AppColors.subTitleColor
                                            ),
                                          )
                                        ]
                                    ),
                                  ),
                                )
                            ),

                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      top: -50,
                      left: 160,
                      right: 20.0,
                      child: Image.asset(AssetConstants.verifiedShopper, height: Sizes.dimen_160, width: Sizes.dimen_140,),
                    )
                  ]
              ),
            ],
          ),
        ),

        SmoothPageIndicator(
          count: 2,
          controller: pageController,
          effect: CustomizableEffect(
              spacing: Sizes.dimen_8,
              activeDotDecoration: DotDecoration(
                width: Sizes.dimen_20,
                borderRadius: BorderRadius.circular(Sizes.dimen_10),
                height: Sizes.dimen_5,
                color: AppColors.primaryColor,
              ),
              dotDecoration: DotDecoration(
                width: Sizes.dimen_10,
                height: Sizes.dimen_5,
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(Sizes.dimen_10),
              )
          ),
          onDotClicked: (v){
            pageController.animateToPage(v, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
          },
        )
      ],
    );

  }

}