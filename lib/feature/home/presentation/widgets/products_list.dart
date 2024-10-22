import 'package:flutter/material.dart';
import 'package:stream_buzz/feature/home/domain/entities/product_entity.dart';
import 'package:stream_buzz/feature/home/presentation/widgets/product_item_widget.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.productItems});

  final List<ProductEntity> productItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productItems.length,
      itemBuilder: (context, index) {
        final product = productItems[index];
        return ProductItemWidget(product: product);
      },
    );
  }
}
