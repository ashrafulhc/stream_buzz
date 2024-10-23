import 'package:stream_buzz/feature/home/domain/entities/product_entity.dart';
import 'package:stream_buzz/feature/home/presentation/controllers/home_controller.dart';

abstract class BaseHomeController {
  /// Product Stream
  Stream<List<ProductEntity>> get getProductsStream;

  /// Product Status Stream
  Stream<Status> get getProductStatusStream;

  /// Get all products (abstract method)
  Future<void> getAllProducts();

  /// Dispose method to close the streams
  void dispose();
}