import 'package:flutter/material.dart';
import 'package:stream_buzz/feature/home/presentation/controllers/home_controller.dart';
import 'package:stream_buzz/feature/home/presentation/screens/home_stream_listeners.dart';
import 'package:stream_buzz/feature/home/presentation/widgets/controller_scope/controller_scope.dart';
import 'package:stream_buzz/feature/home/presentation/widgets/products_list.dart';
import 'package:stream_buzz/injection/injector.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ControllerScope<HomeController>(
      controller: getIt(),
      child: HomeStreamListeners(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text(
              'Products',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: const HomeBody(),
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton(
              onPressed: () => context.find<HomeController>().getAllProducts(),
              child: const Icon(Icons.download),
            );
          }),
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.find<HomeController>().getProductStatusStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == Status.initial) {
            return const Text('Click to fetch the products');
          } else if (snapshot.data == Status.loading) {
            return const CircularProgressIndicator();
          } else if (snapshot.data == Status.failed) {
            return const Text('Failed to fetch products');
          } else if (snapshot.data == Status.success) {
            return StreamBuilder(
                stream: context.find<HomeController>().getProductsStream,
                builder: (context, productSnapshot) {
                  if (productSnapshot.hasData) {
                    return ProductsList(productItems: productSnapshot.data!);
                  }
                  return const SizedBox.shrink();
                });
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
