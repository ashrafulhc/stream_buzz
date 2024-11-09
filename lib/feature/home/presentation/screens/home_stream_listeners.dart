import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stream_buzz/feature/home/presentation/controllers/home_controller.dart';
import 'package:stream_buzz/feature/home/presentation/widgets/controller_scope/src/controller_scope.dart';

class HomeStreamListeners extends StatelessWidget {
  const HomeStreamListeners({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ControllerStreamListener<HomeController, Status>(
      stream: (controller) => controller.getProductStatusStream,
      onData: (data) {
        log(data.toString());
      },
      child: child,
    );
  }
}
