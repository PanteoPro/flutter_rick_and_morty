import 'package:flutter/material.dart';

class NotifierProvider<Model extends ChangeNotifier> extends InheritedNotifier {
  NotifierProvider({
    Key? key,
    required Model model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<NotifierProvider<Model>>();
    final model = provider?.notifier as Model;
    return model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<NotifierProvider<Model>>()?.widget;
    return widget is NotifierProvider<Model> ? widget.notifier as Model : null;
  }
}

class Provider<Model> extends InheritedWidget {
  final Model model;
  Provider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(key: key, child: child);

  static Model? watch<Model>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<Provider<Model>>();
    final model = provider?.model;
    return model;
  }

  static Model? read<Model>(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<Provider<Model>>()?.widget;
    return widget is Provider<Model> ? widget.model : null;
  }

  @override
  bool updateShouldNotify(Provider oldWidget) {
    return model != oldWidget.model;
  }
}
