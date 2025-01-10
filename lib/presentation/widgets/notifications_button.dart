import 'package:primed_health/common/asset_constants.dart';
import 'package:primed_health/common/db_constants.dart';
import 'package:primed_health/common/route_constants.dart';
import 'package:primed_health/common/size_constants.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

class NotificationsButton extends StatefulWidget {

  final int notificationsCount;
  const NotificationsButton({super.key, required this.notificationsCount});

  @override
  State<NotificationsButton> createState() => _NotificationsButtonState();
}

class _NotificationsButtonState extends State<NotificationsButton> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> {
        Navigator.pushNamed(context, RouteLiterals.notificationsRoute)
      },
      child: Container(
        width: Sizes.dimen_40,
        height: Sizes.dimen_40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.tealColor
        ),
        child: Stack(
          children: [
            Positioned(
              top: 3,
              right: 1,
              child: Visibility(
                visible: widget.notificationsCount > 0,
                child: Container(
                  width: Sizes.dimen_14,
                  height: Sizes.dimen_14,
                  decoration: BoxDecoration(
                    color: AppColors.errorColor,
                    shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Text(
                      '${widget.notificationsCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.dimen_10
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SvgPicture.asset(AssetConstants.bell),
            )
          ],
        ),
      ),
    );

  }
}
