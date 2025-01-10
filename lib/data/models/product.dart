import 'package:equatable/equatable.dart';

class Product extends Equatable {

  String id;
  String title;
  String price;
  List<String> images;
  String description;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.images,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    title: json["title"],
    price: json["price"],
    images: List<String>.from(json["images"].map((x) => x)),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "images": List<dynamic>.from(images.map((x) => x)),
    "description": description,
  };

  @override
  List<Object?> get props => [];

}