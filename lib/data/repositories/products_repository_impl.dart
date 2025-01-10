import 'dart:developer';

import 'package:primed_health/data/data_sources/products_remote_data_source.dart';

import 'package:primed_health/domain/entities/get_all_products_params.dart';
import 'package:primed_health/domain/entities/get_product_details_params.dart';

import 'package:primed_health/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl extends ProductsRepository {

  final ProductsRemoteDataSource dataSource;
  ProductsRepositoryImpl({required this.dataSource});

  @override
  Future getAllProducts({required GetAllProductsParams params}) async {
    return await dataSource.getAllProducts(params: params);
  }

  @override
  Future getProductDetails({required GetProductDetailsParams params}) async {
    final response = await dataSource.getProductDetails(params: params);
    log('get product details response in repo impl:\n$response');
    return response;
  }

}