import 'package:stream_buzz/feature/home/domain/entities/product_entity.dart';
import 'package:stream_buzz/feature/home/domain/services/product_service.dart';

final class GetAllProductsUseCase {
  final ProductsService _productsService;

  GetAllProductsUseCase(this._productsService);

  Future<List<ProductEntity>> run() async {
    return await _productsService.getAllProducts();
  }
}