import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:primed_health/common/asset_constants.dart';
import 'package:primed_health/common/db_constants.dart';
import 'package:primed_health/common/size_constants.dart';
import 'package:primed_health/common/text_constants.dart';
import 'package:primed_health/common/route_constants.dart';

import 'package:primed_health/data/models/product.dart';

import 'package:primed_health/domain/entities/get_all_products_params.dart';

import 'package:primed_health/presentation/blocs/products/products_bloc.dart';

import 'package:primed_health/presentation/theme/colors.dart';

import 'package:primed_health/presentation/widgets/notifications_button.dart';
import 'package:primed_health/presentation/widgets/product_item.dart';
import 'package:primed_health/presentation/widgets/empty_state.dart';

import 'package:hive/hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  late Size size;

  late List<Product> productsList = [];
  
  @override
  void initState() {
    super.initState();
    
    final productsParams = GetAllProductsParams(currentUserId: Hive.box(DBConstants.appBoxName).get(DBConstants.userId));
    context.read<ProductsBloc>().add(GetAllProductsEvent(params: productsParams));
    
  }

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: MultiBlocListener(
          listeners: [
            BlocListener<ProductsBloc, ProductsState>(
              listener: (context, state) {
                if(state is ProductsStateFailure){

                  log('state.errorMessage fetching products:\n${state.errorMessage}');

                  Flushbar(
                    flushbarPosition: FlushbarPosition.TOP,
                    duration: const Duration(milliseconds: 7500),
                    backgroundColor: Colors.red,
                    title: 'Error Fetching Data',
                    icon: const Icon(Icons.error_outline),
                    message: state.errorMessage,
                    ).show(context);
                }
              }
            ),
          ],
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Sizes.dimen_175,
                      width: size.width,
                      padding: const EdgeInsets.fromLTRB(Sizes.dimen_16, Sizes.dimen_32, Sizes.dimen_16,Sizes.dimen_16),
                      color: AppColors.primaryColor,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(width: Sizes.dimen_10,),

                                          Text(
                                            "Welcome,\t",
                                            style: TextStyle(
                                                color: AppColors.lightWhite,
                                                fontSize: Sizes.dimen_12.sp,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),

                                          SvgPicture.asset(AssetConstants.okayEmoji),
                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left: Sizes.dimen_10),
                                        child: Text(
                                          Hive.box(DBConstants.appBoxName).get(DBConstants.firstName) ?? "User",
                                          style: TextStyle(
                                              color: AppColors.lightWhite,
                                              fontWeight: FontWeight.w700,
                                              fontSize: Sizes.dimen_16.sp
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              ),

                              const NotificationsButton(notificationsCount: 0)
                            ],
                          ),
                          const SizedBox(height: Sizes.dimen_25,),
                        ],
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_20,),
                  ],
                ),
              ),
            ]
          )
        ),
      ),
    );
  }

}