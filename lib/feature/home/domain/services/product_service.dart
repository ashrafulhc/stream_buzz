import 'package:stream_buzz/feature/home/domain/entities/product_entity.dart';

abstract interface class ProductsService {
  Future<List<ProductEntity>> getAllProducts();
}
