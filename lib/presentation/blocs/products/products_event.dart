part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class GetAllProductsEvent extends ProductsEvent {

  final GetAllProductsParams params;
  const GetAllProductsEvent({required this.params});

  @override
  List<Object?> get props => [params];

}

class GetSingleProductEvent extends ProductsEvent {

  final GetProductDetailsParams params;
  const GetSingleProductEvent({required this.params});

  @override
  List<Object?> get props => [params];

}