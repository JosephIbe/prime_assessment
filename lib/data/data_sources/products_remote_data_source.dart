import 'package:primed_health/data/core/api_client.dart';
import 'package:primed_health/data/core/api_constants.dart';

import 'package:primed_health/domain/entities/get_all_products_params.dart';
import 'package:primed_health/domain/entities/get_product_details_params.dart';

abstract class ProductsRemoteDataSource {
  Future<dynamic> getAllProducts({required GetAllProductsParams params});
  Future<dynamic> getProductDetails({required GetProductDetailsParams params});
}

class ProductsRemoteDataSourceImpl extends ProductsRemoteDataSource {

  final APIClient client;
  ProductsRemoteDataSourceImpl({required this.client});

  @override
  Future getAllProducts({required GetAllProductsParams params}) async {
    return await client.getAllProducts(pathSegment: APIConstants.getAllProducts, params: params);
  }

  @override
  Future getProductDetails({required GetProductDetailsParams params}) async {
    return await client.getProductDetails(pathSegment: APIConstants.getSingleProduct, params: params);
  }

}