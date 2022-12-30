import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../bloc/providers/cart_notifier.dart';

void initializeFancyCart(
    {
    required Widget child,
    final List<ProviderObserver>? observers,
    final List<Override> overrides = const []
    }) async {
  await CartNotifier.initialize();
  runApp(ProviderScope(
    observers: observers,
    overrides: overrides,
    child: child,
  ));
}
