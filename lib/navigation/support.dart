import 'package:flutter/material.dart';
import 'package:honestorage/navigation/delegate.dart';

extension NavigationSupport on BuildContext {
  HonestRouterDelegate get delegate {
    return Router.of(this).routerDelegate as HonestRouterDelegate;
  }
}
