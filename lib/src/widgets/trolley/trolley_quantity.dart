import '../../../fancy_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/cart_item.dart';

enum Direction { vertical, horizontal }

class TrolleyQuantity extends ConsumerWidget {
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsetsGeometry? iconPadding;
  final Color? iconBackgroundColor;
  final Color? backgroundQuantityColor;
  final CartItem cartItem;
  final TextStyle? quantityStyle;
  final Direction quantityCardDirection;
  final bool deleteItemWhenQuantityIsZero;
  final Function? onQuantityIsZero;
  final Function? onDecreaseQuantityToZero;

  const TrolleyQuantity({
    Key? key,
    this.quantityStyle,
    this.iconColor,
    this.iconSize,
    this.iconPadding,
    this.iconBackgroundColor,
    this.backgroundQuantityColor,
    this.quantityCardDirection = Direction.vertical,
    required this.cartItem,
    this.deleteItemWhenQuantityIsZero = true,
    this.onQuantityIsZero,
    this.onDecreaseQuantityToZero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.watch(CartNotifier.provider.notifier);
    if (quantityCardDirection == Direction.vertical) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          color: backgroundQuantityColor ?? Colors.red.withOpacity(0.3),
          child: Column(
            children: [
              // plus
              Container(
                padding: iconPadding ?? const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: iconBackgroundColor ?? Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: GestureDetector(
                  onTap: () {
                    cartNotifier.incrementItemQuantity(cartItem);
                  },
                  child: Icon(Icons.add,
                      color: iconColor ?? Colors.white, size: iconSize),
                ),
              ),

              // quantity
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  cartItem.quantity.toString(),
                  style: quantityStyle ??
                      const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ),

              // minus
              Container(
                padding: iconPadding ?? const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: iconBackgroundColor ?? Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: GestureDetector(
                  onTap: () {
                    cartNotifier.decrementItemQuantity(
                      cartItem,
                      deleteOption: deleteItemWhenQuantityIsZero,
                      actionAfterDelete: onQuantityIsZero,
                      notDecrementedAction: onDecreaseQuantityToZero,
                    );
                  },
                  child: Icon(
                    Icons.remove,
                    color: iconColor ?? Colors.white,
                    size: iconSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Material(
        color: backgroundQuantityColor ?? Colors.red.withOpacity(0.3),
        child: Row(
          children: [
            // minus
            Container(
              padding: iconPadding ?? const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child: GestureDetector(
                onTap: () {
                  cartNotifier.decrementItemQuantity(
                    cartItem,
                    deleteOption: deleteItemWhenQuantityIsZero,
                    actionAfterDelete: onQuantityIsZero,
                    notDecrementedAction: onDecreaseQuantityToZero,
                  );
                },
                child: Icon(
                  Icons.remove,
                  color: iconColor ?? Colors.white,
                  size: iconSize,
                ),
              ),
            ),
            // quantity
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 4),
              child: Text(
                cartItem.quantity.toString(),
                style: quantityStyle ??
                    const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
            // plus
            Container(
              padding: iconPadding ?? const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child: GestureDetector(
                onTap: () {
                  cartNotifier.incrementItemQuantity(cartItem);
                },
                child: Icon(Icons.add,
                    color: iconColor ?? Colors.white, size: iconSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
