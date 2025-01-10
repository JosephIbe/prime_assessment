import 'package:flutter/material.dart';

import 'package:primed_health/common/asset_constants.dart';
import 'package:primed_health/common/size_constants.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:flutter_svg/flutter_svg.dart';

late Size size;

class MoreItem extends StatelessWidget {

  final String title;
  final String? description;
  final String assetPath;
  final Color bgColor;
  final VoidCallback onTap;

  const MoreItem({
    required this.title,
    this.description,
    required this.assetPath,
    required this.bgColor,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: AppColors.primaryColor.withOpacity(.2)
                      color: bgColor
                    ),
                    child: Center(
                      child: Container(
                        width: Sizes.dimen_24,
                        height: Sizes.dimen_24,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(assetPath)
                          )
                        ),
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
                          title,
                          style: TextStyle(
                              fontSize: Sizes.dimen_14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.subTitleColor
                          )
                      ),

                      Text(
                          description!,
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
    );
  }

}