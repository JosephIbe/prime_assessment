import 'package:primed_health/domain/entities/get_all_products_params.dart';
import 'package:primed_health/domain/entities/get_product_details_params.dart';

abstract class ProductsRepository {
  Future<dynamic> getAllProducts({required GetAllProductsParams params});
  Future<dynamic> getProductDetails({required GetProductDetailsParams params});
}