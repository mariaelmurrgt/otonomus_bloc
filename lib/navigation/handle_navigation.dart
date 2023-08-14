import 'package:flutter/material.dart';

class HandleNavigation {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<T?> push<T>(String routeName, {Object? arguments}) async {
    return await navigatorKey.currentState!.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState!.pop<T>(result);
  }

  static void pushReplacement<T extends Object?, TO extends Object?>(
      String routeName,
      {TO? result,
      Object? arguments}) {
    navigatorKey.currentState!.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
    );
  }

  static void pushNamedAndRemoveUntil<T extends Object?>(
      String routeName, bool Function(Route<dynamic>) predicate,
      {Object? arguments}) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  static void popUntil(bool Function(Route<dynamic>) predicate) {
    navigatorKey.currentState!.popUntil(predicate);
  }

  static void popUntilHome() {
    navigatorKey.currentState!
        .popUntil((route) => route.settings.name == '/home');
  }

  static void popUntilFirst() {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
