import 'package:stream_buzz/feature/home/data/data_resources/product_remote_data_source.dart';
import 'package:stream_buzz/feature/home/domain/entities/product_entity.dart';
import 'package:stream_buzz/feature/home/domain/services/product_service.dart';

class ProductServiceImpl implements ProductsService {
  final ProductRemoteDataSource dataSource;

  ProductServiceImpl(this.dataSource);

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    return await dataSource.getAllProducts();
  }
}