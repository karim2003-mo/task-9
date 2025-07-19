import 'package:dartz/dartz.dart';
import 'package:task9/core/FailureAndException/product_failure.dart';
import 'package:task9/features/products/controller/entity/categories_model.dart';
import 'package:task9/features/products/controller/entity/product_entity_model.dart';

import '../repositories/repo.dart';

class GetOneProductUseCase{
  final ProductRepo  productRepo;
  GetOneProductUseCase({required this.productRepo});
  Future<Either<Failure, ProductModel>> call({required int id}) async{
    return productRepo.getOneProduct(id: id);
  }
}
class GetAllProductsUseCase{
  final ProductRepo  productRepo;
  GetAllProductsUseCase({required this.productRepo});
  Future<Either<Failure, List<ProductModel>>> call() async{
    return productRepo.getAllProducts();
  }
}
class GetAllCategoriesUseCase{
  final ProductRepo  productRepo;
  GetAllCategoriesUseCase({required this.productRepo});
  Future<Either<Failure, List<CategoryModel>>> call() async{
    return productRepo.getAllCategories();
  }
}