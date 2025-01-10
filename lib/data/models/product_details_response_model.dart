class ProductDetailsResponseModel {
  bool success;
  String message;
  ProductDetails product;

  ProductDetailsResponseModel({
    required this.success,
    required this.message,
    required this.product,
  });

  factory ProductDetailsResponseModel.fromJson(Map<String, dynamic> json) => ProductDetailsResponseModel(
    success: json["success"],
    message: json["message"],
    product: ProductDetails.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "product": product.toJson(),
  };
}

class ProductDetails {
  String id;
  String vendorId;
  String title;
  String category;
  String subCategory;
  bool negotiable;
  String price;
  List<String> images;
  String vendorPhoneNumber;
  DateTime dateListed;
  String description;
  String brand;
  String model;
  String color;
  String type;

  ProductDetails({
    required this.id,
    required this.vendorId,
    required this.title,
    required this.category,
    required this.subCategory,
    required this.negotiable,
    required this.price,
    required this.images,
    required this.vendorPhoneNumber,
    required this.dateListed,
    required this.description,
    required this.brand,
    required this.model,
    required this.color,
    required this.type,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    id: json["_id"],
    vendorId: json["vendorId"],
    title: json["title"],
    category: json["category"],
    subCategory: json["subCategory"],
    negotiable: json["negotiable"],
    price: json["price"],
    images: List<String>.from(json["images"].map((x) => x)),
    vendorPhoneNumber: json["vendorPhoneNumber"],
    dateListed: DateTime.parse(json["dateListed"]),
    description: json["description"],
    brand: json["brand"],
    model: json["model"],
    color: json["color"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "vendorId": vendorId,
    "title": title,
    "category": category,
    "subCategory": subCategory,
    "negotiable": negotiable,
    "price": price,
    "images": List<dynamic>.from(images.map((x) => x)),
    "vendorPhoneNumber": vendorPhoneNumber,
    "dateListed": dateListed.toIso8601String(),
    "description": description,
    "brand": brand,
    "model": model,
    "color": color,
    "type": type,
  };
}