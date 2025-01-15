import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:primed_health/common/route_constants.dart';
import 'package:primed_health/common/asset_constants.dart';
import 'package:primed_health/common/size_constants.dart';

import 'package:primed_health/data/models/product.dart';

import 'package:primed_health/presentation/blocs/products/products_bloc.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:primed_health/presentation/widgets/circle_back_button.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

class ProductDetails extends StatefulWidget {

  final Product product;
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  late Size size;
  late int initialPage = 0;
  late PageController pageController;

  final offerController = TextEditingController();
  final messageController = TextEditingController();

  late bool inWishlist = false;
  late String fcmToken;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: initialPage,
    );
  }

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    log('inWishlist:\t$inWishlist');

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor.withOpacity(.5),
            title: Text(widget.product.title)
          ),
            body: SizedBox(
                width: size.width,
                height: size.height,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [

                      /**
                       *  Header with Image Carousel
                       **/
                      SizedBox(
                        width: size.width,
                        height: size.height,
                        child: Column(
                          children: [

                            SizedBox(
                              width: size.width,
                              height: Sizes.dimen_265,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  PageView.builder(
                                    controller: pageController,
                                    pageSnapping: true,
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (v){
                                      setState(() {
                                        initialPage = v;
                                      });
                                    },
                                    itemCount: widget.product.images.length,
                                    itemBuilder: (context, index){
                                      return FancyShimmerImage(
                                        imageUrl: widget.product.images[index],
                                        boxFit: BoxFit.cover,
                                      );
                                    },
                                  ),

                                  Positioned(
                                    bottom: Sizes.dimen_50,
                                    child: SmoothPageIndicator(
                                      count: widget.product.images.length,
                                      controller: pageController,
                                      effect: CustomizableEffect(
                                          spacing: Sizes.dimen_8,
                                          activeDotDecoration: DotDecoration(
                                            width: Sizes.dimen_20,
                                            borderRadius: BorderRadius.circular(Sizes.dimen_10),
                                            height: Sizes.dimen_5,
                                            color: AppColors.lightWhite,
                                          ),
                                          dotDecoration: DotDecoration(
                                            width: Sizes.dimen_10,
                                            height: Sizes.dimen_5,
                                            color: Colors.grey.withOpacity(.6),
                                            borderRadius: BorderRadius.circular(Sizes.dimen_10),
                                          )
                                      ),
                                      onDotClicked: (v){
                                        pageController.animateToPage(v, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /**
                       *  Content Body
                       * **/
                      Positioned(
                        top: Sizes.dimen_290,
                        child: Container(
                            width: size.width,
                            height: size.height - Sizes.dimen_355,
                            margin: const EdgeInsets.only(bottom: Sizes.dimen_20),
                            decoration: BoxDecoration(
                                color: AppColors.lightWhite,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(Sizes.dimen_30),
                                  topRight: Radius.circular(Sizes.dimen_30),
                                )
                            ),
                            child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Sizes.dimen_16,
                                      vertical: Sizes.dimen_8
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text(
                                        widget.product.title,
                                        style: TextStyle(
                                            color: AppColors.appBlack,
                                            fontSize: Sizes.dimen_16.sp,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      const SizedBox(height: Sizes.dimen_10),

                                      /**
                                       *  Description
                                       * **/
                                      Text(
                                        widget.product.description,
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: Sizes.dimen_12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.subTitleColor
                                        ),
                                      ),
                                      const SizedBox(height: Sizes.dimen_20),

                                      /**
                                       *  CTA Actions - Chat and Make Offer
                                       * **/
                                      SingleChildScrollView(
                                        child: Material(
                                          elevation: Sizes.dimen_5,
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(Sizes.dimen_20),
                                          child: Container(
                                            width: size.width,
                                            height: Sizes.dimen_150,
                                            padding: const EdgeInsets.all(Sizes.dimen_16),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Sizes.dimen_20),
                                                color: AppColors.lightWhite
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Selling For",
                                                  style: TextStyle(
                                                      color: AppColors.subTitleColor,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: Sizes.dimen_12.sp
                                                  ),
                                                ),
                                                const SizedBox(height: Sizes.dimen_10,),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "NGN${widget.product.price}",
                                                      style: TextStyle(
                                                          color: AppColors.primaryColor,
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: Sizes.dimen_16.sp
                                                      ),
                                                    ),

                                                    Text(
                                                      "Negotiable",
                                                      style: TextStyle(
                                                          color: AppColors.darkYellow,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: Sizes.dimen_14.sp
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: Sizes.dimen_24,),

                                                /**
                                                 *  Chat and Make an Offer Vendor
                                                 * **/

                                                Row(
                                                  children: [
                                                    /**
                                                     *  Chat Vendor
                                                     * **/
                                                    InkWell(
                                                      onTap: (){},
                                                      child: SizedBox(
                                                        width: size.width * .41.w,
                                                        child: Material(
                                                          borderRadius: BorderRadius.circular(Sizes.dimen_28),
                                                          color: AppColors.primaryColor,
                                                          child: SizedBox(
                                                            width: (size.width * .41.w) - Sizes.dimen_16.h, height:Sizes.dimen_45,
                                                            child: Center(
                                                              child: Text(
                                                                "Chat with Seller",
                                                                style: TextStyle(
                                                                  fontSize: Sizes.dimen_16.sp,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: AppColors.lightWhite,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: Sizes.dimen_10,),

                                                    /**
                                                     *  Make an Offer
                                                     * **/
                                                    InkWell(
                                                      onTap: (){},
                                                      child: SizedBox(
                                                        width: size.width * .41.w,
                                                        child: Container(
                                                          // width: Sizes.dimen_155,
                                                          width: (size.width * .41).w - Sizes.dimen_16.h,
                                                          height:Sizes.dimen_45,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(Sizes.dimen_28),
                                                            color: AppColors.lightWhite,
                                                            border: Border.all(
                                                                color: AppColors.primaryColor,
                                                                width: Sizes.dimen_2,
                                                                style: BorderStyle.solid
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "Make an offer",
                                                              style: TextStyle(
                                                                fontSize: Sizes.dimen_16.sp,
                                                                fontWeight: FontWeight.w500,
                                                                color: AppColors.primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            )
                        ),
                      ),

                    ],
                  ),
                )
            )
        )
    );
  }
  
}