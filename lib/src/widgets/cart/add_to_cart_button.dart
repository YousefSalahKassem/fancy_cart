import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../fancy_cart.dart';

class AddToCartButton extends ConsumerWidget {
  final Widget child;
  final Function? actionAfterAdding;
  final Function? actionIfExist;
  final CartItem cartModel;


  const AddToCartButton({
    Key? key,
    required this.child,
    this.actionAfterAdding,
    this.actionIfExist,
    required this.cartModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref
            .read(CartNotifier.provider.notifier)
            .addItem(cartModel, actionIfExist: actionIfExist);
        if (actionAfterAdding != null) {
          actionAfterAdding!();
        }
      },
      child: child,
    );
  }
}
