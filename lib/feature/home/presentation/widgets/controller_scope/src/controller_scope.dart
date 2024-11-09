import 'dart:async';
import 'package:flutter/material.dart';

abstract class BaseController {
  void dispose();
}

class ControllerScope<T extends BaseController> extends StatefulWidget {
  const ControllerScope({
    super.key,
    required this.controller,
    this.autoDisposable = true,
    required this.child,
  });

  final T controller;
  final Widget child;
  final bool autoDisposable;

  static T of<T extends BaseController>(BuildContext context) {
    final _InheritedControllerScope<T>? scope = context
        .dependOnInheritedWidgetOfExactType<_InheritedControllerScope<T>>();
    assert(scope != null,
        'No ControllerScope<$T> found in context. Make sure to wrap your widget tree with ControllerScope.');
    return scope!.controller;
  }

  @override
  State<ControllerScope<T>> createState() => _ControllerScopeState<T>();
}

class _ControllerScopeState<T extends BaseController>
    extends State<ControllerScope<T>> {
  @override
  void dispose() {
    if (widget.autoDisposable) {
      widget.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedControllerScope<T>(
      controller: widget.controller,
      child: widget.child,
    );
  }
}

class _InheritedControllerScope<T extends BaseController>
    extends InheritedWidget {
  const _InheritedControllerScope({
    required super.child,
    required this.controller,
  });

  final T controller;

  @override
  bool updateShouldNotify(_InheritedControllerScope<T> oldWidget) {
    return oldWidget.controller != controller;
  }
}

extension BuildContextExtension on BuildContext {
  T find<T extends BaseController>() {
    return ControllerScope.of<T>(this);
  }
}

class ControllerStreamListener<TController extends BaseController, TStream>
    extends StatefulWidget {
  const ControllerStreamListener({
    super.key,
    required this.stream,
    required this.child,
    required this.onData,
    this.onError,
    this.onDone,
    this.cancelOnError,
  });

  final Widget child;
  final Stream<TStream> Function(TController) stream;
  final void Function(TStream) onData;
  final Function? onError;
  final void Function()? onDone;
  final bool? cancelOnError;

  @override
  State<ControllerStreamListener<TController, TStream>> createState() =>
      _ControllerStreamListenerState<TController, TStream>();
}

class _ControllerStreamListenerState<TController extends BaseController,
    TStream> extends State<ControllerStreamListener<TController, TStream>> {
  StreamSubscription<TStream>? _subscription;

  void _subscribeToStream() {
    final controller = context.find<TController>();
    final stream = widget.stream(controller);
    _subscription = stream.listen(
      widget.onData,
      onError: widget.onError,
      onDone: widget.onDone,
      cancelOnError: widget.cancelOnError,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Dispose of any existing subscription before creating a new one.
    _subscription?.cancel();
    _subscribeToStream();
  }

  @override
  void didUpdateWidget(
      ControllerStreamListener<TController, TStream> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.stream != widget.stream) {
      _subscription?.cancel();
      _subscribeToStream();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
