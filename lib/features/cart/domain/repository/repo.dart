import 'package:task9/core/FailureAndException/product_failure.dart';
import 'package:task9/features/cart/domain/entity/cartData.dart';
import 'package:dartz/dartz.dart';
abstract class CartRepo{
  Future<Either<Failure,Unit>> addCart(CartData cartData); 
  Future<Either<Failure,List<CartData>>> getCart(String userId);
  Future<Either<Failure,Unit>> deleteCart(String id);
  Future<Either<Failure,Unit>> addProductToCart(String cartId, String productId);
  Future<Either<Failure,Unit>> deleteProductFromCart(String cartId, String productId);
  Future<Either<Failure,Unit>> updateProductQuantity(String cartId, String productId, int quantity);
}