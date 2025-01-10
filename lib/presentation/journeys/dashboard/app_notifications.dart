import 'package:flutter/material.dart';

import 'package:primed_health/common/size_constants.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:primed_health/presentation/widgets/circle_back_button.dart';
import 'package:primed_health/presentation/widgets/empty_state.dart';

late Size size;

class AppNotifications extends StatefulWidget {

  const AppNotifications({super.key,});

  @override
  State<AppNotifications> createState() => _AppNotificationsState();
}

class _AppNotificationsState extends State<AppNotifications> {

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(Sizes.dimen_80),
          child: Container(
            width: size.width,
            padding: const EdgeInsets.all(Sizes.dimen_16),
            color: AppColors.primaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleBackButton(),
                const SizedBox(width: Sizes.dimen_60,),

                Text(
                  "Notifications",
                  style: TextStyle(
                      color: AppColors.lightWhite,
                      fontSize: Sizes.dimen_24,
                      fontWeight: FontWeight.w700
                  ),
                ),
                const SizedBox(height: Sizes.dimen_10,),
              ],
            ),
          ),
        ),
        body: const EmptyState(title: "You have no offers or notifications yet",)
      ),
    );
  }

}