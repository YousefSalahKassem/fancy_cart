import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../fancy_cart.dart';

class ModalSubTotal extends ConsumerWidget {
  const ModalSubTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(CartNotifier.provider.notifier);
    return Column(
      children: [
        Consumer(builder: (_, ref, __) {
          ref.watch(CartNotifier.provider);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Sub total",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Text(
                "\$${controller.getTotalPrice()}",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          );
        }),
        const SizedBox(
          height: 10,
        ),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "(Total does not include shipping)",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
