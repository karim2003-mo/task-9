import 'package:dartz/dartz.dart';
import 'package:task9/core/FailureAndException/product_failure.dart';
import 'package:task9/features/products/controller/entity/product_entity_model.dart';
import 'package:task9/features/products/controller/repositories/repo.dart';

import '../../../../core/FailureAndException/product_exception.dart';
import '../../../../core/Network_Info/networkInfo.dart';

class DataRepoImpl implements ProductRepo{
  final Networkinfo networkInfo;
  DataRepoImpl({required this.networkInfo});
  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProductModel>> getOneProduct() {
    // TODO: implement getOneProduct
    throw UnimplementedError();
  }
void handleResponse({int statusCode=0}) async{
  if(!await networkInfo.internetStatus){
    throw InternetConnectionException();
  }else{
  switch (statusCode) {
    case 400:
      throw const BadRequestException();
    case 401:
      throw const UnauthorizedException();
    case 403:
      throw const ForbiddenException();
    case 404:
      throw const NotFoundException();
    case 405:
      throw const MethodNotAllowedException();
    case 408:
      throw const RequestTimeoutException();
    case 429:
      throw const TooManyRequestsException();
    case 500:
      throw const InternalServerErrorException();
    case 502:
      throw const BadGatewayException();
    case 503:
      throw const ServiceUnavailableException();
    case 504:
      throw const GatewayTimeoutException();
    default:
      throw const UnknownServerException();
  }
  }
}
}