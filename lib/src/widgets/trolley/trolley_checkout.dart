import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../fancy_cart.dart';

class TrolleyCheckOut extends ConsumerWidget {
  final int shippingFee;
  final String? buttonText;
  final VoidCallback onCheckout;
  final Color? buttonColor;
  final Color? backgroundColor;
  final TextStyle? buttonTextStyle;
  final TextStyle? headerTextStyle;
  final TextStyle? subTotalTextStyle;
  final TextStyle? shippingTextStyle;
  final TextStyle? totalTextStyle;

  const TrolleyCheckOut({
    Key? key,
    required this.shippingFee,
    this.buttonText,
    required this.onCheckout,
    this.buttonColor,
    this.backgroundColor,
    this.buttonTextStyle,
    this.headerTextStyle,
    this.subTotalTextStyle,
    this.shippingTextStyle,
    this.totalTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(CartNotifier.provider);
    final cartNotifier = ref.watch(CartNotifier.provider.notifier);
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // items in cart
          children: [
            Text(
              "${cartNotifier.getNumberOfItemsInCart()} Items in cart",
              style: headerTextStyle ??
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Subtotal",
                  style: subTotalTextStyle ??
                      const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  "\$${cartNotifier.getTotalPrice()}",
                  style: subTotalTextStyle ??
                      const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            // divider
            Container(
              height: 1,
              color: Colors.grey,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shipping",
                    style: shippingTextStyle ??
                        const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "\$$shippingFee",
                    style: shippingTextStyle ??
                        const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            Container(
              height: 1,
              color: Colors.grey,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: totalTextStyle ??
                        const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "\$${cartNotifier.getTotalPrice() + shippingFee}",
                    style: totalTextStyle ??
                        const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Material(
              color: buttonColor ?? Colors.red,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: onCheckout,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    buttonText ?? "CHECKOUT",
                    style: buttonTextStyle ??
                        const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
