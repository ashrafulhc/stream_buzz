import 'package:dio/dio.dart';
import 'package:stream_buzz/feature/home/domain/entities/product_entity.dart';

class ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSource(this.dio);

  Future<List<ProductEntity>> getAllProducts() async {
    try {
      final response = await dio.get('https://fakestoreapi.com/products');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ProductEntity.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Dio error: ${e.toString()}');
    }
  }
}