import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../bloc/providers/cart_notifier.dart';
class CartWidget extends ConsumerWidget {
  final Widget Function(CartNotifier controller) cartBuilder;

  const CartWidget({Key? key, required this.cartBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(CartNotifier.provider);
    final controller = ref.watch(CartNotifier.provider.notifier);
    return cartBuilder(controller);
  }
}
