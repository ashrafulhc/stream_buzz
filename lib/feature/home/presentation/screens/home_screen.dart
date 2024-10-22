import 'package:flutter/material.dart';
import 'package:stream_buzz/feature/home/presentation/controllers/home_controller.dart';
import 'package:stream_buzz/feature/home/presentation/widgets/products_list.dart';
import 'package:stream_buzz/injection/injector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = getIt.get<HomeController>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Products',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: controller.getProductStatusStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if( snapshot.data == Status.initial ) {
              return const Text('Click to fetch the products');
            } else if(snapshot.data == Status.loading) {
              return const CircularProgressIndicator();
            } else if(snapshot.data == Status.failed) {
              return const Text('Failed to fetch products');
            } else if(snapshot.data == Status.success) {
              return StreamBuilder(stream: controller.getProductsStream, builder: (context, productSnapshot) {
                if (productSnapshot.hasData) {
                  return ProductsList(productItems: productSnapshot.data!);
                }
                return const SizedBox.shrink();
              });
            }
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.getAllProducts();
        },
        child: const Icon(Icons.download),
      ),
    );
  }
}
