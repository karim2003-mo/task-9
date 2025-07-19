import 'package:task9/core/FailureAndException/product_failure.dart';
import 'package:task9/features/products/controller/entity/categories_model.dart';
// Product States
  class ProductState{}
  class InitLoadingProductState extends ProductState{}
  class LoadingProductState extends ProductState{}
  class SuccessLoadingProductState extends ProductState{
    final Object productOrProducts;
    SuccessLoadingProductState({required this.productOrProducts});
  }
  class FailedLoadingProductState extends ProductState{
    final Failure  failure;
    FailedLoadingProductState({required this.failure});
  }
// Category State
  class CategoryState{}
  class InitLoadingCategoryState extends CategoryState{}
  class LoadingCategoryState extends CategoryState{}
  class SuccessLoadingCategoryState extends CategoryState{
    final List<CategoryModel> categories;
    SuccessLoadingCategoryState({required this.categories});
  }
  class FailedLoadingCategoryState extends CategoryState{
    final Failure  failure;
    FailedLoadingCategoryState({required this.failure});
  }