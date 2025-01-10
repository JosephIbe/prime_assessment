import 'package:equatable/equatable.dart';

class GetProductDetailsParams extends Equatable {

  final String productId;

  const GetProductDetailsParams({
    required this.productId
  });

  Map<String, dynamic> toJson() => {
    "productId": productId
  };

  @override
  List<Object?> get props => [productId];

}