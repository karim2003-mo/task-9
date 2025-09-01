
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task9/core/Network_Info/networkInfo.dart';
import 'package:task9/features/products/controller/repositories/repo.dart';
import 'package:task9/features/products/controller/useCases/products_usecase.dart';
import 'package:task9/features/products/data/dataSources/remote_data_source.dart';
import 'package:task9/features/products/data/repositories/data_repo.dart';
import 'package:task9/features/products/presentation/blocs/product_blocs.dart';

import '../features/auth/presentation/blocs/blocs.dart';

final sl = GetIt.instance;
setupLocator(){
  // UseCases
    sl.registerLazySingleton(()=>GetAllProductsUseCase(productRepo: sl()));
    sl.registerLazySingleton(()=>GetOneProductUseCase(productRepo: sl()));
    sl.registerLazySingleton(()=>GetAllCategoriesUseCase(productRepo:sl() ));
  // Repositories
    sl.registerLazySingleton<ProductRepo>(()=>DataRepoImpl(remoteDataSource: sl()));
  // Data Sources
    sl.registerLazySingleton(()=>RemoteDataSource(dio: sl(), networkInfo:sl()));
  // Core Dependecies
    sl.registerLazySingleton(()=>Networkinfo(connectionChecker:sl()));
  // External Packages
    sl.registerLazySingleton(()=>Dio());
    sl.registerLazySingleton(()=>InternetConnectionChecker.createInstance());
  // Blocs
    sl.registerFactory(()=>ProductBloc(getAllProductsUseCase:sl() , getOneProductUseCase: sl()));
    sl.registerFactory(()=>CategoryBloc(getAllCategoriesUseCase: sl()));
    sl.registerFactory(()=>AuthBloc());

}