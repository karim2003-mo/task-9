import 'package:dartz/dartz.dart';
import 'package:task9/features/products/controller/entity/product_entity_model.dart';

import '../../../../core/FailureAndException/product_failure.dart';

abstract class ProductRepo{
  Future<Either<Failure , List<ProductModel>>> getAllProducts();
  Future<Either<Failure , ProductModel>> getOneProduct();
}