import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../fancy_cart.dart';


class ModalCheckOutButtons extends ConsumerWidget {
  final Widget Function(List<CartItem> cartList) checkOutButton;
  final Widget Function(List<CartItem> cartList) checkOutPaypalButton;
  const ModalCheckOutButtons({
    Key? key,
    required this.checkOutButton,
    required this.checkOutPaypalButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.watch(CartNotifier.provider);
    final cartList = ref.watch(CartNotifier.provider.notifier).cartList;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // modal checkout buttons
        checkOutButton(
          cartList,
        ),
        const SizedBox(
          height: 20,
        ),
        checkOutPaypalButton(
          cartList,
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Continue Shopping",
                  style: TextStyle(color: Colors.black),
                ))),
      ],
    );
  }
}
