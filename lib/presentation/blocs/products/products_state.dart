part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];

}

class ProductsStateInitial extends ProductsState {}

class ProductsStateLoading extends ProductsState {}

class ProductsStateDetailsLoading extends ProductsState {}

class ProductsStateGetAllProductsSuccess extends ProductsState {

  final List<Product> products;
  const ProductsStateGetAllProductsSuccess({required this.products});

  @override
  List<Object> get props => [products];

}

class ProductsStateGetSingleProductSuccess extends ProductsState {

  final ProductDetails product;
  const ProductsStateGetSingleProductSuccess({required this.product});

  @override
  List<Object> get props => [product];

}

class ProductsStateFailure extends ProductsState {

  final String errorMessage;
  const ProductsStateFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

}