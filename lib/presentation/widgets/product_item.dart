import 'package:flutter/material.dart';

import 'package:primed_health/common/size_constants.dart';
import 'package:primed_health/common/route_constants.dart';

import 'package:primed_health/data/models/product.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

class ProductItem extends StatefulWidget {

  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, RouteLiterals.productDetailsRoute, arguments: widget.product);
      },
      child: Material(
        color: Colors.white,
        elevation: Sizes.dimen_2,
        type: MaterialType.card,
        borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_8.r)),
        child: Container(
          width: Sizes.dimen_166,
          padding: const EdgeInsets.all(Sizes.dimen_5),
          margin: const EdgeInsets.only(bottom: Sizes.dimen_1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_8.r)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Sizes.dimen_120,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10)),
                ),
                child: FancyShimmerImage(
                  imageUrl: widget.product.images[0],
                  width: Sizes.dimen_166,
                  height: Sizes.dimen_100,
                ),
              ),
              const SizedBox(height: Sizes.dimen_10),

              Padding(
                padding: const EdgeInsets.all(Sizes.dimen_5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "NGN ${widget.product.price}",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.dimen_12
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_5),

                    Text(
                      widget.product.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColors.grey700,
                          fontWeight: FontWeight.w400,
                          fontSize: Sizes.dimen_14
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_10),

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

}