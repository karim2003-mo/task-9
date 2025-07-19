// ignore_for_file: type_literal_in_constant_pattern, empty_catches
import 'package:dartz/dartz.dart';
import 'package:task9/core/FailureAndException/product_exception.dart';
import 'package:task9/core/FailureAndException/product_failure.dart';
import 'package:task9/features/products/controller/entity/categories_model.dart';
import 'package:task9/features/products/controller/entity/productManager.dart';
import 'package:task9/features/products/controller/entity/product_entity_model.dart';
import 'package:task9/features/products/controller/repositories/repo.dart';
import 'package:task9/features/products/data/dataSources/remote_data_source.dart';
import 'package:task9/features/products/data/models/Catagory_data_model.dart';

import '../models/productData.dart';


class DataRepoImpl implements ProductRepo{
  final RemoteDataSource remoteDataSource;
  DataRepoImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async{
    try{
      final List<ProductModel> listOfProducts=[]; 
      final allProducts=await remoteDataSource.getAllProducts();
      for(Map<String , dynamic> product in allProducts["products"]){
        listOfProducts.add(ProductData.fromJson(product));
      }
      return Right(listOfProducts);
    }
    on InternetConnectionException{
      return Left(InternetFailure());
    }
    on ServerException catch(e){
      return Left(handleFailure(e));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getOneProduct({required int id}) async{
    try{
      final product=await remoteDataSource.getOneProducts(id: id);
      return Right(ProductData.fromJson(product));
    }on InternetConnectionException{
      return Left(InternetFailure());
    }
    on ServerException catch(e){
      return Left(handleFailure(e));
    }
  }
  @override
  Future<Either<Failure, List<CategoryModel>>> getAllCategories() async{
    try{
      Failure ? catfailure;
      final List<CategoryModel> categories=[];
      final results = await Future.wait([
              remoteDataSource.getAllCategories(),
              getAllProducts(),
          ]);
      final allCategories=results[0];
      final allProducts=results[1];
      for (String category in (allCategories as List )){
        (allProducts as Either<Failure, List<ProductModel>>).fold((failure){
          catfailure=failure;
        }, (success){
          Productmanager.allProducts=success;
          final relatedProducts=success.where((product)=>product.category==category).toList();
          print(relatedProducts.length);
          if(relatedProducts.isEmpty){
            return;
          }
          categories.add(CatagoryDataModel.fromJson({
        'name': category,
        'numberOfProducts':relatedProducts.length ,
        'image': relatedProducts[0].images,
        'thumbnail': relatedProducts[0].thumbnail,
      }));
        });
        if(catfailure != null){
          return Left(catfailure!);
        }
      }
    return Right(categories);
    }on InternetConnectionException{
      return Left(InternetFailure());
    }
    on ServerException catch(e){
      return Left(handleFailure(e));
    } 
  }
Failure handleFailure(ServerException exception) {
  if (exception is BadRequestException) return BadRequestFailure();
  if (exception is UnauthorizedException) return UnauthorizedFailure();
  if (exception is ForbiddenException) return ForbiddenFailure();
  if (exception is NotFoundException) return NotFoundFailure();
  if (exception is MethodNotAllowedException) return MethodNotAllowedFailure();
  if (exception is RequestTimeoutException) return RequestTimeoutFailure();
  if (exception is TooManyRequestsException) return TooManyRequestsFailure();
  if (exception is InternalServerErrorException) return InternalServerErrorFailure();
  if (exception is BadGatewayException) return BadGatewayFailure();
  if (exception is ServiceUnavailableException) return ServiceUnavailableFailure();
  if (exception is GatewayTimeoutException) return GatewayTimeoutFailure();

  return UnknownErrorFailure();
}
}