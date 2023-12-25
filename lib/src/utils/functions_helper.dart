import 'package:fancy_cart/fancy_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void initializeFancyCart(
    {
    required Widget child,
    final List<ProviderObserver>? observers,
    final List<Override> overrides = const []
    }) async {
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('cart');
  runApp(ProviderScope(
    observers: observers,
    overrides: overrides,
    child: child,
  ));
}
