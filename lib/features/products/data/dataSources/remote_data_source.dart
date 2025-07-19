import 'package:dio/dio.dart';
import '../../../../core/FailureAndException/product_exception.dart';
import '../../../../core/Network_Info/networkInfo.dart';
class RemoteDataSource{
  final Dio dio;
  final Networkinfo networkInfo;
  RemoteDataSource( {required this.dio , required this.networkInfo});
  Future<Map<String, dynamic>> getOneProducts({required int id}) async{
    if(await networkInfo.internetStatus==true){
    final response= await dio.get("https://dummyjson.com/products/${id.toString()}/");
    if(response.statusCode==200){
    final Map<String, dynamic> products= response.data;
    return products;
    }else{
      handleResponse(response.statusCode!);
    }
    }else{
      throw InternetConnectionException();
    }
    throw UnknownServerException();
  }
Future<Map<String, dynamic>> getAllProducts() async {
  if (await networkInfo.internetStatus == true) {
    try {
      final stopwatch = Stopwatch()..start();
      final response = await dio.get("https://dummyjson.com/products?limit=200&select=title,price,id,description,category,discountPercentage,rating,images,thumbnail");
        stopwatch.stop();
      if (response.statusCode == 200) {
        final Map<String, dynamic> products = response.data;
        print('Execution time: ${stopwatch.elapsedMilliseconds} ms');
        return products;
      }
      handleResponse(response.statusCode!);
    } on DioException catch (e) {

      if (e.response != null && e.response?.statusCode != null) {
        final code =e.response?.statusCode;
        handleResponse(code!);
      } else {
        throw UnknownServerException();
      }
    }
  } else {
    throw InternetConnectionException();
  }
  throw UnknownServerException();
}
Future<List> getAllCategories() async {
  if (await networkInfo.internetStatus == true) {
    try {
      final response = await dio.get("https://dummyjson.com/products/category-list/");
      if (response.statusCode == 200) {
        final List categories = response.data;
        return categories;
      }
      handleResponse(response.statusCode!);
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode != null) {
        final code =e.response?.statusCode;
        handleResponse(code!);
      } else {
        throw UnknownServerException();
      }
    }
  } else {
    throw InternetConnectionException();
  }
  throw UnknownServerException();
}
  void handleResponse(int statusCode){
  switch (statusCode) {
    case 400:
      throw  BadRequestException();
    case 401:
      throw  UnauthorizedException();
    case 403:
      throw  ForbiddenException();
    case 404:
      throw  NotFoundException();
    case 405:
      throw  MethodNotAllowedException();
    case 408:
      throw  RequestTimeoutException();
    case 429:
      throw  TooManyRequestsException();
    case 500:
      throw  InternalServerErrorException();
    case 502:
      throw  BadGatewayException();
    case 503:
      throw  ServiceUnavailableException();
    case 504:
      throw  GatewayTimeoutException();
    default:
      throw  UnknownServerException();
  }
  }
}
