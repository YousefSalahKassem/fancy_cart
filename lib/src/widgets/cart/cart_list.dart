import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../fancy_cart.dart';

class CartWidget extends ConsumerWidget {
  final Widget Function(CartNotifier controller, List<CartItem> cart)
      cartBuilder;

  const CartWidget({Key? key, required this.cartBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(CartNotifier.provider);

    final cartList = controller.cartList;

    return cartBuilder(controller, cartList);
  }
}
