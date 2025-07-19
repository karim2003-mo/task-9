import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task9/features/products/presentation/blocs/product_events.dart';
import 'package:task9/features/products/presentation/blocs/product_states.dart';

import '../../controller/useCases/products_usecase.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  final GetOneProductUseCase getOneProductUseCase;
  ProductBloc({required this.getAllProductsUseCase
  ,required this.getOneProductUseCase
  }):super(InitLoadingProductState()){
    on<LoadingProductEvent>(_loadingProductEvent);
    on<SuccessLoadingProductEvent>(_successLoadingProductEvent);
    on<FailedLoadingProductEvent>(_failedLoadingProductEvent);
  }

  FutureOr<void> _loadingProductEvent(LoadingProductEvent event, Emitter<ProductState> emit) async{
    emit(LoadingProductState());
      if(event.productId == null){
      await getAllProductsUseCase().then((val)=> val.fold(
        (failure){
          add(FailedLoadingProductEvent(failure: failure));
        } ,
        (success){
          add(SuccessLoadingProductEvent(productOrProducts: success));
        }
      ));
    }else{
      await getOneProductUseCase(id: event.productId!).then((val)=> val.fold(
        (failure){
          add(FailedLoadingProductEvent(failure: failure));
        } ,
        (success){
          add(SuccessLoadingProductEvent(productOrProducts: success));
        }
      ));
    }
  }

  FutureOr<void> _successLoadingProductEvent(SuccessLoadingProductEvent event, Emitter<ProductState> emit){
    emit(SuccessLoadingProductState(productOrProducts: event.productOrProducts));
  }

  FutureOr<void> _failedLoadingProductEvent(FailedLoadingProductEvent event, Emitter<ProductState> emit) {
    emit(FailedLoadingProductState(failure: event.failure));
  }
}
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;

  CategoryBloc({
    required this.getAllCategoriesUseCase,
  }) : super(InitLoadingCategoryState()) {
    on<LoadingCategoryEvent>(_loadingCategoryEvent);
    on<SuccessLoadingCategoryEvent>(_successLoadingCategoryEvent);
    on<FailedLoadingCategoryEvent>(_failedLoadingCategoryEvent);
  }

  FutureOr<void> _loadingCategoryEvent(LoadingCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(LoadingCategoryState());
      await getAllCategoriesUseCase().then((val) => val.fold(
            (failure) {
              add(FailedLoadingCategoryEvent(failure: failure));
            },
            (success) {
              add(SuccessLoadingCategoryEvent(categories: success));
            },
          ));

  }

  FutureOr<void> _successLoadingCategoryEvent(SuccessLoadingCategoryEvent event, Emitter<CategoryState> emit) {
    emit(SuccessLoadingCategoryState(categories: event.categories));
  }

  FutureOr<void> _failedLoadingCategoryEvent(FailedLoadingCategoryEvent event, Emitter<CategoryState> emit) {
    emit(FailedLoadingCategoryState(failure: event.failure));
  }
}