import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:primed_health/data/models/error_response_model.dart';
import 'package:primed_health/data/models/product_details_response_model.dart';
import 'package:primed_health/data/models/product.dart';
import 'package:primed_health/data/models/products_response_model.dart';

import 'package:primed_health/domain/entities/get_all_products_params.dart';
import 'package:primed_health/domain/entities/get_product_details_params.dart';

import 'package:primed_health/domain/repositories/products_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {

  final ProductsRepository _repository;

  ProductsBloc({required ProductsRepository repository})
      : _repository = repository,
        super(ProductsStateInitial()) {
    on<GetAllProductsEvent>(_getAllProducts);
    on<GetSingleProductEvent>(_getSingleProduct);
  }

  _getAllProducts(GetAllProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsStateLoading());

    try {
      Response response = await _repository.getAllProducts(params: event.params);
      if(response.statusCode == 200){

        final responseModel = ProductsResponseModel.fromJson(jsonDecode(response.body));
        emit(ProductsStateGetAllProductsSuccess(products: responseModel.products ));

        log('responseModel.products all length:\t${responseModel.products.length}');

      } else {
        final failure = ErrorResponseModel.fromJson(jsonDecode(response.body));
        log('failure in bloc:\n${failure.message}');
        emit(ProductsStateFailure(errorMessage: failure.message));
      }
    } on SocketException {
      emit(const ProductsStateFailure(errorMessage: "No Internet Connection"));
    } catch (e){
      log('all products e.toString():\n${e.toString()}');
      emit(ProductsStateFailure(errorMessage: e.toString()));
    }
  }

  _getSingleProduct(GetSingleProductEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsStateDetailsLoading());

    try {
      Response response = await _repository.getProductDetails(params: event.params);
      if(response.statusCode == 200){

        final responseModel = ProductDetailsResponseModel.fromJson(jsonDecode(response.body));
        emit(ProductsStateGetSingleProductSuccess(product: responseModel.product ));

      } else {
        final failure = ErrorResponseModel.fromJson(jsonDecode(response.body));
        log('failure in bloc:\n${failure.message}');
        emit(ProductsStateFailure(errorMessage: failure.message));
      }
    } on SocketException {
      emit(const ProductsStateFailure(errorMessage: "No Internet Connection"));
    } catch (e){
      log('generic e:\n$e');
      emit(ProductsStateFailure(errorMessage: e.toString()));
    }
  }

}