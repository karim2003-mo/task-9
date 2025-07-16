import 'package:dartz/dartz.dart';
import 'package:task9/core/FailureAndException/product_failure.dart';
import 'package:task9/features/products/controller/entity/product_entity_model.dart';

import '../repositories/repo.dart';

class GetOneProductUseCase{
  final ProductRepo  productRepo;
  GetOneProductUseCase({required this.productRepo});
  Future<Either<Failure, ProductModel>> call() async{
    return productRepo.getOneProduct();
  }
}
class GetAlleProductsUseCase{
  final ProductRepo  productRepo;
  GetAlleProductsUseCase({required this.productRepo});
  Future<Either<Failure, List<ProductModel>>> call() async{
    return productRepo.getAllProducts();
  }
}