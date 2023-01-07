import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../fancy_cart.dart';

class ShoppingCartTrolley extends ConsumerWidget {
  final bool swipeToDelete;
  final EdgeInsetsGeometry? cardPadding;
  final IconData? deleteIcon;
  final Color? deleteIconColor;
  final double? deleteIconSize;
  final EdgeInsetsGeometry? deleteIconPadding;
  final Color? deleteIconBackgroundColor;
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
  final Direction?quantityCardDirection;
  final bool updateItemPrice;
  final bool deleteItemWhenQuantityIsZero;
  final Function? onQuantityIsZero;
  final Function? onDecreaseQuantityToZero;

  const ShoppingCartTrolley({
    Key? key,
    this.swipeToDelete = true,
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
    this.deleteIcon,
    this.deleteIconColor,
    this.deleteIconSize,
    this.deleteIconPadding,
    this.deleteIconBackgroundColor,
    this.deleteItemWhenQuantityIsZero = true,
    this.onQuantityIsZero,
    this.onDecreaseQuantityToZero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.watch(CartNotifier.provider.notifier);
    final cartList = ref.watch(CartNotifier.provider).cartList;
    return Expanded(
      // swipe to delete
      child: ListView.builder(
        itemCount: cartList.length,
        itemBuilder: (context, index) {
          if (swipeToDelete) {
            return Dismissible(
              direction: DismissDirection.endToStart,
              key: Key(cartList[index].id.toString()),
              onDismissed: (direction) {
                cartNotifier.removeItem(cartList[index]);
              },
              background: Container(
                padding: deleteIconPadding ?? const EdgeInsets.only(left: 200),
                color: deleteIconBackgroundColor ?? Colors.red,
                child: Icon(
                  deleteIcon ?? Icons.delete,
                  color: deleteIconColor ?? Colors.white,
                  size: deleteIconSize,
                ),
              ),
              child: TrolleyCard(
                  cartItem: cartList[index],
                  cardPadding: cardPadding,
                  cardColor: cardColor,
                  cardRadius: cardRadius,
                  haveShadow: haveShadow,
                  imageHeight: imageHeight,
                  imageWidth: imageWidth,
                  imageFit: imageFit,
                  imagePadding: imagePadding,
                  imagePlaceholder: imagePlaceholder,
                  imageErrorWidget: imageErrorWidget,
                  contentPadding: contentPadding,
                  nameStyle: nameStyle,
                  priceStyle: priceStyle,
                  quantityStyle: quantityStyle,
                  contentMargin: contentMargin,
                  iconColor: iconColor,
                  iconSize: iconSize,
                  iconPadding: iconPadding,
                  iconBackgroundColor: iconBackgroundColor,
                  backgroundQuantityColor: backgroundQuantityColor,
                  quantityCardDirection: quantityCardDirection ?? Direction.horizontal,
              ),
            );
          }
          return TrolleyCard(
            cartItem: cartList[index],
            cardPadding: cardPadding,
            cardColor: cardColor,
            cardRadius: cardRadius,
            haveShadow: haveShadow,
            imageHeight: imageHeight,
            imageWidth: imageWidth,
            imageFit: imageFit,
            imagePadding: imagePadding,
            imagePlaceholder: imagePlaceholder,
            imageErrorWidget: imageErrorWidget,
            contentPadding: contentPadding,
            nameStyle: nameStyle,
            priceStyle: priceStyle,
            quantityStyle: quantityStyle,
            contentMargin: contentMargin,
            iconColor: iconColor,
            iconSize: iconSize,
            iconPadding: iconPadding,
            iconBackgroundColor: iconBackgroundColor,
            backgroundQuantityColor: backgroundQuantityColor,
            quantityCardDirection: quantityCardDirection ?? Direction.horizontal,
          );
        },
      ),
    );
  }
}

// trolley card

