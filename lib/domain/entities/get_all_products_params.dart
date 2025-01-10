import 'package:equatable/equatable.dart';

class GetAllProductsParams extends Equatable {

  final String currentUserId;

  const GetAllProductsParams({
    required this.currentUserId
  });

  factory GetAllProductsParams.fromJson(Map<String, dynamic> json) => GetAllProductsParams(
    currentUserId: json["currentUserId"],
  );

  Map<String, dynamic> toJson() => {
    "currentUserId": currentUserId,
  };

  @override
  List<Object?> get props => [currentUserId];

}