import 'dart:developer';

import 'package:rxdart/rxdart.dart';
import 'package:stream_buzz/feature/home/domain/entities/product_entity.dart';
import 'package:stream_buzz/feature/home/domain/usecases/get_all_products_usecase.dart';
import 'package:stream_buzz/feature/home/presentation/controllers/home_base_controller.dart';

class HomeController extends BaseHomeController {
  final GetAllProductsUseCase _getAllProductsUseCase;

  HomeController(this._getAllProductsUseCase);

  /// Product stream
  final _products = BehaviorSubject<List<ProductEntity>>.seeded([]);

  @override
  Stream<List<ProductEntity>> get getProductsStream => _products.stream;

  /// Product Status stream
  final _productsStatus = BehaviorSubject<Status>.seeded(Status.initial);

  @override
  Stream<Status> get getProductStatusStream => _productsStatus.stream;

  /// Get all products
  @override
  Future<void> getAllProducts() async {
    try {
      _productsStatus.sink.add(Status.loading);
      await Future.delayed(const Duration(seconds: 2));
      final response = await _getAllProductsUseCase.run();
      _products.sink.add(response);
      _productsStatus.sink.add(Status.success);
    } catch (e) {
      log('Products Fetching failed: ${e.toString()}');
      _productsStatus.sink.add(Status.failed);
    }
  }

  /// Dispose all the streams here
  @override
  void dispose() {
    _products.close();
    _productsStatus.close();
  }
}

enum Status { initial, loading, success, failed }
