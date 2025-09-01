import 'package:dartz/dartz.dart';

import '../../../../core/FailureAndException/product_failure.dart';
import '../entity/cartData.dart';
import '../repository/repo.dart';

class CartUsecases{
  final CartRepo cartRepo;
  CartUsecases({required this.cartRepo});

  Future<Either<Failure,Unit>> addCart(CartData cartData){
    return cartRepo.addCart(cartData);
  }
  
  Future<Either<Failure,List<CartData>>> getCart(String userId){
    return cartRepo.getCart(userId);
  }
  
  Future<Either<Failure,Unit>> deleteCart(String id){
    return cartRepo.deleteCart(id);
  }
  
  Future<Either<Failure,Unit>> addProductToCart(String cartId, String productId){
    return cartRepo.addProductToCart(cartId, productId);
  }
  
  Future<Either<Failure,Unit>> deleteProductFromCart(String cartId, String productId){
    return cartRepo.deleteProductFromCart(cartId, productId);
  }
  
  Future<Either<Failure,Unit>> updateProductQuantity(String cartId, String productId, int quantity){
    return cartRepo.updateProductQuantity(cartId, productId, quantity);
  }
  

}