import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../fancy_cart.dart';


class ModalHeader extends ConsumerStatefulWidget {

  const ModalHeader({Key? key}) : super(key: key);

  @override
  ConsumerState<ModalHeader> createState() => _ModalHeaderState();
}

class _ModalHeaderState extends ConsumerState<ModalHeader> {
  @override
  Widget build(BuildContext context) {
    ref.watch(CartNotifier.provider);
    final controller = ref.watch(CartNotifier.provider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black45,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Shopping Cart",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${controller.cartList.length} items",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700),
            ),
            GestureDetector(
                onTap: () {
                  ref.read(EditModalCartNotifier.provider.notifier).editClicked();
                  setState(() {});
                },
                child: Text("Edit",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade900,
                        decoration: TextDecoration.underline)))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 2,
          color: Colors.black,
        ),
      ],
    );
  }
}
