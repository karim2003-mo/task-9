import '../../domain/repository/repo.dart';
import 'package:dartz/dartz.dart';
import 'package:task9/core/FailureAndException/product_failure.dart';
import 'package:task9/features/cart/domain/entity/cartData.dart';

class CartRepoImpl implements CartRepo{
  @override
  Future<Either<Failure,Unit>> addCart(CartData cartData) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure,List<CartData>>> getCart(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure,Unit>> deleteCart(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure,Unit>> addProductToCart(String cartId, String productId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure,Unit>> deleteProductFromCart(String cartId, String productId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure,Unit>> updateProductQuantity(String cartId, String productId, int quantity) {
    throw UnimplementedError();
  }
}
  
