import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_buzz/feature/home/data/data_resources/product_remote_data_source.dart';
import 'package:stream_buzz/feature/home/data/services/product_service_impl.dart';
import 'package:stream_buzz/feature/home/domain/services/product_service.dart';
import 'package:stream_buzz/feature/home/domain/usecases/get_all_products_usecase.dart';
import 'package:stream_buzz/feature/home/presentation/controllers/home_controller.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  /// controllers
  getIt.registerFactory<HomeController>(() => HomeController(getIt.get()));

  /// UseCases
  getIt.registerFactory<GetAllProductsUseCase>(() => GetAllProductsUseCase(getIt.get()));

  /// Services
  getIt.registerFactory<ProductsService>(() => ProductServiceImpl(getIt.get()));

  /// Data Sources
  getIt.registerFactory<ProductRemoteDataSource>( () => ProductRemoteDataSource(Dio()));
}