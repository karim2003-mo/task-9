import 'package:dio/dio.dart';
class RemoteDataSource{
  final Dio dio;
  RemoteDataSource(this.dio);
  Future<Map<String, dynamic>> getAllProducts() async{
    final response= await dio.get("https://dummyjson.com/products/");
    final Map<String, dynamic> products= response.data;
    return products;
  }
  Future<Map<String, dynamic>> getOneProducts(int id) async{
    final response= await dio.get("https://dummyjson.com/products/${id.toString()}/");
    final Map<String, dynamic> products= response.data;
    return products;
  }
}
