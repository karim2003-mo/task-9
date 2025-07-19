import 'package:task9/features/products/controller/entity/categories_model.dart';

import '../../../../core/FailureAndException/product_failure.dart';
// Product Events
  class ProductEvent{}
  class LoadingProductEvent extends ProductEvent{
    final int ? productId;
  LoadingProductEvent(this.productId);
  }
  class SuccessLoadingProductEvent extends ProductEvent{
    final Object productOrProducts;
    SuccessLoadingProductEvent({required this.productOrProducts});
  }
  class FailedLoadingProductEvent extends ProductEvent{
      final Failure  failure;
    FailedLoadingProductEvent({required this.failure});
  }
// Category Events
  class CategoryEvent{}
  class LoadingCategoryEvent extends CategoryEvent{
  LoadingCategoryEvent();
  }
  class SuccessLoadingCategoryEvent extends CategoryEvent{
    final List<CategoryModel> categories;
    SuccessLoadingCategoryEvent({required this.categories});
  }
  class FailedLoadingCategoryEvent extends CategoryEvent{
      final Failure  failure;
    FailedLoadingCategoryEvent({required this.failure});
  }