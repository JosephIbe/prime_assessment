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
  late int productsCount = 0;
  
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

                  if(state is ProductsStateGetAllProductsSuccess){
                    log('products.length:\t${state.products.length}');

                    setState(() {
                      productsCount = state.products.length;
                      productsList = state.products;
                    });
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
                      color: AppColors.lightWhite,
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
                                                color: AppColors.primaryColor,
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
                                              color: AppColors.primaryColor,
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

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Popular Items",
                            style: TextStyle(
                                fontSize: Sizes.dimen_12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.appBlack
                            ),
                          ),

                          GestureDetector(
                            onTap: ()=> Navigator.pushNamed(context, RouteLiterals.productDetailsRoute, arguments: productsList),
                            child: Text(
                              "View All",
                              style: TextStyle(
                                  fontSize: Sizes.dimen_12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.appBlack
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_10,),
                  ],
                ),
              ),

              productsCount > 0 ? SliverGrid.builder(
                itemCount: productsCount < 10 ? productsCount : 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1/1.2,
                ),
                itemBuilder: (context, int? index){
                  return ProductItem(product: productsList[index!]);
                },
                // ),
              ) : const SliverToBoxAdapter(
                child: EmptyState(title: "Nothing to display"),
              ),
            ]
          )
        ),
      ),
    );
  }

}