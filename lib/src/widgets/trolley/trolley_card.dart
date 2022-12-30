import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_cart/fancy_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../bloc/providers/cart_notifier.dart';


class TrolleyCard extends ConsumerWidget {
  final CartItem cartItem;
  final EdgeInsetsGeometry? cardPadding;
  final Color? cardColor;
  final double? cardRadius;
  final bool haveShadow;
  final double? imageHeight;
  final double? imageWidth;
  final BoxFit? imageFit;
  final EdgeInsetsGeometry? imagePadding;
  final Widget? imagePlaceholder;
  final Widget? imageErrorWidget;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? nameStyle;
  final TextStyle? priceStyle;
  final TextStyle? quantityStyle;
  final EdgeInsetsGeometry? contentMargin;
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsetsGeometry? iconPadding;
  final Color? iconBackgroundColor;
  final Color? backgroundQuantityColor;
  final Direction? quantityCardDirection;
  final bool updateItemPrice;
  final bool deleteItemWhenQuantityIsZero;
  final Function? onQuantityIsZero;
  final Function? onDecreaseQuantityToZero;
  const TrolleyCard({
    Key? key,
    required this.cartItem,
    this.cardPadding,
    this.cardColor,
    this.cardRadius,
    this.haveShadow = true,
    this.updateItemPrice = false,
    this.imageHeight,
    this.imageWidth,
    this.imageFit,
    this.imagePadding,
    this.imagePlaceholder,
    this.imageErrorWidget,
    this.contentPadding,
    this.nameStyle,
    this.priceStyle,
    this.quantityStyle,
    this.contentMargin,
    this.iconColor,
    this.iconSize,
    this.iconPadding,
    this.iconBackgroundColor,
    this.backgroundQuantityColor,
    this.quantityCardDirection,
    this.deleteItemWhenQuantityIsZero = true,
    this.onQuantityIsZero,
    this.onDecreaseQuantityToZero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.watch(CartNotifier.provider.notifier);

    return Container(
      margin: cardPadding ?? const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardColor ?? Colors.white,
        borderRadius: BorderRadius.circular(cardRadius ?? 10),
        boxShadow: haveShadow
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  // show from bottom
                  offset: const Offset(0, 3),
                  blurRadius: 5,
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          // image
          Container(
            height: imageHeight ?? 100,
            width: imageWidth ?? 100,
            padding: imagePadding ?? const EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(cardRadius ?? 10),
                bottomLeft: Radius.circular(cardRadius ?? 10),
              ),
              image: DecorationImage(
                image: CachedNetworkImageProvider(cartItem.image),
                fit: imageFit ?? BoxFit.cover,
              ),
            ),
          ),
          // name and price
          Expanded(
            child: Padding(
              padding: contentMargin ?? const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.name,
                    style: nameStyle ?? const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$${cartNotifier.getPriceForItem(cartItem,updatePrice: updateItemPrice)}',
                    style: priceStyle ?? const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // quantity
          TrolleyQuantity(
              cartItem: cartItem,
              quantityStyle: quantityStyle,
              iconColor: iconColor,
              iconSize: iconSize,
              iconPadding: iconPadding,
              iconBackgroundColor: iconBackgroundColor,
              backgroundQuantityColor: backgroundQuantityColor,
              quantityCardDirection: quantityCardDirection ?? Direction.horizontal,
          ),
        ],
      ),
    );
  }
}
