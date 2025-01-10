import 'package:primed_health/data/models/product.dart';

class ProductsResponseModel {

  bool success;
  String message;
  List<Product> products;

  ProductsResponseModel({
    required this.success,
    required this.message,
    required this.products,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) => ProductsResponseModel(
    success: json["success"],
    message: json["message"],
    // products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    products: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}